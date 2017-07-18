<%@ page
import="java.text.SimpleDateFormat"
import="java.util.Date"
%>
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         out.println(df.format(new Date())  + " miao miao miao start"); 
%>
