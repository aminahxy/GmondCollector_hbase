package com.sina.data.bigmonitor.web;
import com.sina.data.bigmonitor.web.HbaseClient.HbaseClient;
import com.sina.data.bigmonitor.web.HbaseClient.TimeStampToUtc;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.hbase.KeyValue;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Table;
import org.apache.hadoop.hbase.filter.CompareFilter;
import org.apache.hadoop.hbase.filter.Filter;
import org.apache.hadoop.hbase.filter.FilterList;
import org.apache.hadoop.hbase.filter.SingleColumnValueFilter;
import org.apache.hadoop.hbase.util.Bytes;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Compare_tmp extends Configured{

        public List<String> GetAllData() throws IOException {

            HbaseClient.getHc();
            HbaseClient client=new HbaseClient();
            Table table=client.tableConn("ns_hadoopadmin:BigMonitorMetricDataHostHour");
            Scan scan=new Scan();
            TimeStampToUtc timestamp=new TimeStampToUtc();
            String start_time=String.valueOf(timestamp.getTimesmorning());
            String end_time=String.valueOf(timestamp.getTimesnight());
            String readhosts=FileUtils.readFile("host");
            String[] host_tmp=readhosts.split("\n");
          //  String scan_res="$";
            List<String> host_res=new ArrayList<String>();
            for(String host:host_tmp)
            {
                String startrow=host+"#100120#"+start_time;
                String endrow=host+"#100120#"+end_time;
                scan.setStartRow(Bytes.toBytes(startrow));
                scan.setStopRow(Bytes.toBytes(endrow));
                Filter filter1 = new SingleColumnValueFilter(Bytes.toBytes("c1"), Bytes.toBytes("d"), CompareFilter.CompareOp.GREATER,Bytes.toBytes("30"));
                FilterList filter=new FilterList();
                filter.addFilter(filter1);
                scan.setFilter(filter);
                ResultScanner rs = table.getScanner(scan);
                String scan_res="";
                for (Result r : rs) {
                    for (KeyValue kv : r.raw()) {
                        if(Float.valueOf(Bytes.toString(kv.getValue()))<Float.valueOf("30"))
                        {
                            break;
                        }
                        else {
                            scan_res += (Bytes.toString(kv.getRow()));
                            scan_res += "%";
                            scan_res += (Bytes.toString(kv.getValue()));
                            scan_res += "?";
                        }

                    }
                    //host_res.add(scan_res);
                }
                host_res.add(scan_res);

            }

            return host_res;

        }

        public static void main(String[] argv) throws Exception {

            Compare_tmp test=new Compare_tmp();
            List<String> res=test.GetAllData();
            for(String s:res)
            {
                System.out.println(s);
            }

        }


    }
