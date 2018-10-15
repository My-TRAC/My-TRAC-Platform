import FileHandlers.FileDriver;
import Models.ActivityStatistic;
import MySQLHandlers.MySQLDriver;
import MySQLHandlers.SQLConnection;
import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import org.apache.commons.lang3.tuple.ImmutablePair;
import org.apache.commons.lang3.tuple.Pair;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Thread.sleep;


public class CreateRatingsModel {

    //THIS PART OF THE CODE HELPS HANDLING THE ARGUMENTS REQUIRED BY THE APPLICATION
    public static class Arguments {
        @Parameter(names = {"-db", "--database"}, description = "Database name", required = false)
        public String database="HandsOnTest";

        @Parameter(names = {"-ip", "--ip"}, description = "MySQL server ip", required = false)
        public String ip="localhost:3306";

        @Parameter(names = {"-u", "--user","--username"}, description = "DB username", required = false)
        public String user = "root";

        @Parameter(names = {"-pw", "--password"}, description = "DB password", required = false)
        public String pw = "secret";

        @Parameter(names ={"-f","--file"}, description = "CSV Filepath",required = true)
        public String CSVFilePath ="";


        @Parameter(names ={"-m","--mode"}, description = "Load mode [mysql/csv",required = true)
        public String mode="";


        @Parameter(names = "--help,-help", help = true)
        private boolean help;
    }


    static Connection connection = null;
    static ActivityStatistic lastActivityStatistic = null;
    static Arguments arguments = new Arguments();
    private static final String resultTableName= "ActivitiesSummary";

    public static void main (String[] args) throws IOException, InterruptedException {
        //Handle the program arguments
        JCommander.newBuilder().addObject(arguments).build().parse(args);

        if( arguments.mode.equals("mysql")){
            loadCSVToMysql();

            //Prepare MySQL to receive results
            createTable(resultTableName);

        }
        Map<Integer, Map<Integer,List<Double>>> ratings = getRatings();
        modelRatings(ratings);
    }

    //Read the CSV file and load into "ratings" table.
    private static void loadCSVToMysql() throws InterruptedException, IOException {
        connectMySQL();
        createTable("ratings");
        fillTable();
    }

    private static void connectMySQL() throws InterruptedException {
        //Deploy MySQL
        //docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=HandsOnTest mysql:5

        connection = SQLConnection.getConnection(arguments.ip,arguments.database,arguments.user,arguments.pw);
        System.out.println("Connection to MYSQL established");
    }

    private static void createTable(String tableName) {
        MySQLDriver.createTable(connection,tableName);
    }

    private static void fillTable() throws IOException, InterruptedException {
        MySQLDriver.insertFileContent(connection,arguments.CSVFilePath,"ratings");
    }

    //Get rating, directly from the CSV file or from a MySQL
    private static Map<Integer, Map<Integer, List<Double>>> getRatings() {
        if(arguments.mode.equals("mysql"))
        {
            return readRatingsMysql();
        }
        else return readRatingsCSV();
    }

