<%@ page import="com.sina.data.util.MySql" %>
<%
    MySql test=new MySql();
    String register=request.getParameter("register");
    test.delete(register);
    response.sendRedirect("3.jsp");
%>