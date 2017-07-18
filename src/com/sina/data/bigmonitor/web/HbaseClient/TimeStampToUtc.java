package com.sina.data.bigmonitor.web.HbaseClient;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * .
 */
public class TimeStampToUtc {
    public static String TsToUtc(long ts) {
        SimpleDateFormat df =  new SimpleDateFormat("yyyy,MM,dd,HH,mm,ss");
        //long time = Long.valueOf(ts+"000");
        String res = df.format(new Date(ts));
        res = "Date.UTC(" + res + ")";
        return res;


    }
    public int getTimesmorning(){
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return (int) (cal.getTimeInMillis()/1000-86400);
    }
    public int getTimesnight(){
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 24);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return (int) (cal.getTimeInMillis()/1000-86400);
    }
    public static void main(String[] args)
    {
        TimeStampToUtc test=new TimeStampToUtc();
        String start_time=String.valueOf(test.getTimesmorning());
        String end_time=String.valueOf(test.getTimesnight());
        String startrow="10.39.0.116#100120#"+start_time;
        String endrow="10.39.0.116#100120#"+end_time;
        System.out.println(startrow);
        System.out.println(endrow);
    }
}
