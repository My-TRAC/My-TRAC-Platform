import FileHandlers.LoadFile;
import MySQLHandlers.SQLConnection;
import MySQLHandlers.SQLQueryBuilder;
import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

public class DB_Example {

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


    public static void main (String[] args) throws IOException, SQLException {

        System.out.println("Number of arguments " + args.length);

        Arguments arguments = new Arguments();
        JCommander.newBuilder().addObject(arguments).build().parse(args);

        //new JCommander (arguments,args);


        String ip= arguments.ip;
        String database = arguments.database;
        String user = arguments.user;
        String pw = arguments.pw;

        //final Connection connection = SQLConnection.getConnection("192.168.99.100", "connect_test", "confluent", "confluent");
        final Connection connection = SQLConnection.getConnection(ip,database,user,pw);


        List<String[]> records = LoadFile.load("/Users/joan/Downloads/original_gtfs/routes.txt");
        String createTable = SQLQueryBuilder.createTable("routes", records.get(0));

        System.out.println(createTable);

        Statement statement = connection.createStatement();
        statement.executeUpdate(createTable);

        boolean first = true;
        for(String[] record : records) {
            if (first != true) {
                String insert = SQLQueryBuilder.insert("routes", records.get(0), record);
                try {
                    statement.executeUpdate(insert);
                }
                catch (Exception e)
                {
                    System.out.println("Error in: "+ insert);
                }
            }
            first = false;
        }

    }
}
