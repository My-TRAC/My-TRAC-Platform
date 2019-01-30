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
        @Parameter(names = {"-db", "--database"}, description = "Database name", required = true)
        public String database;

        @Parameter(names = {"-ip", "--ip"}, description = "MySQL server ip", required = true)
        public String ip;

        @Parameter(names = {"-u", "--user","--username"}, description = "DB username", required = false)
        public String user = "confluent";

        @Parameter(names = {"-pw", "--password"}, description = "DB password", required = false)
        public String pw = "confluent";

        @Parameter(names ={"-l","--loadCSV"}, description = "Load mode [MySQL/CSV File",required = false)
        public boolean csvLoad=false;

        @Parameter(names = "--help,-help", help = true)
        private boolean help;


    }


    static    Connection connection = null;
    static ActivityStatistic lastActivityStatistic = null;
    static Arguments arguments = new Arguments();
    private static final String resultTableName= "ActivitiesSummary";

    public static void main (String[] args) throws IOException, InterruptedException {
        //Handle the program arguments
        JCommander.newBuilder().addObject(arguments).build().parse(args);


        waitForRatings();
        modelRatings();
    }

    //This function will block the app until i) it can connect with the databse and ii) it finds the ratings table.
    private static void waitForRatings() throws InterruptedException {
        //Connect with the database
        connection = SQLConnection.getConnection(arguments.ip,arguments.database,arguments.user,arguments.pw);
        System.out.println("Connection to MYSQL established");


        //Wait for ratings to come. It keeps checking wheter ratings table exists until it finds it.
        DatabaseMetaData dbm = null;
        try {
            dbm = connection.getMetaData();
            ResultSet rs = dbm.getTables(null,null,"ratings",null);
            while (!rs.next())
            {
                sleep(30000);
                System.out.println("Table ratings does not exist");

                rs = dbm.getTables(null,null,"ratings",null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

   //This function contains the logic of this module. Read the ratings from its own database and process them according
   //to its own goals.
    private static void modelRatings() throws InterruptedException{

       //Prepare the module to store results by creating a table in the database
        String createdTable = MySQLDriver.createTable(connection,resultTableName);
        System.out.println(createdTable);


        while(true)
        {
            Map<Integer, Map<Integer,List<Double>>> resume  = readRatings();
            ActivityStatistic activityStatistic= calculateStatistics(resume);
            writeStatistics(activityStatistic);

            sleep(4000);
        }
    }

    //This function read the whole ratings table and set it into resume. This function could be easily improved to read
    //only the last records that have not ben previously processed.
    private static Map<Integer, Map<Integer, List<Double>>> readRatings() {

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

    //It calculates a set of statistics given the resume created previosly by reading the ratings.
    private static ActivityStatistic calculateStatistics(Map<Integer, Map<Integer, List<Double>>> resume) {
        int num_rated_activities = resume.size();
        Pair<Integer,Double> bestActivity = calculateBestActivity(resume);

        return new ActivityStatistic(num_rated_activities, bestActivity);
    }

    //It writes the results into the resultsTablesName of its own database.
    private static void writeStatistics(ActivityStatistic activityStatistic) {
        if (!activityStatistic.equals(lastActivityStatistic))
        {
            String tableAttributes ="(num_rated_activities,best_rated_activity,best_rating)";
            String insert = MySQLDriver.insert(connection, resultTableName, tableAttributes, activityStatistic);
            System.out.println(insert);
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
