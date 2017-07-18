<%@ page
import="tentacles.util.*"
import="net.sf.json.JSONArray"
%>
<!DOCTYPE html>
<html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>
   <title>normandy_phy</title>
   <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <script src="./jquery.min.js"></script>
   <script src="./bootstrap/js/bootstrap.min.js"></script>
<title>test</title>
<style type="text/css">
.ct{
text-align:center;
}
</style>
<style type="text/css">
body {
        font:12px "微软雅黑",Verdana, Arial, Geneva, sans-serif;
}
img {
}
input{
        border-style:none;
        padding:8px 30px;
        color:#fff;
        cursor:pointer;
}
.btn-style-02 {
        border-radius:4px;
        background-color:#31c0f0;
        background-image: -webkit-gradient(linear, 0 0%, 0 100%, from(#31c0f0), to(#1cabda));
        background-image: -webkit-linear-gradient(top, #31c0f0 0%, #1cabda 100%);
        background-image: -moz-linear-gradient(top, #31c0f0 0%, #1cabda 100%);
        background-image: -ms-linear-gradient(top, #31c0f0 0%, #1cabda 100%);
        background-image: -o-linear-gradient(top, #31c0f0 0%, #1cabda 100%);
        background-image: linear-gradient(top, #31c0f0 0%, #1cabda 100%);
}
.btn-style-02:hover {
        background-color:#1cabda;
        background-image: -moz-linear-gradient(top, #1cabda 0%, #31c0f0 100%);
        background-image: -ms-linear-gradient(top, #1cabda 0%, #31c0f0 100%);
        background-image: -o-linear-gradient(top, #1cabda 0%, #31c0f0 100%);
        background-image: linear-gradient(top, #1cabda 0%, #31c0f0 100%);
}
</style>
<body>
<form name="op" action="./normandy_resource_2.jsp" method="post">
<div class="table-responsive">
   <table class="table">
   <thead>
      <tr>
         <th>调出物理队列</th>
         <th>调入物理队列</th>
      </tr>
   </thead> 

<tbody>
   <%
       out.println("<br>");
       out.println("<br>");
       out.println("<br>");
       out.println("<br>");
      String clusterName = request.getParameter("cluster");
      get_single_phy single=new get_single_phy();
      JSONArray singletest=single.get_phy(clusterName);
      // out.println(clusterName);
session.setAttribute("cluster",clusterName);
    String[] a=new String[singletest.toString().split(",").length];
      for (int j=0;j<singletest.toString().split(",").length;j++)
       {  a[j]=singletest.toString().replace("\"","").replace("[","").replace("]","").split(",")[j];
          }
    for(int i=0;i<singletest.toString().split(",").length;i++) {
     %><tr><td>
     <div><input type="checkbox" class="mybox" onclick="checkBox($(this));" name="out_phy" value="<%=a[i]%>">[<%=a[i]%>]</div>
     </td><% 
     %><td>
     <div><input type="checkbox" class="youbox" onclick="checkbox($(this));" name="input_phy" value="<%=a[i]%>">[<%=a[i]%>]</div>
     </td> 
     </tr><%
    }
 %>
<script language="javascript">
<!--
function checkBox(obj) {
// 只有当选中的时候才会去掉其他已经勾选的checkbox，所以这里只判断选中的情况
    if (obj.is(":checked")) {
         // 先把所有的checkbox 都设置为不选种
        $('input.mybox').prop('checked', false);
        // 把自己设置为选中
        obj.prop('checked',true);
    }
}
function checkbox(obj) {
// 只有当选中的时候才会去掉其他已经勾选的checkbox，所以这里只判断选中的情况
    if (obj.is(":checked")) {
         // 先把所有的checkbox 都设置为不选种
        $('input.youbox').prop('checked', false);
        // 把自己设置为选中
        obj.prop('checked',true);
    }
}
//-->
</script>
<tr><td>
</td>
<td>
<input type="submit" align="center"  class="btn-style-02" value="下一步">
</td>
</tr>
</div>
</div>
</div>
</table>
</form>
</body>
</html>
