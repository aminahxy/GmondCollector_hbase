<%@ page
import="com.baidu.inf.matrix.master.rpc.common.ThriftUGI"
        import="com.baidu.inf.matrix.master.rpc.masterclientproto.*"
        import="com.baidu.inf.matrix.resourcemanager.rpc.thrift.proto.client.ResourceManagerException"
        import="com.google.gson.ExclusionStrategy"
        import="com.google.gson.FieldAttributes"
        import="com.google.gson.Gson"
        import="com.google.gson.GsonBuilder"
        import="org.apache.thrift.TException"
        import="org.apache.thrift.protocol.TBinaryProtocol"
        import="org.apache.thrift.protocol.TProtocol"
        import="org.apache.thrift.transport.TFramedTransport"
        import="org.apache.thrift.transport.TSocket"
        import="org.apache.thrift.transport.TTransport"
        import="java.io.IOException"
        import="java.util.ArrayList"
        import="java.util.List"
        import="org.apache.thrift.transport.TTransportException"
        import="tentacles.matrix_util.GetInstanceMetaInService"
        import="tentacles.matrix_util.GetMultiMetaInstance"
        import="tentacles.util.Get_Conf_Concurrent"
        import="tentacles.util.*"
            import="java.io.PrintWriter"
        import="java.io.StringWriter"
        %>
<%
        out.println("<Br>");
        out.println("<Br>");
        out.println("<Br>");
        Object cluster_obj=session.getAttribute("cluster");
        Object out_obj=session.getAttribute("out_phy");
        String cluster=cluster_obj.toString();
        String out_phy=out_obj.toString();
        List<String> test_tag=new ArrayList<String>();
        String host = request.getParameter("borrow");
        get_single_phy testnode=new get_single_phy();
        matrix_adminop clientop=new matrix_adminop();
        String []phy_out=new String[1];
        phy_out[0]=out_phy;

        List testhui= testnode.get_phy_single(cluster, phy_out);
        String matrix_service=testhui.toString().split(":")[0].substring(1, testhui.toString().split(":")[0].length());
        String user=testhui.toString().split(":")[2];
        String token=testhui.toString().split(":")[3];
        String serviceName=testhui.toString().split(":")[4];
        String tags=testhui.toString().split(":")[5].substring(0, testhui.toString().split(":")[5].length()-1);
        out.println(tags);
        test_tag.add(tags);
        try{
        clientop.matrix_admin_open(matrix_service);
        }
        catch ( TTransportException e)
        {
//        e.printStackTrace();
        StringWriter sw=new StringWriter();
        PrintWriter pw=new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println(sw.toString());
        }
       
        //out.println(host.split("\n").length);
         for(int i=0;i<host.split("\n").length;i++)
        {
        //System.out.println(host.split(" ")[i]);
        String host1=host.split("\n")[i].trim();
        out.println(host1);
        //out.println(host1.length());
       out.println("hahah");
        try{
        clientop.matrix_updatetag(user,token,host1,test_tag);
        }catch(org.apache.thrift.TException e)
        {
        StringWriter sw=new StringWriter();
        PrintWriter pw=new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println(sw.toString());
        }
        } 
%>

