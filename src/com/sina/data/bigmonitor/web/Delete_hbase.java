package com.sina.data.bigmonitor.web;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.KeyValue;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Delete_hbase extends Configured implements Tool {

	public int run(String[] args) throws IOException {
		Configuration config = HBaseConfiguration.create();
		config.set("hbase.zookeeper.quorum", "10.39.6.87");
		config.set("hbase.zookeeper.property.clientPort", "2181");
		Connection connection = null;
		Table table = null;
		String table_name="ns_hadoopadmin:kafka_eager_eyes_info_jmx";
		//String table_name="ns_hadoopadmin:kafka_metrics";
		TableName TABLE_NAME = TableName.valueOf(table_name);
		setConf(HBaseConfiguration.create(config));
		connection = ConnectionFactory.createConnection(getConf());
		table = connection.getTable(TABLE_NAME);
		//Delete delete = new Delete(Bytes.toBytes(""));
		//table.delete(delete);
		List<Delete> todelete=new ArrayList<Delete>();
		List<String> key=new ArrayList<String>();
		Scan scan=new Scan();
		//scan.setStartRow(Bytes.toBytes("hadoop-2.4.0-master#100007#1472442124"));
		//scan.setStopRow(Bytes.toBytes("hadoop-2.4.0-master#100007#1472442153"));
		//scan.setStartRow(Bytes.toBytes("test5"));
		//scan.setStopRow(Bytes.toBytes("10.39.0.180"));
		ResultScanner rs = table.getScanner(scan);
		//List<Delete> list=new ArrayList<Delete>();
		for (Result r : rs) {
			for (KeyValue kv : r.raw()) {

				//System.out.println(kv.getRow().toString());
				key.add(Bytes.toString(kv.getRow()));
				//todelete.add(new Delete(Bytes.toBytes(kv.getRow().toString())));
				//Delete delete = new Delete(Bytes.toBytes(kv.getRow().toString()));
				//table.delete(delete);
				/*System.out.println(String.format("row:%s, family:%s, qualifier:%s, qualifiervalue:%s, timestamp:%s.",
						Bytes.toString(kv.getRow()),
						Bytes.toString(kv.getFamily()),
						Bytes.toString(kv.getQualifier()),
						Bytes.toString(kv.getValue()),
						kv.getTimestamp()));*/
			}
		}
		for(String s:key)
		{
			System.out.println(s);
			todelete.add(new Delete(Bytes.toBytes(s)));
		}
		table.delete(todelete);


		//	Get g = new Get("test_key".getBytes());
		//  Result r = table.get(g);
		//famliy qualifier
		//	String value = new String(r.getValue("cf".getBytes(),"1".getBytes()));
		//	System.out.println("testhbase"+value);

		table.close();
		return 0;
	}

	public static void main(String[] argv) throws Exception {
		int ret = ToolRunner.run(new Delete_hbase(), argv);
		System.exit(ret);
	}
}