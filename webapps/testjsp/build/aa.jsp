<%@page
import="net.sf.json.JSONArray"
import="java.util.ArrayList"
import="java.util.List"
import="java.io.File"
import="java.io.FileWriter"
import="java.io.BufferedWriter"
import="java.io.IOException"
import="com.baidu.inf.matrix.master.rpc.masterclientproto.ThriftInstanceMeta"
import="com.google.gson.Gson"
import="org.apache.thrift.TException"
import="tentacles.matrix_util.GetInstanceMetaInService"
import="org.apache.thrift.transport.TTransportException"
import="tentacles.matrix_util.GetMultiMetaInstance"
import="tentacles.util.Get_Conf_Concurrent"
import="tentacles.util.*"
import="tentacles.http_tools.*"
import="java.io.PrintWriter"
import="java.io.StringWriter"
import="java.util.HashMap"
import="java.util.List"
import="java.util.Map"
import="java.util.Date"
import="java.util.regex.Matcher"
import="java.util.regex.Pattern"
%>
<%
        List<String> aaa=new ArrayList<String>();
        String cluster = request.getParameter("cluster");
        String module = request.getParameter("module");
        aaa.add("jajaja");
        JSONArray test=new JSONArray();
       test=JSONArray.fromObject(aaa);
       request.setCharacterEncoding("UTF-8");
     // out.println(test);

        java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
          new_rand_version = format1.format(new Date());
       try{

           File file =new File("/home/tentacles/tentacles-v1.0/webapp/module_online/"+new_rand_version +"test.txt");
           if(!file.exists()){
               file.createNewFile();
           }
           FileWriter fileWritter = new FileWriter(file);
           BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
           bufferWritter.write(cluster+"\n");
           bufferWritter.write(module+"\n");
           bufferWritter.close();
       }catch(IOException e){
           e.printStackTrace();
       }

      out.println(test);
%>