package MySQLHandlers;


import Models.ActivityStatistic;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class MySQLDriver {

    //Create a table called tableName
    public static String createTable(Connection connection, String tableName)  {
        String createTable = SQLQueryBuilder.createTable(tableName); //We will need to extend that to create a table based on the registered schema
        try{
            Statement statement = connection.createStatement();
            statement.executeUpdate(createTable);
            return createTable;
        }
        catch (SQLException e) {
            e.printStackTrace();
            return ("ERROR in SQL query: " + createTable);
        }
    }

    //Insert an activityStatistic into the tableName
    public static String insert(Connection connection, String resultTableName, String tableName, ActivityStatistic activityStatistic){
        String result;
        String insert = SQLQueryBuilder.insert(resultTableName,tableName,activityStatistic);
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate(insert);
            result = "SQL query: " + insert;
        } catch (SQLException e) {
            result = "Error in SQL query: " + insert;
            e.printStackTrace();
        }

        return result;
    }
}
