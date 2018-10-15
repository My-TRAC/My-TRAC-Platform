package MySQLHandlers;


import Models.ActivityStatistic;
import org.apache.commons.lang3.tuple.Pair;

import java.sql.Timestamp;

public class SQLQueryBuilder {

    public static String createTable(String tableName)
    {

        StringBuilder sb = new StringBuilder("CREATE TABLE IF NOT EXISTS "+ tableName + " (");
        sb.append("id serial NOT NULL PRIMARY KEY,\n");
      //  sb.append("modified timestamp default CURRENT_TIMESTAMP NOT NULL,");
        sb.append(" num_rated_activities INTEGER,");
        sb.append(" best_rated_activity INTEGER,");
        sb.append(" best_rating DOUBLE)");

    return sb.toString();
    }




    public static String insert(String resultTableName, String tableAttributes, ActivityStatistic activityStatistic) {
        StringBuilder sb = new StringBuilder("INSERT INTO "+resultTableName+" "+tableAttributes+" VALUES ("+activityStatistic.num_rated_activities+
                ","+activityStatistic.bestActivity.getKey()+","+activityStatistic.bestActivity.getValue()+")");
        return sb.toString();
    }
}
