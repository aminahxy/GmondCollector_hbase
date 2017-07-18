<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %><%
    //metric setting     register_name
    String register_name= request.getParameter("register_name");
    //out.println(register_name);
    String metric=request.getParameter("metric");
    String host=request.getParameter("host");
    String threshold=request.getParameter("threshold");
    int int_threshold=0;
    if(!threshold.equals(""))
        int_threshold=Integer.valueOf(threshold);
    String type=request.getParameter("metric_judge_type");
    String ex=request.getParameter("ex");
    //response.sendRedirect("3.jsp");
    //out.println("metric is"+metricname);
    //out.println("host is"+host);
  //  out.println("thre is"+threshold);
   // out.println("type"+type);
    //out.println("ex is "+ex);

    // email_setting
    String send_people=request.getParameter("email_sent_people");
    String rev_list=request.getParameter("email_receive_list");
    String theme=request.getParameter("email_theme");
    String content=request.getParameter("email_content");
    String in_time=request.getParameter("email_interval_time");
    int int_in_time=0;
    if(!in_time.equals(""))
        int_in_time=Integer.valueOf(in_time);
    String last_time=request.getParameter("email_last_time");
    int int_last_time=0;
    if(!last_time.equals(""))
        int_last_time=Integer.valueOf(last_time);
    String email=request.getParameter("email");
    int int_email=0;
    if(!email.equals(""))
        int_email=Integer.valueOf(email);

   /* out.println("people is" +send_people);
    out.println("rev is" +rev_list);
    out.println("theme is" +theme);
    out.println("content is" +content);
    out.println("time is" +in_time);
    out.println("last time is" +last_time);*/

   // out.println("extends is" +email);

    //sms_setting
    String sms_rev_list=request.getParameter("sms_receive_list");
    String sms_content=request.getParameter("sms_content");
    String sms_interval_time=request.getParameter("sms_interval_time");
    int int_sms_interval_time=0;
    if(!in_time.equals(""))
        int_sms_interval_time=Integer.valueOf(sms_interval_time);
    String sms_last_time=request.getParameter("sms_last_time");
    int int_sms_last_time=0;
    if(!sms_last_time.equals(""))
        int_sms_last_time=Integer.valueOf(sms_last_time);

    String sms_extends=request.getParameter("sms_extends");

    int int_sms_extends=0;
    if(!sms_extends.equals(""))
        int_sms_extends=Integer.valueOf(sms_extends);



    String url = "jdbc:mysql://10.39.0.101:3306/cluster_monitor";
   Connection conn=null;
    Statement stmt=null;
    try {
        conn = DriverManager.getConnection(url, "monitor", "monitor");
        stmt = conn.createStatement();
    }
    catch (Exception e) {
        e.printStackTrace();

    }

    //update cluster_monitor_register set extends="test",host_list="0" where register_name="123”;
   String metric_sql ="insert into cluster_monitor_register values "+"("+"\'"+register_name+"\'"+","+"\'"+metric+"\'"+","+"\'"+host+"\'"+","+"\'"+int_threshold+"\'"+","+"\'"+type+"\'"+","+"\'"+ex+"\'"+","+"'10000','hadoop'"+")"+";";
   String sms_sql ="insert into sms_monitor_register values "+"("+"\'"+register_name+"\'"+","+"\'"+sms_rev_list+"\'"+","+"'0'"+","+"\'"+sms_content+"\'"+","+"\'"+int_sms_interval_time+"\'"+","+"\'"+int_sms_last_time+"\'"+","+"\""+int_sms_extends+"\""+")"+";";
   String mail_sql ="insert into email_monitor_register values "+"("+"\'"+register_name+"\'"+","+"\'"+rev_list+"\'"+","+"\'"+send_people+"\'"+","+"\'"+theme+"\'"+","+"\'"+content+"\'"+","+"\'"+int_in_time+"\'"+","+"\""+int_last_time+"\""+","+"\""+int_email+"\""+","+"'0','0'"+")"+";";
    stmt.executeUpdate(metric_sql);
    stmt.executeUpdate(mail_sql);
    stmt.executeUpdate(sms_sql);

   //String sms_sql=
   //out.println("metric is"+metric_sql+"\n");
  // out.println("mail is"+mail_sql+"\n");
  // out.println("sms is"+sms_sql+"\n");
   try {
        conn.close();
        stmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    //test.stmt.executeUpdate(sql);



    /*out.println(sms_rev_list+"\n");
    out.println(sms_content+"\n");
    out.println(sms_interval_time+"\n");
    out.println(sms_last_time+"\n");
    out.println(sms_extends+"\n");*/
   response.sendRedirect("3.jsp");




%>