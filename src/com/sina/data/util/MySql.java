package com.sina.data.util;

/**
 * Created by shiboyan on 9/22/16.
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MySql {
    public static Connection conn=null;
    public static Statement stmt=null;
    enum judge_type {
        lt,
        le,
        eq,
        ge,
        gt,
        ne,
    }

    public static void init(String database)
    {

        String url = "jdbc:mysql://10.39.0.101:3306/" + database;

        try {
            conn = DriverManager.getConnection(url, "monitor", "monitor");
            stmt = conn.createStatement();
        }
        catch (Exception e) {
            e.printStackTrace();

        }

    }
    public static void close() {

        try {
            conn.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static List<List<Object>> GetFromDataBase(String database,String tablename) {

        List<List<Object>> res = new ArrayList<List<Object>>();
        init("monitorX");
        try {
            String sql = "select * from "+tablename;
            ResultSet rs = stmt.executeQuery(sql);
            List<Object> register = new ArrayList<Object>();
            List<Object> metric = new ArrayList<Object>();
            List<Object> host = new ArrayList<Object>();
            List<Object> threshold=new ArrayList<Object>();
            List<Object> type=new ArrayList<Object>();
            List<Object>  extend=new ArrayList<Object>();

          while (rs.next()) {
                register.add(rs.getString(1));
                metric.add(rs.getString(2));
                host.add(rs.getString(3));
                threshold.add(rs.getFloat(4));
                type.add(judge_type.valueOf(rs.getString("judge_type")));
                extend.add(rs.getString(6));

            }

            res.add(register);
            res.add(metric);
            res.add(host);
            res.add(threshold);
            res.add(type);
            res.add(extend);
            rs.close();
            close();

        } catch (Exception e) {
            e.printStackTrace();

        }
        return res;
    }
    public static List<Object> GetFromDataBase(String database,String tablename,String register) {
        List<Object> res = new ArrayList<Object>();
        init("cluster_monitor");
        try {

           // select * from cluster_monitor_register where register_name="disk_free_percent_data0";
            String sql = "select * from "+tablename+" "+"where register_name="+"\""+register+"\""+";";
           // System.out.println(sql);
            ResultSet rs = stmt.executeQuery(sql);
            int len=rs.getMetaData().getColumnCount();
         //   System.out.println(len);
            Object[] col=new Object[len+1];
            if(rs.next()) {

                for (int i = 0; i <len; i++) {

                    if(rs.getObject(i+1)!=null) {
                        col[i] = rs.getObject(i + 1);
                        res.add(col[i]);
                    }
                    else
                    {
                       //todo
                    }
                }
            }



            rs.close();
            close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }
    public void delete(String register) throws SQLException {
        init("cluster_monitor");

        String[] tables=new String[]{"cluster_monitor_register","email_monitor_register","sms_monitor_register"};
       // String[] tables=new String[]{"cluster_monitor_register"};
        for(String table:tables) {
            String sql = "delete from " + table + " " + "where register_name=" + "\"" + register + "\"" + ";";
            System.out.println(sql);
            stmt.executeUpdate(sql);
        }

        close();

        }

    public void insert(String register_name,String metric,String host,String Threshold,String type,String ex) throws SQLException{
        init("cluster_monitor");
        //INSERT INTO `sms_monitor_register` VALUES ('$metric[0]','$sms[1]','$sms[0]','$sms[2]','$sms[3]','$sms[4]','$sms[5]')
       // String sql ="insert into cluster_monitor_register values "+"("+"\'"+register_name+"\'"+","+"\'"+metric+"\'"+","+"\'"+host+"\'"+","+"\'"+Threshold+"\'"+","+"\'"+type+"\'"+","+"\'"+ex+"\'"+","+"'10000','hbase'"+")"+";";
     //   String sql0="insert into cluster_monitor_register values ('123','123','','1000','eq','','10000','hadoop');";
       // String sql1="insert into email_monitor_register values ('123','','hadoop_admin@staff.sina.com.cn','Hadoop Cluster Warning!','\"The cunrrent value of metric(%metric%) is %current_value%,which exceeded the threshold(%threshold%)\"','100','0','0','1','0');";
          String sql="insert into sms_monitor_register values ('','','1','\"The cunrrent value of metric(%metric%) is %current_value%,which exceeded the threshold(%threshold%)\" ','0','0',\"0\");";
        System.out.println(sql);
      //  System.out.println(sql1);
      //  stmt.executeUpdate(sql0);
        //stmt.executeUpdate(sql1);
        close();

    }
    public void update(String register_name,String metric,String host,String threshold,String type,String ex) throws SQLException
    {
        init("cluster_monitor");
        //update cluster_monitor_register set extends="test",host_list="0" where register_name="123”;
        String sql_metric="update cluster_monitor_register set metric_name=" +"\""+metric+"\""+","+"host_list="+"\""+host+"\""+","+"threshold="+"\""+threshold+"\""+","+"judge_type="+"\""+type+"\""+","+"extends="+"\""+ex+"\""+" where register_name="+"\""+register_name+"\""+";";
        String sql_mail="update  email_monitor_register set metric_name=" +"\""+metric+"\""+","+"host_list="+"\""+host+"\""+","+"threshold="+"\""+threshold+"\""+","+"judge_type="+"\""+type+"\""+","+"extends="+"\""+ex+"\""+" where register_name="+"\""+register_name+"\""+";";
        System.out.println(sql_metric);
        stmt.executeUpdate(sql_metric);
        close();

    }



    public static void main(String[] args) {
       // String test="13";
       // int ts=0;
      //  if(!test.equals(""))
        //    ts=Integer.valueOf(test);
       // System.out.println(ts);
       List<Object> res=MySql.GetFromDataBase("monitorX","cluster_monitor_register","hadoopmaster2.4.0.disk_free");

      //  List<Object> res=MySql.GetFromDataBase("cluster_monitor","cluster_monitor_register",register);
      //  Object content=res.get(4);
        for(Object l:res)
        {
            System.out.println((String)l);
        }
        //System.out.println(content);

   //     Object host=res.get(1);
     //   Object Threshold=res.get(2);
     //   Object type=res.get(3);
     //   Object ex=res.get(4);
      /* for(Object a:res)
        {
            String test=a.toString();
            System.out.println(test);
        }*/
//      MySql test=new MySql();
//        try {
//            //test.update("123","","","10000","eq","testttt");
//            test.insert("","","","","","");
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }



    }
}
