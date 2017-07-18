<%@ page
        import="com.sina.data.DataProducer.*"
        import="java.util.*"
        import="com.sina.data.bigmonitor.web.HbaseClient.*"
        import="java.text.SimpleDateFormat"

%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String metricNameId=request.getParameter("metric");
    String[] hosts = (String[]) session.getAttribute("slave");
    String begStr = request.getParameter("startTime");
    String endStr = request.getParameter("endTime");



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
    String yAtext = "";
    String yLabels = "";
    String pointFormat = "pointFormat: 'value is: <b>{point.y:.1f} </b>'";
    String dataLabFormat = "format: '{point.y:.1f}',";
    if(metricName.contains("mem") || metricName.contains("swap")){
        yAtext  = "Mem(MB)";
        yLabels = ",labels: { formatter: function() { return Highcharts.numberFormat(this.value / 1024,2,'.'); } }";
        pointFormat = "pointFormatter: function() { return 'value is: <b>' + Highcharts.numberFormat(this.y/1024,1,'.') + 'MB</b>'}";
        dataLabFormat = "formatter: function(){return Highcharts.numberFormat(this.y/1024,1,'.')+'MB'},";
    }else if(metricName.contains("byte")){
        yAtext  = "Band(KB)";
        yLabels = ",labels: { formatter: function() { return Highcharts.numberFormat(this.value / 1024 ,2,'.'); } }";
        pointFormat = "pointFormatter: function() { return 'value is: <b>' + Highcharts.numberFormat(this.y/1024,1,'.') + 'KB</b>'}";
        dataLabFormat = "formatter: function(){return Highcharts.numberFormat(this.y/1024 ,1,'.')+'KB'},";
    }else if(metricName.contains("disk")){
        yAtext  = "Disk(GB)";
        yLabels = ",labels: { formatter: function() { return Highcharts.numberFormat(this.value ,2,'.'); } }";
        pointFormat = "pointFormatter: function() { return 'value is: <b>' + Highcharts.numberFormat(this.y,1,'.') + 'GB</b>'}";
        dataLabFormat = "formatter: function(){return Highcharts.numberFormat(this.y,1,'.')+'GB'},";
    }
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
                    }<%=yLabels%>
                },
                legend: {
                    enabled: false
                },
                tooltip: {
                    <%=pointFormat%>
                },
                series: [{
                    name: 'Population',
                    data: <%=res%>,
                    dataLabels: {
                        enabled: true,
                        rotation: -90,
                        color: '#FFFFFF',
                        align: 'right',
                        <%=dataLabFormat%>
                        y: 10, // 10 pixels down from the top
                        style: {
                            fontSize: '7px',
                            fontFamily: 'Verdana, sans-serif'
                        }
                    }
                }]
            });
        });
    </script>
</head>
<body>

<script src="./Highcharts-4.2.6/js/highcharts.js"></script>
<script src="./Highcharts-4.2.6/modules/exporting.js"></script>


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