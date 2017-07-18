<!DOCTYPE html>
<html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>
   <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <script src="./jquery.min.js"></script>
   <script src="./bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
   <div class="text" style=" text-align:center;">
<br>       
</br>       
<br>
<form name="op" action="./normandy_tag_3.jsp" method="post">       
</br>  
       <div style="margin:0 auto;width:200px;">  
    <label for="name">需要打tag的机器列表,只支持ip就酱</label>
    <textarea class="form-control" id="borrow"  name="borrow" rows="10"></textarea>
  </div>
<%
       out.println("<br>");
       out.println("<br>");
       out.println("<br>");
    Object cluster_obj=session.getAttribute("cluster");
    String cluster=cluster_obj.toString();
   String out_phy=request.getParameter("out_phy");
       session.setAttribute("out_phy",out_phy);
       session.setAttribute("cluster",cluster);
%>
<input type="submit" align="center"  class="btn-style-02" value="确认操作">
</form>
</body>
</html>
