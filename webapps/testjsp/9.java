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
        import="com.baidu.inf.ark.client.ClientException"
        import="java.io.*"
        import="java.io.File"
        import="java.io.FileOutputStream"
        import="java.io.*"
        %>
<%
        out.println("<Br>");
        out.println("<Br>");
        out.println("<Br>");
        //变量定义
        FileOutputStream out_file = null;
        Object cluster_obj=session.getAttribute("cluster");
        Object out_obj=session.getAttribute("out_phy");
        Object in_obj=session.getAttribute("input_phy");
        String cluster=cluster_obj.toString();
        String host = request.getParameter("borrow");
        String out_phy=out_obj.toString();
        String input_phy=in_obj.toString();
        String []phy_out=new String[1];
        phy_out[0]=out_phy;
        List<String> test_tag=new ArrayList<String>();
        matrix_adminop clientop=new matrix_adminop();
        //stop normandy_agent
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
        Process proc = null;
        BufferedReader reader = null;
        StringBuilder sb1 = new StringBuilder();
        rt = Runtime.getRuntime();
        int count = 0;

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
        List testhui= testnode.get_phy_single(clustername, phy_out);
        String matrix_service=testhui.toString().split(":")[0].substring(1, testhui.toString().split(":")[0].length());
        String user=testhui.toString().split(":")[2];
        String token=testhui.toString().split(":")[3];
        String serviceName=testhui.toString().split(":")[4];
        String tags=testhui.toString().split(":")[5];
        test_tag.add(tags);
        out.println(matrix_service=);
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

        for(int i=0;i<host.split(" ").length;i++)
        {
        String host1=host.split(" ")[i];
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




        //start normandy 脚本
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











//        out.println("hahahayyppp");
//        for (int i=0;i<10;i++){
//        out.println("waiting");
//        Thread.sleep(300000);
//        out.flush();
//        }

//        out.println("start print tag");

        //打tag

       //启动脚本



        %>









