<%@page
import="net.sf.json.JSONArray"
import="java.util.ArrayList"
import="java.util.List"
%>

<%
        //List<String> aaa=new ArrayList<String>();
        //aaa.add("jajaja");
       // JSONArray test=new JSONArray();
       // test=JSONArray.fromObject(aaa);
        
            Object num=session.getAttribute("hahaha");
            Object obj_op=session.getAttribute("op");
         //   Object obj_listnode=session.getAttribute("listnode");
              int num1 = Integer.parseInt(num.toString());
        String op=obj_op.toString();
          out.println(op);
           String[] host=new String[num1+1]; 
         String[] metajson=new String[num1+1]; 
         String[] listnode=new String[num1]; 
         for (int j=1;j<num1+1;j++)
            {
             Object obj_host=session.getAttribute("host"+j);
             Object obj_metajson=session.getAttribute("metajson"+j);
           Object obj_listnode=session.getAttribute("listnode"+j);
             host[j]=obj_host.toString();
             metajson[j]=obj_metajson.toString();
             listnode[j-1]=obj_listnode.toString();
               String[] matrixNodeInfo=listnode[j-1].split(":");
             String  ms = matrixNodeInfo[0];
             String  user = matrixNodeInfo[2];
             String  token = matrixNodeInfo[3];
             String serviceName = matrixNodeInfo[4];
 
            //out.println(host[j]);
          out.println(ms);
          out.println(user);
          out.println(token);
          out.println(serviceName);
         }
          //out.println(listnode);
          //out.println(metajson);
         //out.println(test);
%>
