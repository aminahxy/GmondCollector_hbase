<%@ page
import ="java.io.BufferedReader"
import ="java.io.FileReader"
import ="java.io.UnsupportedEncodingException"
import="java.nio.Buffer"
import="java.text.DecimalFormat"
import="tentacles.util.EasyWebGet"
import="tentacles.util.*"
import="java.io.IOException"
import="java.util.HashMap"
import="java.util.Map"
import="java.util.logging.FileHandler"
import="java.util.regex.*"
import="org.apache.http.HttpEntity"
import="org.apache.http.HttpResponse"
import="org.apache.http.client.HttpClient"
import="org.apache.http.client.methods.HttpGet"
import="org.apache.http.impl.client.DefaultHttpClient"
import="org.apache.http.util.EntityUtils"
import="org.apache.http.client.ClientProtocolException"
import="net.sf.json.JSONArray"
import="java.util.concurrent.ExecutorService"
import="java.util.concurrent.Executors"
import="java.util.List"
import="java.util.ArrayList"
import="java.util.concurrent.Future"
import="java.util.concurrent.Callable"
import="java.util.concurrent.ExecutionException"
%>

<html ><head id="Head1"><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!--link href="./pop_style1_files/intuit-BaseMaster-styles" rel="stylesheet">
    <script type="text/javascript" async="" src="./pop_style1_files/ga.js"></script><script src="./pop_style1_files/intuit-BaseMaster-scripts"></script>
    <style>.mboxDefault { hidden:visibility; }</style>

    <script language="javascript" src="./pop_style1_files/qb_win_help.js" type="text/javascript"></script--!>
</head>
<body>
<div id="help_header">

<%
        String clusterName = request.getParameter("cluster");
        HttpClient httpclient = new DefaultHttpClient();
        String history_url = null;
        String scheduler_url = null;
       List<Future> list = new ArrayList<Future>();
        List<String> list_result = new ArrayList<String>();
        Map<String, String> conf_res =new HashMap<String, String>();
        JSONArray testjson=new JSONArray();
        ExecutorService exec=Executors.newCachedThreadPool();
         HttpGet history = new HttpGet("http://" + clusterName + "-normandy.dmop.baidu.com:8033/filetree?action=cat&path=/normandy_scheduler.conf");

        try {
        HttpResponse response_history =httpclient.execute(history);
        HttpEntity rspEntity_history = response_history.getEntity();

        if (rspEntity_history != null) {
        history_url = EntityUtils.toString(rspEntity_history);
        }
        } catch (IOException e) {
        e.printStackTrace();
        }
        String regex = "schedule.*.";
        String input = history_url;
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(input);
        StringBuffer scheduler = new StringBuffer();
        while (m.find()) {
        scheduler.append(history_url.substring(m.start(), m.end()) + "\n");
        }
        String[] a = scheduler.toString().split("\n");
     ExecutorService pool = Executors.newFixedThreadPool(a.length);   
                String[] conf_value=new String[a.length];
                String[] regex_value = {"MatrixRpcServer:.*","DependServerUser:.*","DependServerToken:.*","DependServerName:.*","ScheTag.*" };
                Pattern[] p_value = {Pattern.compile(regex_value[0]), Pattern.compile(regex_value[1]), Pattern.compile(regex_value[2]), Pattern.compile(regex_value[3]), Pattern.compile(regex_value[4])};

                for (int j = 0; j < a.length; j++) {
                String input_schedule=null;
                  Callable c = new MyCallable(clusterName,a,j,p_value,regex_value,conf_value);
                  Future f = pool.submit(c);
                  list.add(f);
                 }
                 pool.shutdown();
        for (Future f : list) {
            try{  
                         for(int i=0;i<f.get().toString().split(",").length;i++)
                           {
                               System.out.println("hahaaha" +i);
           //                   System.out.println(f.get().toString().split(",")[i]);
                               list_result.add(f.get().toString().split(",")[i]);
                               System.out.println(list_result);
                           }
             
           }catch (ExecutionException e){
                 e.printStackTrace(); }
             catch (InterruptedException ee){
               ee.printStackTrace(); }
              }

                JSONArray testa=JSONArray.fromObject(list_result);
                out.println(testa);
             %>
        <script language="javascript">var inProduct = 'False'; var userSku = 'pro';if(window.doStartup){doStartup()}</script>

        </body></html>


