package com.sina.data.DataProducer;

import com.google.gson.Gson;
import com.sina.data.bigmonitor.web.HbaseClient.HbaseClient;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 *
 */
public class CompareMultiHostMetric {
    public String GetMultiHostMetric(String[] hosts, String metricId, String timeStamp) {
        String hbTable = "ns_hadoopadmin:BigMonitorMetricDataHostOrig";
        final Map<String, Double> map = new ConcurrentHashMap<String, Double>();
        ExecutorService fixedThreadPool = Executors.newFixedThreadPool(100);
        int len = hosts.length;
        for(int i=0; i<len; i++) {
            final String host = hosts[i];
            final String fTab = hbTable;
            final String mId = metricId;
            final String ts = timeStamp;
            fixedThreadPool.execute(new Runnable(){
                public void run() {

                    String res = HbaseClient.getHc().CeilScan(fTab, host, mId, ts);
                    map.put(host, Double.valueOf(res));

                }
            });
        }
        fixedThreadPool.shutdown();
        try {
            fixedThreadPool.awaitTermination(60, TimeUnit.SECONDS);
        } catch (InterruptedException e) {

        }

        PriorityQueue<Map.Entry<String,Double>> queue = new PriorityQueue(map.size(),new Comparator<Map.Entry<String,Double>>(){
            public int compare(Map.Entry<String, Double> e1, Map.Entry<String, Double> e2) {
                return Double.compare(e1.getValue(),e2.getValue());
            }
        });
        for(Map.Entry<String,Double> e:map.entrySet()){
            queue.add(e);
        }
//        StringBuffer res = new StringBuffer();
//        res.append("[");
        List list = new ArrayList<List<Object>>();
        while(!queue.isEmpty()){
            List tmplist = new ArrayList<Object>();
            Map.Entry<String, Double> e = queue.poll();
            tmplist.add(e.getKey());
            tmplist.add(e.getValue());
            list.add(tmplist);
        }
//        res.append("]");


        Gson gson = new Gson();
//
//        return gson.toJson(queue,new TypeToken<List<Map.Entry<String,String>>>(){}.getType());

        return gson.toJson(list);
    }

    public String GetMultiHostMetric_kafka(String[] hosts, String metricId, String timeStamp) {
        String hbTable = "ns_hadoopadmin:kafka_eager_eyes_info_jmx";
        final Map<String, Double> map = new ConcurrentHashMap<String, Double>();
        ExecutorService fixedThreadPool = Executors.newFixedThreadPool(100);
        int len = hosts.length;
        for(int i=0; i<len; i++) {
            final String host = hosts[i];
            final String fTab = hbTable;
            final String mId = metricId;
            final String ts = timeStamp;
            fixedThreadPool.execute(new Runnable(){
                public void run() {
                    //String res = new HbaseClient().CeilScan(fTab, host, mId, ts);
                    String res = HbaseClient.getHc().CeilScan(fTab, host, mId, ts);
                    map.put(host, Double.valueOf(res));

                }
            });
        }
        fixedThreadPool.shutdown();
        try {
            fixedThreadPool.awaitTermination(60, TimeUnit.SECONDS);
        } catch (InterruptedException e) {

        }

        PriorityQueue<Map.Entry<String,Double>> queue = new PriorityQueue(map.size(),new Comparator<Map.Entry<String,Double>>(){
            public int compare(Map.Entry<String, Double> e1, Map.Entry<String, Double> e2) {
                return Double.compare(e1.getValue(),e2.getValue());
            }
        });
        for(Map.Entry<String,Double> e:map.entrySet()){
            queue.add(e);
        }
//        StringBuffer res = new StringBuffer();
//        res.append("[");
        List list = new ArrayList<List<Object>>();
        while(!queue.isEmpty()){
            List tmplist = new ArrayList<Object>();
            Map.Entry<String, Double> e = queue.poll();
            tmplist.add(e.getKey());
            tmplist.add(e.getValue());
            list.add(tmplist);
        }
//        res.append("]");


        Gson gson = new Gson();
//
//        return gson.toJson(queue,new TypeToken<List<Map.Entry<String,String>>>(){}.getType());

        return gson.toJson(list);
    }



    public static void main(String[] args) {
        String [] hosts = {"10.39.1.119", "10.39.1.245","10.39.2.22","10.39.2.57","10.39.0.87" };
        String res = new CompareMultiHostMetric().GetMultiHostMetric(hosts,"100018", "1472655362");
        System.out.println(res);
    }


}