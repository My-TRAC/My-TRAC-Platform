package MySQLHandlers;


import org.apache.commons.lang3.tuple.Pair;

import java.sql.Timestamp;

public class SQLQueryBuilder {

    public static String createTable()
    {
        StringBuilder sb = new StringBuilder("CREATE TABLE IF NOT EXISTS activities_summary (");
        sb.append("id serial NOT NULL PRIMARY KEY,\n");
        sb.append("modified timestamp default CURRENT_TIMESTAMP NOT NULL,");
        sb.append(" num_rated_activities INTEGER,");
        sb.append(" best_rated_activity INTEGER,");
        sb.append(" best_rating DOUBLE)");

    return sb.toString();
    }

    public static String insert(String tableName,String[] header, String[] record)
    {
        StringBuilder sb = new StringBuilder("INSERT INTO "+tableName+" (");
        boolean first=true;
        for(String field : header)
        {
            if(!first) sb.append(", ");
            sb.append(field);
            first=false;
        }
        sb.append(") VALUES (");
        first=true;
        for(String value : record)
        {
            if(!first) sb.append(", ");
            sb.append("'"+value+"'");
            first=false;
        }
        sb.append(")");
        return sb.toString();
    }

    public static String insert( int num_rated_activities, Pair<Integer, Double> bestActivity) {
        StringBuilder sb = new StringBuilder("INSERT INTO activities_summary (num_rated_activities,best_rated_activity,best_rating) VALUES ("+num_rated_activities+","+bestActivity.getKey()+","+bestActivity.getValue()+")");
        return sb.toString();

    }
}
