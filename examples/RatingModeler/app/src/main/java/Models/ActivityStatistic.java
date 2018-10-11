package Models;

import org.apache.commons.lang3.tuple.Pair;

public class ActivityStatistic {

    public int num_rated_activities;
    public Pair<Integer,Double> bestActivity;

    public ActivityStatistic (int num_rated_activities, Pair<Integer,Double> bestActivity)
    {
        this.num_rated_activities=num_rated_activities;
        this.bestActivity=bestActivity;
    }

    public boolean equals(ActivityStatistic tmp)
    {
        if (tmp == null) return  false;
        return num_rated_activities==tmp.num_rated_activities&&bestActivity.getKey().equals(tmp.bestActivity.getKey())&bestActivity.getValue().equals(tmp.bestActivity.getValue());
    }
}
