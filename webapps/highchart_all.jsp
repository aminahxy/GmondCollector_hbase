<%@ page
		import="com.sina.data.DataProducer.*"
                import="com.sina.data.bigmonitor.web.HbaseClient.*"
%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html; charset=GB2312"%>

<%
       // String [] test = {"ns_hadoopadmin:BigMonitorMetricDataClusterHour", "hadoop-2.4.0-master", "100058", "1472115300", "1472122020"};
    String[] arr= request.getParameterValues("metric");
    String sb="";
    for(int i=0;i<arr.length;i++)
    {
        sb+=arr[i];
    }
    String[] brr=sb.split("#");
    /*for(String s:brr)
    {
        out.print(s);
        out.print("\n");
    }*/
     // String metric_namel = "yarn.ClusterMetrics.NumActiveNMs";
    String table_name = "ns_hadoopadmin:BigMonitorMetricDataClusterHour";
    int b_length=brr.length;
    String[] rowid=new String[b_length];
    String[][] test=new String[b_length][5];
    String clusterName=session.getAttribute("cluster").toString();
    String begStr = request.getParameter("startTime");
    String endStr = request.getParameter("endTime");
    SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date date1=simpleDateFormat.parse(begStr);
    Date date2=simpleDateFormat.parse(endStr);
    String begStemp = String.valueOf(date1.getTime()).substring(0,10);
    String endStemp = String.valueOf(date2.getTime()).substring(0,10);
      //test[0]="ns_hadoopadmin:BigMonitorMetricDataClusterHour";
 //   String[] res = new String[b_length];
     for(int i=0;i<b_length;i++) {
         rowid[i] = new HbaseClient().GetRowId(table_name,brr[i]);
         test[i][0] = "ns_hadoopadmin:BigMonitorMetricDataClusterOrig";
         test[i][1] = clusterName;
         //test[1]= "hadoop-2.4.0-master";
         test[i][2] = rowid[i];
         test[i][3] = begStemp;
         test[i][4] = endStemp;
   //      res[i] = getDataTest.get(test[i]);
     }
   // String res="";
    List<String> res=new ArrayList<String>();
    for(int i=0;i<b_length;i++)
    {
        String tmp=getDataTest.get(test[i]);
        res.add(tmp);
    }


   %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>

		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		<style type="text/css">
${demo.css}
		</style>
		<script type="text/javascript">
$( function () {
        Highcharts.setOptions({
            global: {
                useUTC: false 
            }
        });
       var len=<%=b_length%>
       var str='#container';
    //var dc=new Array(len);
    var dc = eval('${res}');
    for (var i=0;i<len;i++) {
        var c=str+i;
        $(c).highcharts({
            chart: {
                zoomType: 'x'
            },
            title: {
                text: 'metric'
            },
            subtitle: {
                text: document.ontouchstart === undefined ?
                        'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: 'Exchange rate'
                }
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0, Highcharts.getOptions().colors[0]],
                            [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                        ]
                    },
                    marker: {
                        radius: 2
                    },
                    lineWidth: 1,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    threshold: null
                }
            },

            series: [{
                type: 'area',
                name: 'USD to EUR',
                data: dc[i]
            }]
        });
    }

});
		</script>
	</head>
	<body>
<script src="./Highcharts-4.2.6/js/highcharts.js"></script>
<script src="./Highcharts-4.2.6/modules/exporting.js"></script>

<%
    for(int k=0;k<b_length;k++) {
        String  aaa="container"+String.valueOf(k);
%><div id="<%=aaa%>" style="min-width: 310px; height: 400px; margin: 0 auto"></div><%
    }
%>
<!--div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div-->

	</body>
</html>

