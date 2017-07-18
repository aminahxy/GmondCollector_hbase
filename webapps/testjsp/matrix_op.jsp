<%@ page
import ="java.io.BufferedReader"
import ="java.io.FileReader"
import ="java.io.UnsupportedEncodingException"
import="java.nio.Buffer"
import="java.text.DecimalFormat"
import="tentacles.util.EasyWebGet"
import="tentacles.util.host_ip"
import="tentacles.util.get_host"
import="tentacles.util.*"
import="tentacles.util.matrix_clientop"
import="java.io.IOException"
import="java.util.HashMap"
import="java.util.Map"
import="java.util.logging.FileHandler"
import="java.util.regex.*"
import="com.google.gson.Gson"
import="com.baidu.inf.matrix.master.rpc.masterclientproto.ThriftInstanceMeta"
import="java.io.PrintWriter"
import="java.io.StringWriter"
import="org.apache.thrift.transport.TTransportException"
import="org.apache.thrift.TException"
import="java.util.Date"
import="java.util.List"
import="java.util.regex.Matcher"
import="java.util.regex.Pattern"
import="com.google.gson.GsonBuilder"
import="org.apache.thrift.TException"
import="tentacles.matrix_util.GetInstanceMetaInService"
import="org.apache.thrift.transport.TTransportException"
import="tentacles.matrix_util.GetMultiMetaInstance"
import="tentacles.util.Get_Conf_Concurrent"
import="tentacles.http_tools.*"
import="java.util.HashMap"
import="java.util.List"
import="java.util.Map"
import="java.util.Date"
import="java.util.regex.Matcher"
import="java.util.regex.Pattern"
%>
<html ><head id="Head1"><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="matrix_op">
<%  
Object num=session.getAttribute("hahaha");
Object obj_op=session.getAttribute("op");
//   Object obj_listnode=session.getAttribute("listnode");
int num1 = Integer.parseInt(num.toString());
//        out.println(obj_op.toString());
String op=obj_op.toString();
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
	String[]matrixNodeInfo=listnode[j-1].split(":");
	String matrix_service=matrixNodeInfo[0];
	String user=matrixNodeInfo[2];
	String token=matrixNodeInfo[3];
	String serviceName=matrixNodeInfo[4];
	Gson testgson=new Gson();
	get_host get_host=new get_host();
	matrix_clientop clientop=new matrix_clientop();
 
	try{
		clientop.matrix_client_open(matrix_service);
	}
	catch(TTransportException e)
	{
		StringWriter sw=new StringWriter();
		PrintWriter pw=new PrintWriter(sw);
		e.printStackTrace(pw);
		out.println(sw.toString());
	}

	ThriftInstanceMeta metatest=testgson.fromJson(metajson[j],ThriftInstanceMeta.class);

  // String regex = "packageVersion.*,";
    //            String input = metajson[j];
      //          Pattern p = Pattern.compile(regex);
        //        Matcher m = p.matcher(input);
          //      StringBuffer packageVersion = new StringBuffer();
            //    while (m.find()) {
              //      packageVersion.append(input.substring(m.start(), m.end()) + "\n");
               // }
                 //  String old_package=packageVersion.toString().split(",")[0].split(":")[1].replace("\"","");

               //        Date dateTmp1 = new Date();
             //   String new_rand_version=null;
             //   java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd-kk-mm-ss");
            //    new_rand_version = format1.format(new Date());
             //   System.out.println(new_rand_version);
                   java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd-kk-mm-ss");

                             String nowTime = df.format(new Date());
                             String org=metajson[j];
                             Gson gs = new GsonBuilder().disableHtmlEscaping().create();

                             ThriftInstanceMeta oldMj= gs.fromJson(org,ThriftInstanceMeta.class);
                             ThriftInstanceMeta newMj= gs.fromJson(org,ThriftInstanceMeta.class);
                             String oldPackageSource = oldMj.getPackageSource().toString();
                             String oldVersion = oldMj.getPackageVersion().toString();
                             newMj.setPackageSource("http://fakeadress/forturnaround");
                             newMj.setPackageVersion(nowTime);
                            // out.println(gs.toJson(newMj));
                             oldMj.setPackageSource(oldPackageSource);
                             oldMj.setPackageVersion(oldVersion);
                          //   out.println(gs.toJson(oldMj));





       //       String meta_power_str=metajson[j].replace(old_package,new_rand_version);

         //     ThriftInstanceMeta meta_power=testgson.fromJson(meta_power_str,ThriftInstanceMeta.class);
              ThriftInstanceMeta meta_power=newMj;

    //            String meta_power_over_str=metajson[j].toString().replace(new_rand_version,old_package);
      //        ThriftInstanceMeta meta_power_over=testgson.fromJson(meta_power_over_str,ThriftInstanceMeta.class);
              ThriftInstanceMeta meta_power_over=oldMj;





	String [] hosts_array = get_host.get_host_ip(host[j]).toString().split(" ");
	int hosts_num = hosts_array.length;
	for(int i=0;i<hosts_num;i++)
	{
		//out.flush(); 
		//out.println(i + ":" + hosts_array[i].replace(".",""));
		int offset=Integer.valueOf(hosts_array[i].replace(".","")).intValue();
		out.println("ip:" + hosts_array[i] + " operation:" + op + " offset: " + offset );
                out.println("<br>");
		try{
			if(op.equals("add"))
			{
	             	   clientop.matrix_add(user,token,serviceName,offset,hosts_array[i],metatest);
			}
			else if(op.equals("delete"))
			{
				clientop.matrix_delete(user,token,serviceName,offset);
			}
			else if(op.equals("update"))
			{

				clientop.matrix_update(user,token,serviceName,offset,metatest);
			}
			else if(op.equals("power_update"))
			{
			clientop.matrix_update(user,token,serviceName,offset,meta_power);
			//Thread.sleep(50000);
			clientop.matrix_update(user,token,serviceName,offset,meta_power_over);
			}

			else
			{
				clientop.matrix_reset(user,token,serviceName,offset,hosts_array[i],metatest);
			}
			out.println(op + " " + offset + " finished");
                        out.println("<br>");
			out.flush();
		}catch(TException e){
			StringWriter sw=new StringWriter();
			PrintWriter pw=new PrintWriter(sw);
			e.printStackTrace(pw);
			out.println(sw.toString());
                        out.println("<br>");
//                        
		}
	}
}
%>
<script language="javascript">var inProduct = 'False'; var userSku = 'pro';if(window.doStartup){doStartup()}</script>

</body></html>
