import MySQLHandlers.SQLConnection;
import MySQLHandlers.SQLQueryBuilder;
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


public class Read_Ratings {

    public static class Arguments {

        @Parameter(names = {"-db", "--database"}, description = "Database name", required = true)
        public String database;

        @Parameter(names = {"-ip", "--ip"}, description = "MySQL server ip", required = true)
        public String ip;

        @Parameter(names = {"-u", "--user","--username"}, description = "DB username", required = false)
        public String user = "confluent";


        @Parameter(names = {"-pw", "--password"}, description = "DB password", required = false)
        public String pw = "confluent";




        @Parameter(names = "--help,-help", help = true)
        private boolean help;

    }


    static    Connection connection = null;
    public static void main (String[] args) throws IOException, InterruptedException {




        Arguments arguments = new Arguments();


        JCommander.newBuilder().addObject(arguments).build().parse(args);
        String ip= arguments.ip;
        String database = arguments.database;
        String user = arguments.user;
        String pw = arguments.pw;


        System.out.println(
                "ip: "+ip+"\n"+
                        "database: "+database+"\n"+
                        "user: "+user+"\n"+
                        "pw: "+pw+"\n"
        );

        while(connection == null) {
            try{
                connection = SQLConnection.getConnection(ip,database,user,pw);
            } catch(Exception e) {
                e.printStackTrace();
                sleep(1000);
            }
        }
        System.out.println("Connection to MYSQL established");



        String create_table="";
        try{

            create_table = SQLQueryBuilder.createTable();
            Statement statement = connection.createStatement();
            statement.executeUpdate(create_table);
            System.out.println(create_table);
            System.out.println("done");
        }
        catch (SQLException e) {
            System.out.println("SQL QUERY: " + create_table);
            e.printStackTrace();
        }

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

        String query = "SELECT * FROM ratings";
        while(true)
        {
            sleep(60000);
            try{
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(query);


                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                System.out.println(timestamp);
                Map<Integer, Map<Integer,List<Double>>> resume = new HashMap<>();
                //{"user_id":2,"activity_id":35,"rating":2.4}
                while (rs.next()) {
                    int user_id = rs.getInt("user_id");
                    int activity_id = rs.getInt("activity_id");
                    double rating = rs.getDouble("rating");

                    Map<Integer, List<Double>> activity_ratings = resume.get(activity_id);
                    if(activity_ratings==null) activity_ratings = new HashMap<>();
                    List<Double> user_ratings = activity_ratings.get(user_id);
                    if (user_ratings==null) user_ratings = new ArrayList<>();
                    user_ratings.add(rating);
                    activity_ratings.put(user_id,user_ratings);
                    resume.put(activity_id,activity_ratings);

                    System.out.println("user_id: " + user_id + ", activity_id: " + activity_id + ", rating: " + rating);
                }
                write_statistics(timestamp,resume);
                System.out.println();
                rs.close();
                stmt.close();
            }

            catch(SQLException e)
            {
                e.printStackTrace();
            }

        }



    }

    private static void write_statistics(Timestamp timestamp, Map<Integer, Map<Integer, List<Double>>> resume) {
        int num_rated_activities = resume.size();
        Pair<Integer,Double> bestActivity = calculateBestActivity(resume);


        String insert = SQLQueryBuilder.insert(num_rated_activities,bestActivity);

        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate(insert);
        }
        catch (SQLException e)
        {
            System.out.println("SQL QUERY: "+ insert);
            e.printStackTrace();
        }


    }

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
