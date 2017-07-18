<%@ page
        contentType="text/html; charset=utf-8"
        import="java.text.SimpleDateFormat"
        import="java.util.*"
        import="javax.servlet.*"
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

<%
        String[] clusters = {
                "nj01-nanling","szwg-ecomon","szwg-ston","szwg-stoff","szwg-kun",
                "nj01-yulong","nmg01-khan","nmg01-mulan","nmg01-taihang","nmg01-global",
                "szjjh-dbuild","nj01-rp","nj02-mix","yq01-wutai","yq01-heng","yq01-global","idle","szwg-log"
        };
        String[] operation = {
                "showAll","showAllMissing","showAllCorrupt","showMissingMachineList"
        };
        String clusterName = request.getParameter("clusterName");
        if (clusterName == null) clusterName = clusters[0];
        clusterName = clusterName.toUpperCase();

        String userClusterName = request.getParameter("userClusterName");
        if (userClusterName == null) userClusterName = clusters[0];
        userClusterName = userClusterName.toUpperCase();

%>
<%
%>

<!DOCTYPE html>
<html>
<head>
<script>
function myFunction()
{
document.getElementById("demo").innerHTML="My First JavaScript Function";
}

function selChange(obj){
    //document.write(obj.value);
    //document.getElementById("tr1").style.display = "block";
    //document.getElementById("dst1").value = obj.value;
    var str=httpGet("http://tentacles.dmop.baidu.com:8010/3.jsp?cluster=szwg-ston");

    document.getElementById("dst1").value = str;


}
function httpGet(theUrl)
{
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            return xmlhttp.responseText;
        }
    }
    xmlhttp.open("GET", theUrl, false );
    xmlhttp.send();    
}
</script>
</head>

<body>

<h1>My Web Page</h1>

<p id="demo">A Paragraph.</p>

<button type="button" onclick="myFunction()">click here</button>

 <form action="seek_block.jsp"   method="POST" target="main_display">
                                    <B>Cluster:</B><select name="clusterName" onchange="selChange(this);">
                                    <%
                                        for (int i = 0; i < clusters.length; i++) {
                                            if (clusterName.toLowerCase().equals(clusters[i]))
                                                    out.println("<option value=\"" + clusters[i] + "\" selected>"
                                                                + clusters[i].toUpperCase() + "</option>");
                                            else
                                                    out.println("<option value=\"" + clusters[i] + "\">"
                                                                + clusters[i].toUpperCase() + "</option>");
                                        }
                                    %>
                                     </select>
                                     <input id="dst1" value="test"/>
                                     <B>&nbsp;operation:</B><select  name="operation"  >
                                     <%
                                        for (int i = 0; i < operation.length; i++) {
                                                out.println("<option value=\"" + operation[i] +  "\">"
                                                             + operation[i] + "</option>");
                                        }
                                     %>
                                     </select>



                                     <input id="sub_button" class="btn btn-primary " style="margin-right:1000px;height:25px;text-align:center; margin:0px; padding-top:
2px; border:0px;" type="submit" value="go!" target="main_display"/>
                                </form>

</body>
</html>
