package com.sina.data.DataProducer;

import com.google.gson.Gson;
import com.sina.data.bigmonitor.web.HbaseClient.HbaseClient;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * Created by shiboyan on 9/18/16.
 */
public class Test {

    public static List<List<Object>> get(String[] args){
        String test ="";
        // args1 2 3 4 hadoop-2.4.0-master 100058 1472089409 1472393059
        List<List<Object>> list = HbaseClient.getHc().GetRangeList(args[0], args[1], args[2], args[3], args[4]);
        return list;
    }

    public String GetMultiHost(String[] hosts, String hbTable, String metricId, String timeStamp, String timeStampend)
    {
        //System.out.println(get(args));
        ExecutorService fixedThreadPool = Executors.newFixedThreadPool(50);
        // String test="{name: 'Winter 2013-2014',data:"+ getDataTest.get(args) +"},";
        // System.out.println(test);
        int len = hosts.length;
        final List list = new ArrayList<Object>();
        // final Map<String, String> map = new ConcurrentHashMap<String, String>();
        for(int i=0; i<len; i++) {

            final  String[] args=new String[5];
            args[0]=hbTable;
            args[1]=hosts[i];
            args[2]=metricId;
            args[3]=timeStamp;
            args[4]=timeStampend;
            fixedThreadPool.execute(new Runnable(){
                public void run() {
                    final Map<String,Object> tmp = new ConcurrentHashMap<String, Object>();
                    //  String name="name:"+args[1]+"";
                    // String data="data:"+getDataTest.get(args)+"";
                    tmp.put("name",args[1]);
                    tmp.put("data",get(args));
                    // all.add(level1);
                    list.add(tmp);

                }
            });
        }
        fixedThreadPool.shutdown();
        try {
            fixedThreadPool.awaitTermination(60, TimeUnit.SECONDS);
        } catch (InterruptedException e) {

        }

        Gson gson = new Gson();
        // return list.toString();
        return gson.toJson(list);
    }
    public static void main(String[] args) {
        String [] hosts = {"10.39.0.178"};
        String res = new Test().GetMultiHost(hosts,"ns_hadoopadmin:BigMonitorMetricDataHostOrig","100018","1474183860","1474183995");
        System.out.println(res);
    }

}