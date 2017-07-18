package com.sina.data.bigmonitor.web;

import com.sina.data.bigmonitor.web.HbaseClient.HbaseClient;
import com.sina.data.constant.Constants;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Table;
import org.apache.hadoop.hbase.util.Bytes;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.NavigableMap;

/**
 * Created by shiboyan on 8/26/16.
 */
public class ClusterWithHost_tmp extends Configured {


    public class ClusterHostBean {

        private String clusterName;
        private List<String> hosts;


        public ClusterHostBean(String clusterName,List<String> hosts){
            this.clusterName = clusterName;
            this.hosts = hosts;
        }

        public String getClusterName() {
            return clusterName;
        }

        public void setClusterName(String clusterName) {
            this.clusterName = clusterName;
        }

        public List<String> getHosts() {
            return hosts;
        }

        public void setHosts(List<String> hosts) {
            this.hosts = hosts;
        }
    }
    Table table= null;

    void init() throws IOException {
        String table_name="ns_hadoopadmin:BigMonitorClusterConfTable";
        table= HbaseClient.getHc().tableConn(table_name);
    }

   public List<ClusterHostBean> getClusterHostBeans() throws IOException {
        init();
        List<ClusterHostBean> clusterHostBeanList = new ArrayList<ClusterHostBean>();
        Scan scan = new Scan();
        scan.addFamily(Constants.ClusterConfTableName_cf_c1.getBytes());
        ResultScanner rs = null;
        try {
            rs = table.getScanner(scan);
            Iterator<Result> it = rs.iterator();
            while (it.hasNext()){
                Result result = it.next();
                String clusterName = Bytes.toString(result.getRow());

                NavigableMap<byte[],byte[]> qulifier2valmap =  result.getFamilyMap(Constants.ClusterConfTableName_cf_c1.getBytes());
                List<String> hosts = new ArrayList<String>();
                for(Iterator<byte[]> its = qulifier2valmap.keySet().iterator();its.hasNext();){
                    byte[] rr = its.next();
                    String test=Bytes.toString(rr);
                    if(!test.split("\\.")[1].equals("73"))
                    {
                        hosts.add(Bytes.toString(rr));
                    }

                }
                ClusterHostBean bean = new ClusterHostBean(clusterName,hosts);
                clusterHostBeanList.add(bean);
            }
        } catch (IOException e) {
           // LOG.info("scan table "+Constants.ClusterConfTableName+" error.",e);

            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        table.close();
        return clusterHostBeanList;
    }
    public List<ClusterHostBean> getHbaseHosts() throws IOException {
        init();
        List<ClusterHostBean> clusterHostBeanList = new ArrayList<ClusterHostBean>();
        Scan scan = new Scan();
        scan.addFamily(Constants.ClusterConfTableName_cf_c1.getBytes());
        ResultScanner rs = null;
        try {
            rs = table.getScanner(scan);
            Iterator<Result> it = rs.iterator();
            while (it.hasNext()){
                Result result = it.next();
                String clusterName = Bytes.toString(result.getRow());

                NavigableMap<byte[],byte[]> qulifier2valmap =  result.getFamilyMap(Constants.ClusterConfTableName_cf_c1.getBytes());
                List<String> hosts = new ArrayList<String>();
                for(Iterator<byte[]> its = qulifier2valmap.keySet().iterator();its.hasNext();){
                    byte[] rr = its.next();
                    String test=Bytes.toString(rr);
                    if(test.split("\\.")[1].equals("73"))
                    {
                        hosts.add(Bytes.toString(rr));
                    }
                }
                ClusterHostBean bean = new ClusterHostBean(clusterName,hosts);
                clusterHostBeanList.add(bean);
            }
        } catch (IOException e) {
            // LOG.info("scan table "+Constants.ClusterConfTableName+" error.",e);

            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        table.close();
        return clusterHostBeanList;
    }

    public static void main(String[] args) throws IOException {
        ClusterWithHost_tmp test=new ClusterWithHost_tmp();
        List<ClusterHostBean> host= test.getClusterHostBeans();
        for(ClusterHostBean c:host) {
            System.out.println(c.getHosts());
        }

    }

}

