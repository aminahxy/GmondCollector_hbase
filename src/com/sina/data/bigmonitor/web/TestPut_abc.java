//package com.sina.hbase_start;
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

public class TestPut_abc extends Configured implements Tool {

	public int run(String[] args) throws IOException {
		Configuration config = HBaseConfiguration.create();
		config.set("hbase.zookeeper.quorum", "10.39.6.87");
		config.set("hbase.zookeeper.property.clientPort", "2181");
		Connection connection = null;
		Table table = null;
		String table_name="ns_hadoopadmin:BigMonitorMetricConfTable";
		TableName TABLE_NAME = TableName.valueOf(table_name);
		setConf(HBaseConfiguration.create(config));
		connection = ConnectionFactory.createConnection(getConf());
		table = connection.getTable(TABLE_NAME);
		String rows=FileUtils.readFile("doc/file_ka");
		String ids=FileUtils.readFile("doc/fileid_ka");
		String[] id=ids.split("\n");
		String[] row=rows.split("\n");
		for(int i=0;i<8;i++) {
			Put put = new Put(row[i].getBytes());
			put.addColumn("c1".getBytes(), "id".getBytes(), id[i].getBytes());

			table.put(put);
		}
		//Delete delete = new Delete(Bytes.toBytes("gexec"));
		//table.delete(delete);


		Scan scan=new Scan();
		ResultScanner rs = table.getScanner(scan);

		for (Result r : rs) {
			for (KeyValue kv : r.raw()) {
				System.out.println(String.format("row:%s, family:%s, qualifier:%s, qualifiervalue:%s, timestamp:%s.",
						Bytes.toString(kv.getRow()),
						Bytes.toString(kv.getFamily()),
						Bytes.toString(kv.getQualifier()),
						Bytes.toString(kv.getValue()),
						kv.getTimestamp()));
			}
		}


	//	Get g = new Get("test_key".getBytes());
	  //  Result r = table.get(g);
		//famliy qualifier
	//	String value = new String(r.getValue("cf".getBytes(),"1".getBytes()));
	//	System.out.println("testhbase"+value);
       table.close();
		return 0;
	}

	public static void main(String[] argv) throws Exception {
		int ret = ToolRunner.run(new TestPut_abc(), argv);
		System.exit(ret);
	}
}