    //This function read the whole ratings table and set it into resume. This function could be easily improved to read
    //only the last records that have not ben previously processed.
    private static Map<Integer, Map<Integer, List<Double>>> readRatingsMysql() {
        //This is the query that we will execute
        String query = "SELECT * FROM ratings";
        Map<Integer, Map<Integer,List<Double>>> resume = new HashMap<>();

        try {
            ResultSet rs=null;
            Statement stmt = null;
            stmt = connection.createStatement();
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                //Each record in table ratings has a user_id, activity_id and rating.
                int user_id = rs.getInt("user_id");
                int activity_id = rs.getInt("activity_id");
                double rating = rs.getDouble("rating");


                //Update the resume with the new record
                Map<Integer, List<Double>> activity_ratings = resume.get(activity_id);
                if(activity_ratings==null) activity_ratings = new HashMap<>();
                List<Double> user_ratings = activity_ratings.get(user_id);
                if (user_ratings==null) user_ratings = new ArrayList<>();
                user_ratings.add(rating);
                activity_ratings.put(user_id,user_ratings);
                resume.put(activity_id,activity_ratings);
            }
            rs.close();
            stmt.close();

        }
        catch (SQLException e)
        {
            System.out.println("Error processing "+query);
        }
        return resume;
    }

    //This function reads the CSV file and creates the resume. This function could be easily improved to read
    //only the last records that have not ben previously processed.
    private static Map<Integer, Map<Integer, List<Double>>> readRatingsCSV() {
        Map<Integer, Map<Integer,List<Double>>> resume = new HashMap<>();
        try {
            List<String[]> records = FileDriver.read(arguments.CSVFilePath);
            boolean first = true;
            for(String[] record : records)
            {
                try {
                    int user_id = Integer.parseInt(record[0]);
                    int activity_id = Integer.parseInt(record[1]);
                    double rating = Double.parseDouble(record[2]);

                    updateResume(resume, user_id, activity_id, rating);
                }
                catch (Exception e){
                    System.out.println("Error in: <"+ record[0]+", "+record[1]+", "+record[2]+">");
                }
            }
        }
        catch(IOException e)
        {
            System.out.println("File "+arguments.CSVFilePath+" may not exist.");
        }
        return resume;
    }

    private static void updateResume(Map<Integer, Map<Integer, List<Double>>> resume, int user_id, int activity_id, double rating) {
        //Update the resume with the new record
        Map<Integer, List<Double>> activity_ratings = resume.get(activity_id);
        if(activity_ratings==null) activity_ratings = new HashMap<>();
        List<Double> user_ratings = activity_ratings.get(user_id);
        if (user_ratings==null) user_ratings = new ArrayList<>();
        user_ratings.add(rating);
        activity_ratings.put(user_id,user_ratings);
        resume.put(activity_id,activity_ratings);
    }

   //This function contains the logic of this module. Read the ratings from its own database and process them according
   //to its own goals.
    private static void modelRatings(Map<Integer, Map<Integer,List<Double>>> ratings) throws InterruptedException{

        ActivityStatistic activityStatistic= calculateStatistics(ratings);
        printStatistics(activityStatistic);
    }

    private static void printStatistics(ActivityStatistic activityStatistic) {
        if(arguments.mode.equals("mysql"))
        {
            writeStatistics(activityStatistic);
        }
        else
        {
            printStatisticsCSV(activityStatistic);
        }
    }

    //It calculates a set of statistics given the resume created previosly by reading the ratings.
    private static ActivityStatistic calculateStatistics(Map<Integer, Map<Integer, List<Double>>> resume) {
        int num_rated_activities = resume.size();
        Pair<Integer,Double> bestActivity = calculateBestActivity(resume);

        return new ActivityStatistic(num_rated_activities, bestActivity);
    }

    private static void printStatisticsCSV(ActivityStatistic activityStatistic) {
        if (!activityStatistic.equals(lastActivityStatistic))
        {
            System.out.println(activityStatistic.num_rated_activities+" "+activityStatistic.bestActivity.getKey()+" "+activityStatistic.bestActivity.getValue());
            lastActivityStatistic=activityStatistic;
        }
    }

    //It writes the results into the resultsTablesName of its own database.
    private static void writeStatistics(ActivityStatistic activityStatistic) {
        if (!activityStatistic.equals(lastActivityStatistic))
        {
            String tableAttributes ="(num_rated_activities,best_rated_activity,best_rating)";
            MySQLDriver.insert(connection,resultTableName, tableAttributes,activityStatistic);
            lastActivityStatistic=activityStatistic;
        }
    }

    //Calculates the bestRatedActivity
    private static Pair<Integer,Double> calculateBestActivity(Map<Integer, Map<Integer, List<Double>>> resume) {
        double best_rating = 0D;
        int best_rated_activity = -1;
        for (Map.Entry<Integer,Map<Integer,List<Double>>> e : resume.entrySet())
        {
            int current_activity = e.getKey();
            for(Map.Entry<Integer,List<Double>> e2 : e.getValue().entrySet())
            {
                for(Double current_rating : e2.getValue())
                {
                    if (current_rating>best_rating)
                    {
                        best_rating=current_rating;
                        best_rated_activity=current_activity;
                    }
                }
            }
        }
        return new ImmutablePair<>(best_rated_activity,best_rating);
    }

}
