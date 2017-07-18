<%@ page
	import="com.sina.data.DataProducer.*"
        import="java.util.*"
        import="com.sina.data.bigmonitor.web.HbaseClient.*"
        import="java.text.SimpleDateFormat"

%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        String metricNameId=session.getAttribute("Metrics").toString();
       
        String [] hosts = request.getParameterValues("hosts");
        String begStr = request.getParameter("startTime");        String endStr = request.getParameter("endTime");

        SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1=simpleDateFormat.parse(begStr);
        Date date2=simpleDateFormat.parse(endStr);
        String begStamp = String.valueOf(date1.getTime()).substring(0,10);
        String endStamp = String.valueOf(date2.getTime()).substring(0,10);

        String table_name = "ns_hadoopadmin:BigMonitorMetricDataHostOrig";
        String metricId = metricNameId.split(":")[0];
        String metricName = metricNameId.split(":")[1];

	//String [] res = { GetData.get(), GetData.get() };
	String  title =  metricName;
	String yAtext = "metricValue";
        //String res = new CompareMultiHostMetric().GetMultiHostMetric(hosts,"100018", "1472655362");
        String res = new CompareMultiHostMetric().GetMultiHostMetric(hosts, metricId, endStamp);
        
        

%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>

		<script type="text/javascript" src="js/jquery-1.8.2.js"></script>
		<style type="text/css">
${demo.css}
		</style>
		<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '<%=title%>',
        },
        subtitle: {
            text: 'Source: <a href="http://en.wikipedia.org/wiki/List_of_cities_proper_by_population">Wikipedia</a>'
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: -45,
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: '<%=yAtext%>'
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: 'Population in 2008: <b>{point.y:.1f} millions</b>'
        },
        series: [{
            name: 'Population',
            data: <%=res%>,
            dataLabels: {
                enabled: true,
                rotation: -90,
                color: '#FFFFFF',
                align: 'right',
                format: '{point.y:.1f}', // one decimal
                y: 10, // 10 pixels down from the top
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        }]
    });
});
		</script>
	</head>
	<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<div id="container" style="min-width: 300px; height: 400px; margin: 0 auto"></div>

	</body>
</html>









		</script>
	</head>
	<body>
<script src="./Highcharts-4.2.6/js/highcharts.js"></script>
<script src="./Highcharts-4.2.6/modules/exporting.js"></script>

<div id="container" style="min-width: 300px; height: 400px; margin: 0 auto"></div>
	</body>
</html>

