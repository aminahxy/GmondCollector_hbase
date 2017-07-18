<%@ page
import ="java.io.BufferedReader"
import ="java.io.FileReader"
import ="java.io.UnsupportedEncodingException"
import="java.nio.Buffer"
import="java.text.DecimalFormat"
import="tentacles.util.EasyWebGet"
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
        Map<String, String> conf_res =new HashMap<String, String>();
        JSONArray testjson=new JSONArray();
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
        String[] phy = new String[a.length];
        for (int k = 0; k < a.length; k++) {

        phy[k] = a[k].split(".conf")[0].split("scheduler_")[1];
        }
        String[] conf_value=new String[a.length];

        for (int j = 0; j < a.length; j++) {
        HttpGet httpget = new HttpGet("http://" + clusterName + "-normandy.dmop.baidu.com:8033/filetree?action=cat&path=/" + a[j]);
        try {
        HttpResponse response_sch =httpclient.execute(httpget);

        //BufferedReader br = new BufferedReader(
        //new InputStreamReader(response_sch.getEntity().getContent()));

        HttpEntity rspEntity_sch = response_sch.getEntity();
        if (rspEntity_sch != null) {
        scheduler_url = EntityUtils.toString(rspEntity_sch);
        }
        //br.close();
        }
        catch (IOException e) {
        e.printStackTrace();
        }
        StringBuffer scheduler_value=new StringBuffer();

        String[] regex_value = {"MatrixRpcServer:.*","DependServerUser:.*","DependServerToken:.*","DependServerName:.*","ScheTag.*" };
        String input_schedule = scheduler_url;
        Pattern[] p_value = {Pattern.compile(regex_value[0]), Pattern.compile(regex_value[1]), Pattern.compile(regex_value[2]), Pattern.compile(regex_value[3]), Pattern.compile(regex_value[4])};
        Matcher[] m_value = {p_value[0].matcher(input_schedule), p_value[1].matcher(input_schedule), p_value[2].matcher(input_schedule), p_value[3].matcher(input_schedule), p_value[4].matcher(input_schedule)};
        while (m_value[0].find()) {
        scheduler_value.append(scheduler_url.substring(m_value[0].start(), m_value[0].end()).split(":")[1] + ":");
        scheduler_value.append(scheduler_url.substring(m_value[0].start(), m_value[0].end()).split(":")[2] + ":");
        }
        for (int i = 1; i < regex_value.length; i++) {
        while (m_value[i].find()) {
        scheduler_value.append(scheduler_url.substring(m_value[i].start(), m_value[i].end()).split(":")[1] +":");
        }
        }
        conf_value[j]=scheduler_value.toString().replace(" ","");conf_value[j]=conf_value[j].substring(0,conf_value[j].length()-1);
        //out.println(conf_value[j]);
}
        JSONArray testa=JSONArray.fromObject(conf_value);
        out.println(testa);
             %>
        <script language="javascript">var inProduct = 'False'; var userSku = 'pro';if(window.doStartup){doStartup()}</script>

        </body></html>


