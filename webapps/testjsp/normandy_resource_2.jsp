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
<form name="op" action="./normandy_resource_3.jsp" method="post">       
   <span style="font-size:30px;color:red">粘贴借用的机器列(注意：第一次操作，点击下面的《"确认操作"》很危险，最好来小黑屋找灰灰或者我check一下,后续会加强用户登入管理，目前没有时间搞~~~）</span>
</br>  
       <div style="margin:0 auto;width:200px;">  
    <label for="name">借用机器列表,只支持ip就酱</label>
    <textarea class="form-control" id="borrow"  name="borrow" rows="10"></textarea>
  </div>
<%
       out.println("<br>");
       out.println("<br>");
       out.println("<br>");
    Object cluster_obj=session.getAttribute("cluster");
    String cluster=cluster_obj.toString();
   String out_phy=request.getParameter("out_phy");
      String in_phy=request.getParameter("input_phy");
       session.setAttribute("out_phy",out_phy);
       session.setAttribute("input_phy",in_phy);
       session.setAttribute("cluster",cluster);
%>
<input type="submit" align="center"  class="btn-style-02" value="确认操作">
</form>
</body>
</html>
