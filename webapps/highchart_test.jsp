<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page contentType="text/html; charset=GB2312"%>
<%
    String begStr = request.getParameter("startTime");
    String endStr = request.getParameter("endTime");
    String clusterName=session.getAttribute("cluster").toString();
    //out.print(clusterName);
  //  out.print(clusterName.length());
   // out.print("hadoop-2.4.0-master".length());
    SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date date1=simpleDateFormat.parse(begStr);
    Date date2=simpleDateFormat.parse(endStr);
    String begStemp = String.valueOf(date1.getTime()).substring(0,10);
    String endStemp = String.valueOf(date2.getTime()).substring(0,10);
    String[] arr= request.getParameterValues("metric");
    String sb="";
    /*for(int i=0;i<arr.length;i++)
    {
        sb+=arr[i];
    }
    String[] brr=sb.split("#");
    for(String s:brr)
    {
        out.print(s);
        out.print("\n");
    }*/
    out.print(begStemp);
    out.print("\n");
    out.print(endStemp);
    int end=Integer.valueOf(endStemp);
    int start=Integer.valueOf(begStemp);
    if(end-start<=3600)
    {
        out.print("org");
    }
    else if(end-start<=14400)
    {
        out.print("hour");
    }
    else
    {
        out.print("day");
    }

%>

