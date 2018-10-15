package MySQLHandlers;


import Models.ActivityStatistic;
import org.apache.commons.lang3.tuple.Pair;

import java.sql.Timestamp;

public class SQLQueryBuilder {

    public static String createTable(String tableName)
    {
        StringBuilder sb = new StringBuilder("CREATE TABLE IF NOT EXISTS "+ tableName + "(");
        if(!tableName.equals("ratings")) {
            sb.append("id serial NOT NULL PRIMARY KEY,\n");
            sb.append(" num_rated_activities INTEGER,");
            sb.append(" best_rated_activity INTEGER,");
            sb.append(" best_rating DOUBLE)");
        }
        else
        {
            sb.append("id serial NOT NULL PRIMARY KEY,\n");
            sb.append("user_id INTEGER,");
            sb.append("activity_id INTEGER,");
            sb.append("rating DOUBLE");
            sb.append(")");
        }
        return sb.toString();
    }




    public static String insert(String resultTableName, String tableAttributes, ActivityStatistic activityStatistic) {
        StringBuilder sb = new StringBuilder("INSERT INTO "+resultTableName+" "+tableAttributes+" VALUES ("+activityStatistic.num_rated_activities+
                ","+activityStatistic.bestActivity.getKey()+","+activityStatistic.bestActivity.getValue()+")");
        return sb.toString();
    }


    public static String insert(String tableName,String header, String[] record)
    {
        //System.out.println("Creating insert for "+ record);


        StringBuilder sb = new StringBuilder("INSERT INTO "+tableName+header);
        sb.append("VALUES (");
        boolean first=true;
        for(String value : record)
        {
            if(!first) sb.append(", ");
            sb.append("'"+value+"'");
            first=false;
        }
        sb.append(")");
        return sb.toString();
    }
}
