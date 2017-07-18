       package com.sina.data.bigmonitor.web;

        import com.sina.data.bigmonitor.web.HbaseClient.HbaseClient;
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

        import static com.sina.data.constant.Constants.*;


public class AllMetrics extends Configured {

    Table table = null;
    public void init() throws IOException {
        String table_name="ns_hadoopadmin:BigMonitorMetricConfTable";
        table=HbaseClient.getHc().tableConn(table_name);

    }

    public List<metricInfo> getMetricInfo() throws IOException{
        init();
        List<metricInfo> metricInfos = new ArrayList<metricInfo>();
        List<metricInfo> metricInfos_inf = new ArrayList<metricInfo>();
        Scan scan = new Scan();
        scan.addFamily(MetricConfTableName_cf_c1.getBytes());
        ResultScanner rs = null;
        try {
            rs = table.getScanner(scan);
            Iterator<Result> it = rs.iterator();
            while (it.hasNext()){
                Result result = it.next();
                String metricName = Bytes.toString(result.getRow());
                String metricId = Bytes.toString(result.getValue(MetricConfTableName_cf_c1.getBytes(),
                        MetricConfTableName_cf_col_id.getBytes()));
                String metricType = Bytes.toString(result.getValue(MetricConfTableName_cf_c1.getBytes(),
                        MetricConfTableName_cf_col_type.getBytes()));
                metricInfo bean = new metricInfo(metricName,metricId,metricType);
                int id=Integer.valueOf(metricId);
                if((id<100100)||(id >300000))
                    metricInfos.add(bean);

            }
        } catch (IOException e) {
            System.out.println("scan table "+ MetricConfTableName+" error.");
            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        return metricInfos;
    }
    public List<metricInfo> getMetricInfo_inf() throws IOException{
        init();
        List<metricInfo> metricInfos = new ArrayList<metricInfo>();
        List<metricInfo> metricInfos_inf = new ArrayList<metricInfo>();
        Scan scan = new Scan();
        scan.addFamily(MetricConfTableName_cf_c1.getBytes());
        ResultScanner rs = null;
        try {
            rs = table.getScanner(scan);
            Iterator<Result> it = rs.iterator();
            while (it.hasNext()){
                Result result = it.next();
                String metricName = Bytes.toString(result.getRow());
                String metricId = Bytes.toString(result.getValue(MetricConfTableName_cf_c1.getBytes(),
                        MetricConfTableName_cf_col_id.getBytes()));
                String metricType = Bytes.toString(result.getValue(MetricConfTableName_cf_c1.getBytes(),
                        MetricConfTableName_cf_col_type.getBytes()));
                metricInfo bean = new metricInfo(metricName,metricId,metricType);
                int id=Integer.valueOf(metricId);
                if((id>=100100)&& (id<=200000))
                    metricInfos.add(bean);

            }
        } catch (IOException e) {
            System.out.println("scan table "+ MetricConfTableName+" error.");
            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        return metricInfos;
    }

    public List<metricInfo> getMetricInfo_kafka_broker() throws IOException{
        init();
        List<metricInfo> metricInfos = new ArrayList<metricInfo>();
        List<metricInfo> metricInfos_inf = new ArrayList<metricInfo>();
        Scan scan = new Scan();
        scan.addFamily(MetricConfTableName_cf_c1.getBytes());
        ResultScanner rs = null;
        try {
            rs = table.getScanner(scan);
            Iterator<Result> it = rs.iterator();
            while (it.hasNext()){
                Result result = it.next();
                String metricName = Bytes.toString(result.getRow());
                String metricId = Bytes.toString(result.getValue(MetricConfTableName_cf_c1.getBytes(),
                        MetricConfTableName_cf_col_id.getBytes()));
                String metricType = Bytes.toString(result.getValue(MetricConfTableName_cf_c1.getBytes(),
                        MetricConfTableName_cf_col_type.getBytes()));
                metricInfo bean = new metricInfo(metricName,metricId,metricType);
                int id=Integer.valueOf(metricId);
                if((id>=200100)&& (id<=200200))
                    metricInfos.add(bean);

            }
        } catch (IOException e) {
            System.out.println("scan table "+ MetricConfTableName+" error.");
            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        return metricInfos;
    }

    public List<metricInfo> getMetricInfo_kafka_brokertopic() throws IOException{
        List<metricInfo> res=new ArrayList<metricInfo>();
        res.add(new metricInfo("BytesInPerSec","200200","type"));
        res.add(new metricInfo("BytesOutPerSec","200201","type"));
        res.add(new metricInfo("MessagesInPerSec","200202","type"));
        return res;
    }


    public static void main(String[] args)
    {
        List<metricInfo> info = null;
        AllMetrics test=new AllMetrics();
        try {
            info = test.getMetricInfo_inf();
        }catch (IOException e)
        {

        }
        for(metricInfo l:info)
        {
            System.out.println("name"+l.getMetricName()+" "+"id"+l.getMetricId());
        }

    }


}