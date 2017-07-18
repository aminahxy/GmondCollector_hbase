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
        %>
<%
        FileRead filetest=new FileRead();

        String[] modules=filetest.getFiles("/home/tentacles/tentacles-v1.0/webapp/conf_module").toString().split("\n");
        for (int i=0;i<modules.length;i++)
        {
        out.println(modules[i]);
        }

        String moduleName = request.getParameter("moduleName");
        if (moduleName == null) moduleName = modules[0];
        moduleName = moduleName.toUpperCase();

        String userClusterName = request.getParameter("userClusterName");
        if (userClusterName == null) userClusterName = modules[0];
        userClusterName = userClusterName.toUpperCase();

        %>

<B>Template:</B><select name="moduleName">
<%
        for (int i = 0; i < modules.length; i++) {
        if (moduleName.toLowerCase().equals(modules[i]))
        out.println("<option value=\"" + modules[i] + "\" selected>"
        + modules[i].toUpperCase() + "</option>");
        else
        out.println("<option value=\"" + modules[i] + "\">"
        + modules[i].toUpperCase() + "</option>");
        }
        %>
</select>

