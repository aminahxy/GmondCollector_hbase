<%@ page
import ="java.io.BufferedReader"
        import ="java.io.FileReader"
        import ="java.io.UnsupportedEncodingException"
        import="java.nio.Buffer"
        import="java.text.DecimalFormat"
        import="tentacles.util.EasyWebGet"
        import="tentacles.util.host_ip"
        import="tentacles.util.get_host"
        import="tentacles.*"
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
        %>
<html ><head id="Head1"><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="matrix_op">
<%

        String [] clusters = {"nj01-jiuying", "yq01-baize", "nmg01-luwu", "gzns-lizhu", "cq02-baihua"};
        List<String> clusterList = new ArrayList<String>() ;
        String host= request.getParameter("host");
        String ms= request.getParameter("ms");
        for( String cluster : clusters ){
        clusterList.add(cluster);
        }

        System.out.println("123");
        HandOverHostDeployer hod = new HandOverHostDeployer();
        /*List<String> resList = hod.GetAllMatrixNodes(clusterList);
        for( String node : resList ){
            System.out.println(node);
        }*/
        String res = hod.MatrixServerToNode(ms, clusterList);

        if( res != null ) {
        System.out.println(res);
        }else{
        System.out.println("nores");
        }

        List node=new ArrayList();
        node.add(res);
        matrix_add test=new matrix_add();
        test.matrix_add_host(node, host);
        JSONArray input_test=test.matrix_add_host(node, host);
        out.print(input_test);

%>
