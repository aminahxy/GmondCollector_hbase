<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<form name="op" action="./333.jsp" method="post">
<title>test</title>
<style type="text/css">
.ct{
text-align:center;
}
</style>
<%@ page
import="tentacles.util.*"
import="net.sf.json.JSONArray"
import="java.util.*"
import="java.io.*"
%>
<script type="text/javascript">
function allCheck(){
    var obj=document.getElementsByTagName("input");
    if(document.getElementById("all").checked==true){
        for(var i=0;i<obj.length;i++){
            obj[i].checked=true;
        }
    }else{
        for(var i=0;i<obj.length;i++){
            obj[i].checked=false;
        }
    }
}
function checkT_F(){
    var obj=document.getElementsByTagName("input");
    var j=0;
    for(var i=0;i<obj.length;i++){
        if(obj[i].id!='all'){   
            if(obj[i].checked==true){  
                j++;
            }
        }
    }
    if(j==(obj.length-1)){   
        document.getElementById("all").checked=true;
    }else{
        document.getElementById("all").checked=false;
    }
}
</script>
</head>
<body>
<onclick="javascript:checkT_F()">
<div>
    <%
        String clusterName = request.getParameter("cluster");
        out.println("<Br>");
        out.println("<Br>");
        out.println("<Br>");
        out.println("Cluster name : " + clusterName + "<Br>");
        String operation="ls /home/normandy/normandy_scheduler/workspace/conf";
        out.println("operation : " + operation + "<Br>");
    %>
    <div class="zuo">
    <div><input type="checkbox" id="all"  onclick="javascript:allCheck()"/>all</div>
    </div>
    <%

      Runtime rt = null;
      InputStream in = null;
     
      String service="normandy";
      
      String [] command =  {"sh", "/home/tentacles/tentacles-v1.0/script/ssh_tool/ssh.sh", service, clusterName, operation};
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
              //out.println(str);
              //out.println("<br>");
              out.flush();
          }
          if(count ==0){
              System.out.println(" error "  );
          }

      } catch (IOException e) {
          e.printStackTrace();
      }finally {
          try {
              if (reader != null) reader.close();
              if (in != null) in.close();
          } catch (IOException e) {
              e.printStackTrace();
          }
      }

      String [] res = sb1.toString().split("\n");
    for(int i=0;i<res.length;i++) {%>
     <div><input type="checkbox" name="phy" value="<%=res[i]%>">[<%=res[i]%>]</div>
  <%}
 %>
 </div>
  <label class="checkbox-inline">
      <input type="radio" name="choose" id="large"
         value="<%=clusterName%>l" checked>全量
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="choose" id="small"
         value="<%=clusterName%>s">小流量
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="choose" id="small"
         value="<%=clusterName%>e">error拉起
   </label>
<input type ="submit" value ="下一步">
</body>
</html>
