<%@ page
import="com.baidu.inf.matrix.master.rpc.masterclientproto.ThriftInstanceMeta"
        import="com.google.gson.Gson"
        import="org.apache.thrift.TException"
        import="tentacles.matrix_util.GetInstanceMetaInService"
        import="org.apache.thrift.transport.TTransportException"
        import="tentacles.matrix_util.GetMultiMetaInstance"
        import="tentacles.util.Get_Conf_Concurrent"
        import="tentacles.util.*"
        import="tentacles.http_tools.*"
        import="java.io.PrintWriter"
        import="java.io.StringWriter"
        import="java.util.HashMap"
        import="java.util.List"
        import="java.util.Map"
        %>
<%
        String old="thread\":{\"quota\":0,\"limit\":0}";
        String old_change="thread\":{\"quota\":0,\"limit\":-1}";
        String clustername=request.getParameter("cluster");
        String normandyTag=request.getParameter("phy");
        String host=request.getParameter("host");
        String []phy=new String[1];
        phy[0]=normandyTag;
        get_single_phy testnode=new get_single_phy();
        GetMatrixNodeByClusterTag testss=new GetMatrixNodeByClusterTag();
        Object metajson=testss.GetMatrixNode(clustername,normandyTag);

        String metajson_change=metajson.toString().replace(old,old_change);
        //out.println(metajson);
        Gson testgson=new Gson();
        ThriftInstanceMeta metatest=testgson.fromJson(metajson_change, ThriftInstanceMeta.class);
        matrix_clientop clientop=new matrix_clientop();
        get_host get_host=new get_host();
        get_single_phy single_phy=new get_single_phy();
        List node=single_phy.get_phy_single(clustername,phy);
        int[] offset=new int[get_host.get_host_ip(host).toString().split(" ").length];
        String matrix_service=node.toString().split(":")[0].substring(1,node.toString().split(":")[0].length());
        String user=node.toString().split(":")[2];
        String token=node.toString().split(":")[3];
        String serviceName=node.toString().split(":")[4];
        try {
        clientop.matrix_client_open(matrix_service);
        }
        catch ( TTransportException e)
        {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println(sw.toString());
        }
        for (int i=0;i<get_host.get_host_ip(host).toString().split(" ").length;i++) {
        offset[i] = Integer.valueOf(get_host.get_host_ip(host).toString().replace(".", "").split(" ")[i]).intValue();
        try{
        clientop.matrix_update(user,token,serviceName,offset[i],metatest);
        //out.println("update"+offset[i]+"success");
        out.println("update" +get_host.get_host_ip(host).toString().split(" ")[i]  + "success");
        }catch (TException e){
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println(sw.toString());
        }
        }

        %>
