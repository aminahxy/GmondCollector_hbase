<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>test</title>
<style type="text/css">
.ct{
text-align:center;
}
</style>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="jquery.form.min.js"></script>

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
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
                       
           <div class="text" style=" text-align:center;">
          <span style="font-size:30px;color:red">查看上线进度可点击下面链接,请注意上线的话<<"确认操作">> 一定要点，否则不会操作,不上线的话一定不要点啊!!!上线一定要点啊，不上线一定不要点啊，重要的事情说3遍，我是话唠，嗯嗯</span>
         <div style="margin:0 auto;width:200px;">
       <form id="my_form" action="matrix_op.jsp" method="post"> 
      <input type="submit" align="center"  class="btn-style-02" value="确认操作"><span id="msg"></span>
    </div>  	
</div>


<%@ page
%>
</head>
<body>
<div id="matrix_op">
<%
           out.println("<br>");
           out.println("<br>");
       String op_request_last=request.getParameter("op_request");
      session.setAttribute("op",op_request_last);
      //out.println(op);
    Object num=session.getAttribute("hahaha");
    //String num1=num.toString();
    int num1 = Integer.parseInt(num.toString());
   
    String[] host=new String[num1+1];
   String[] metajson=new String[num1+1];
   String[] listnode_display=new String[num1+1];
   // Object listnode_obj=session.getAttribute("listnode_test"+1);
  // String listnode=listnode_obj.toString();
   //  out.println(listnode);
  // out.println(listnode);
/* for (int i=1;i<=num1;i++)
{    
     Object listnode_obj=session.getAttribute("listnode_test"+i);
      listnode[i]=listnode_obj.toString();
       out.println(listnode[i]);
           out.println("<br>");
}*/
//   String listnode_tmp=listnode.substring(1,listnode.length()-1);
//   String[] listnode_display=new String[num1+1];
   for(int i=1;i<=num1;i++)
   {
     Object listnode_obj=session.getAttribute("listnode_test"+i);
      listnode_display[i]=listnode_obj.toString();
     //  out.println(listnode_display[i]);
      //     out.println("<br>");
      int j=100+i;
      String host_str=""+j;
      String metajson_str=""+i;
      host[i]=request.getParameter(host_str);
      metajson[i]=request.getParameter(metajson_str);
  //    listnode_display[i-1]=listnode_tmp.split(" ")[i-1].trim();
       String[] matrixNodeInfo=listnode_display[i].split(":");
      //out.println(matrixNodeInfo);
        String  ms = matrixNodeInfo[0];
       String service = matrixNodeInfo[4];
        session.setAttribute("host"+i,host[i]);
        session.setAttribute("metajson"+i,metajson[i]);
        session.setAttribute("listnode"+i,listnode_display[i]);
         //out.println(ms);
       out.println("<a href=http://" + ms + ":8529/servicedetail.jsp?serviceName=" + service + ">"+listnode_display[i]+"</a>");
           out.println("<br>");
            out.println("<br>");
            out.println("<br>");
            out.println("<br>");
     //out.println(listnode_display[i]);
    //out.println(metajson[i]);
     
}
   //session.setAttribute("host",host);
   //session.setAttribute("listnode",listnode);  
   //out.println(listnode);
   
   %>
 </form>
        </body></html>
