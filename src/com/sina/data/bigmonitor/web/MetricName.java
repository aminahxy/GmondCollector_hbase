
/**
 * Created by shiboyan on 8/27/16.
 */

package com.sina.data.bigmonitor.web;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.util.Bytes;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static com.sina.data.constant.Constants.MetricConfTableName;
import static com.sina.data.constant.Constants.MetricConfTableName_cf_c1;


public class MetricName extends Configured {

    Table table = null;
    public void init() throws IOException {
        Configuration config = HBaseConfiguration.create();
        config.set("hbase.zookeeper.quorum", "10.39.6.87");
        config.set("hbase.zookeeper.property.clientPort", "2181");
        Connection connection = null;
        String table_name="ns_hadoopadmin:BigMonitorMetricConfTable";
        TableName TABLE_NAME = TableName.valueOf(table_name);
        setConf(HBaseConfiguration.create(config));
        connection = ConnectionFactory.createConnection(getConf());
        table = connection.getTable(TABLE_NAME);

    }

    public List<String> getMetricInfo() throws IOException{
        init();
        List<String> metricName=new ArrayList<String>();
        Scan scan = new Scan();
        scan.addFamily(MetricConfTableName_cf_c1.getBytes());
        ResultScanner rs = null;
        try {
            rs = table.getScanner(scan);
            Iterator<Result> it = rs.iterator();
            while (it.hasNext()){
                Result result = it.next();
                metricName.add(Bytes.toString(result.getRow())+"\n");
            }
        } catch (IOException e) {
            System.out.println("scan table "+ MetricConfTableName+" error.");
            throw e;
        }
        rs.close();
        return metricName;
    }
    public static void main(String[] args)
    {
        List<String> info=new ArrayList<String>();
        MetricName test=new MetricName();
        try {
            info =test.getMetricInfo();
        }catch (IOException e)
        {

        }
        for(String l:info)
        {
            System.out.print(l);
        }
    }


}


