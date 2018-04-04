import FileHandlers.LoadFile;
import MySQLHandlers.SQLConnection;
import MySQLHandlers.SQLQueryBuilder;
import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import org.apache.commons.lang3.ArrayUtils;

import java.io.File;
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

        @Parameter(names={"-f","--file"}, description="Full path to the GTFS file to be loaded", required= false)
        public String filename="";


        @Parameter(names={"-F","--folder"}, description="Full path to the folder containing the GTFS files to be loaded", required= false)
        public String folderName="";

        @Parameter(names = "--help,-help", help = true)
        private boolean help;

    }


    public static void main (String[] args) throws IOException, SQLException {


        Arguments arguments = new Arguments();
        try{

            JCommander.newBuilder().addObject(arguments).build().parse(args);
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
            return;
        }

        if(arguments.filename.isEmpty()&&arguments.folderName.isEmpty())
        {
            System.out.println("Either the filename [-f] or the folder [-F] containing the files to be loaded has to be passed as an argument.");
        }
        //new JCommander (arguments,args);


        String ip= arguments.ip;
        String database = arguments.database;
        String user = arguments.user;
        String pw = arguments.pw;

        //connection = SQLConnection.getConnection("192.168.99.100", "connect_test", "confluent", "confluent");
     //   connection = SQLConnection.getConnection(ip,database,user,pw);


        if(!arguments.filename.isEmpty())
        {
           processFile(arguments.filename);
        }
        if(!arguments.folderName.isEmpty())
        {
            File folder = new File(arguments.folderName);
            String[] listOfFiles = ArrayUtils.removeElement(folder.list(),arguments.filename);
            for(String filename : listOfFiles)
            {
                if (!filename.startsWith(".")) {
                    System.out.println("Processing file: " + arguments.folderName + "/" + filename);
                    processFile(arguments.folderName + "/" + filename);
                }
            }
        }
    }

static    Connection connection;

    private static void processFile(String filename) throws IOException, SQLException {
        String tableName = filename.substring(filename.lastIndexOf("/")+1,filename.lastIndexOf("."));
        List<String[]> records = LoadFile.load(filename);
        String createTable = SQLQueryBuilder.createTable(tableName, records.get(0));

        System.out.println(createTable);

        Statement statement = connection.createStatement();
       statement.executeUpdate(createTable);



        boolean first = true;
        for(String[] record : records) {
            if (first != true) {
                String insert = SQLQueryBuilder.insert(tableName, records.get(0), record);
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
