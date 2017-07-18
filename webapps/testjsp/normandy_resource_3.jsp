<%@ page
contentType="text/html; charset=utf-8"
        import="java.text.SimpleDateFormat"
        import="java.util.*"
        import="javax.servlet.*"
        import="tentacles.http.test"
        import="java.util.LinkedHashMap"
        import="java.util.Map"
        import="java.util.*"
        import="tentacles.grab.tentacles_job"
        import="tentacles.grab.analyze"
        import="tentacles.util.*"
        import="com.baidu.inf.ark.client.ClientException"
        import="java.io.*"
        import="java.io.File"
        import="java.io.FileOutputStream"
        import="java.io.*"
        import="com.baidu.inf.matrix.master.rpc.common.ThriftUGI"
        import="com.baidu.inf.matrix.master.rpc.masterclientproto.*"
        import="com.baidu.inf.matrix.resourcemanager.rpc.thrift.proto.client.ResourceManagerException"
        import="com.google.gson.ExclusionStrategy"
        import="com.google.gson.FieldAttributes"
        import="com.google.gson.Gson"
        import="com.google.gson.GsonBuilder"
        import="org.apache.thrift.TException"
        import="org.apache.thrift.protocol.TBinaryProtocol"
        import="org.apache.thrift.protocol.TProtocol"
        import="org.apache.thrift.transport.TFramedTransport"
        import="org.apache.thrift.transport.TSocket"
        import="org.apache.thrift.transport.TTransport"
        import="java.io.IOException"
        import="java.util.ArrayList"
        import="java.util.List"
        import="org.apache.thrift.transport.TTransportException"
        import="tentacles.matrix_util.GetInstanceMetaInService"
        import="tentacles.matrix_util.GetMultiMetaInstance"
        import="tentacles.util.Get_Conf_Concurrent"
        import="tentacles.util.*"
        %>
<%
        out.println("<Br>");
        out.println("<Br>");
        out.println("waiting");
        out.println("waiting");
        out.println("waiting");
        out.println("don't worry,because we will waiting the ababci Recycling resources, most waiting 5minutes,it will be ok");
        FileOutputStream out_file = null;
        Object cluster_obj=session.getAttribute("cluster");
        Object out_obj=session.getAttribute("out_phy");
        Object in_obj=session.getAttribute("input_phy");
        String cluster=cluster_obj.toString();
        String host = request.getParameter("borrow");
        String out_phy=out_obj.toString();
        String input_phy=in_obj.toString();
        String []phy_in=new String[1];
        phy_in[0]=input_phy;
        List<String> test_tag=new ArrayList<String>();
        matrix_adminop clientop=new matrix_adminop();
        try {
        out_file = new FileOutputStream(new File("/home/tentacles/relyfile/list"));
        out_file.write(host.getBytes());
        out_file.close();
        } catch (Exception e) {
        e.printStackTrace();
        }
 
        Runtime rt = null;
        InputStream in = null;
        String [] command =  {"sh", "/home/tentacles/relyfile/stop_normandy.sh", cluster};
        String [] command1 =  {"sh", "/home/tentacles/relyfile/start_normandy.sh", cluster};
        Process proc = null;
        BufferedReader reader = null;
        StringBuilder sb1 = new StringBuilder();
        rt = Runtime.getRuntime();
        int count = 0;
      //stop normandy_agent脚本
        try {
        proc = rt.exec(command);
        in = proc.getInputStream();
        reader = new BufferedReader(new InputStreamReader(in));
        String str = null;
        count = 0;
        while ((str = reader.readLine()) != null) {
        count++;
        sb1.append(str + "\n");
        out.println(str);
        out.println("<br>");
        out.flush();
        }
        }
        catch (IOException e) {
        e.printStackTrace();
        }
        finally {
        try {
        if (reader != null) reader.close();
        if (in != null) in.close();
        } catch (IOException e) {
        e.printStackTrace();
        }
        }
          //打tag部分
       get_single_phy testnode=new get_single_phy();
        List testhui= testnode.get_phy_single(cluster, phy_in);
        String matrix_service=testhui.toString().split(":")[0].substring(1, testhui.toString().split(":")[0].length());
        String user=testhui.toString().split(":")[2];
        String token=testhui.toString().split(":")[3];
        String serviceName=testhui.toString().split(":")[4];
        String tags=testhui.toString().split(":")[5].substring(0, testhui.toString().split(":")[5].length()-1);
        test_tag.add(tags);
        out.println(matrix_service);
        out.println(user);
        out.println(token);
        out.println(serviceName);
        out.println(host);
        out.println(tags);
                try{
        clientop.matrix_admin_open(matrix_service);
        }
        catch ( TTransportException e)
        {

        StringWriter sw=new StringWriter();
        PrintWriter pw=new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println(sw.toString());
        }
        int host_num=host.split("\n").length;
        for(int i=0;i<host_num;i++)
        {
        String host1=host.split("\n")[i].trim();
        try{
        clientop.matrix_updatetag(user,token,host1,test_tag);
        }catch(org.apache.thrift.TException e)
        {
        StringWriter sw=new StringWriter();
        PrintWriter pw=new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println(sw.toString());
        }
        }
        //start normandy_agent 脚本
        try {
        proc = rt.exec(command1);
        in = proc.getInputStream();
        reader = new BufferedReader(new InputStreamReader(in));
        String str = null;
        count = 0;
        while ((str = reader.readLine()) != null) {
        count++;
        sb1.append(str + "\n");
        out.println(str);
        out.println("<br>");
        out.flush();
        }
        }
        catch (IOException e) {
        e.printStackTrace();
        }
        finally {
        try {
        if (reader != null) reader.close();
        if (in != null) in.close();
        } catch (IOException e) {
        e.printStackTrace();
        }
        }



%>
