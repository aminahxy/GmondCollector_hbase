<%@ page
import="tentacles.util.*"
import="tentacles.matrix_util.*"
import="tentacles.http_tools.*"
import="tentacles.matrix_util.*"
import="java.util.HashMap"
import="java.util.List"
import="java.util.Map"
import="java.util.*"
%>
<!DOCTYPE html>
<html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>
   <title>normandy_phy</title>
   <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <script src="./jquery.min.js"></script>
   <script src="./bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<form name="op" action="./00.jsp" method="post">
<div class="table-responsive">
   <table class="table">   
       <thead>    
      <tr>
           <th>物理队列</th>
           <th colspan="2">metajson</th>
           <th colspan="2">host</th>
         </tr>
 </thead>
 <tbody>
<%     
        out.println("<br>");
        out.println("<br>");
        out.println("<br>");
        out.println("<br>");
        int i=0;    
        int j=100;
        int littlenum=0;
        String op=request.getParameter("choose");
        String clusterName=op.substring(0,op.length()-1);;
        String op_real=op.substring(op.length()-1,op.length());
        String arr[]= request.getParameterValues("phy");
        get_single_phy single=new get_single_phy();
        List testhui=single.get_phy_single(clusterName,arr);
        GetMatrixNodeByClusterTag testhh=new GetMatrixNodeByClusterTag();
        //out.println("hahaha"+testhui);
        //out.println("<br>");
        //session.setAttribute("listnode",testhui);
        Map<String, Map<Object,Map<String,Map<String,Object>>>> resultmap=testhh.GetMatrixNode(testhui);
       
        for (Map.Entry<String, Map<Object,Map<String,Map<String,Object>>>> entry : resultmap.entrySet() )
         { i++; 
          j++;
        //out.println(entry.getKey());
        //out.println("<br>");
        session.setAttribute("listnode_test"+i,entry.getKey());
         %><tr><td>[<%=entry.getKey().toString().split(":")[entry.getKey().toString().split(":").length-1]%>]</td><%
        
         Map<Object,Map<String,Map<String,Object>> > metaInstance = entry.getValue();
        for ( Map.Entry<Object,Map<String,Map<String,Object>>> entry1 : metaInstance.entrySet()) {
           %><td>
            <button id="btn" type="button"  class="btn btn-primary" onClick="edittxt('<%=i%>')" >修改metajson</button>
          </td><%
            %><td>
           <textarea class="form-control" id=<%=i%>  name=<%=i%> type="txt" rows="8" readonly="readonly" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"><%=entry1.getKey()%></textarea>
           </td><%
         // out.println("meta json is : ");
          //      out.println("<br>");
       
         //out.println(entry1.getKey());
         //       out.println("<br>");
         StringBuffer scheduler = new StringBuffer();
         StringBuffer scheduler_error=new StringBuffer();
       for ( Map.Entry<String,Map<String,Object>> entryChild : entry1.getValue().entrySet() ) {

         //out.println(entryChild.getKey());
          scheduler.append(entryChild.getKey()+"\n");
              if(entryChild.getValue().get("State").equals("ERROR"))
                  {
                  scheduler_error.append(entryChild.getKey()+"\n");
                  }

        }
          littlenum=scheduler.toString().split("\n").length;
          String[] little=scheduler.toString().split("\n");
         StringBuffer little_play=new StringBuffer();    
         //StringBuffer scheduler_error=new StringBuffer();
          switch (littlenum>5?(littlenum<=10?1:0):0){

                        case 1:

                        for (int w=0;w<3;w++)
                        {
                        little_play.append(little[w]+"\n");
                        }
                        break;

                default:
                        switch (littlenum<=5?1:0){
                        case 1:
                        little_play.append(little[0]+"\n");
                        break;
                default:
                        switch (littlenum>10?(littlenum<=20?1:0):0)
                        {case 1:
                        for (int w=0;w<5;w++)
                        {
                        little_play.append(little[w]+"\n");
                        }
                        break;
                default:
                        for (int w=0;w<10;w++)
                        {
                        little_play.append(little[w]+"\n");
                        }
                        }
                        }
                        break;
                        }
                        //out.println(little_play);

         %><td>
        <button id="btn_host" type="button"  class="btn btn-primary" onClick="edithost('<%=j%>')">修改host列表</button>
          </td><%
          if(op_real.equals("l")){
         %><td>
           <textarea class="form-control" id=<%=j%>  name=<%=j%> type="txt"  rows="8" readonly="readonly" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"><%=scheduler%></textarea>
           </td><%}
           else if(op_real.equals("s"))
           {
                %><td>
                   <textarea class="form-control" id=<%=j%>  name=<%=j%> type="txt"  rows="8" readonly="readonly" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"><%=little_play%></textarea>
                   </td><%
           }
           else
           {
            %><td>
                   <textarea class="form-control" id=<%=j%>  name=<%=j%> type="txt"  rows="8" readonly="readonly" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"><%=scheduler_error%></textarea>
            </td><%
           }
        }
         %></tr><%
        }
       session.setAttribute("hahaha",i);
      //out.println("hahaha" + i);
%>
</div>
<script type="text/javascript">
   var txt = new Array(100);
   var host = new Array(200);
   for(var i=1;i<100;i++) { 
    txt[i] = document.getElementById(i);
    host[i] = document.getElementById(i);
    host[i+100] = document.getElementById(i+100);
}

    function edittxt(x){
            txt[x].removeAttribute('readonly');
        }
    function edithost(x){
            host[x].removeAttribute('readonly');
        }
</script>
<div class="container">
        <div class="row clearfix">
                <div class="col-md-3 column">
                         <button type="button" onclick="window.location.href='000.jsp'" class="btn btn-default btn-block">做包</button>
                </div>
                <div class="col-md-6 column">
                  <label class="checkbox-inline">
      <input type="radio" name="op_request" id="add"
         value="add" checked>add
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="op_request" id="delete"
         value="delete">delete
   </label>

   <%
   if(op_real.equals("e"))
   {
     %><label class="checkbox-inline">
            <input type="radio" name="op_request" id="update"
               value="update">update
         </label><%
      %><label class="checkbox-inline">
         <input type="radio" name="op_request" id="power_update"
            value="power_update">power_update
      </label><%
      }
      else
      {
         %><label class="checkbox-inline">
            <input type="radio" name="op_request" id="update"
               value="update">update
         </label><%
      }
   %>

   <label class="checkbox-inline">
      <input type="radio" name="op_request" id="reset"
         value="reset">reset
   </label>
   <label class="checkbox-inline">
   <input type ="submit" value ="提交">
   </label>
                </div>
                <div class="col-md-3 column">
                         <button type="button" class="btn btn-default btn-block">回滚</button>
                </div>
        </div>
</div>
</table>
</form>
</body>
</html>
