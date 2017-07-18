<%@ page
		import="com.sina.data.DataProducer.*"
		import="java.util.*"
		import="com.sina.data.bigmonitor.web.HbaseClient.*"
		import="java.text.SimpleDateFormat"

%>
<!DOCTYPE html>
<html lang="en" class=" js no-touch"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Tentacles</title>
	<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%
        String slaveHost = session.getAttribute("slave").toString();
        String [] mId = request.getParameterValues("metric");
        String begStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");


        SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1=simpleDateFormat.parse(begStr);
        Date date2=simpleDateFormat.parse(endStr);
        String begStamp = String.valueOf(date1.getTime()).substring(0,10);
        String endStamp = String.valueOf(date2.getTime()).substring(0,10);


        String [] args = new String[5];
        args[1] = slaveHost;
        args[2] = "0";
        args[3] = begStamp;
        args[4] = endStamp;
	    String suffix="";
	int end=Integer.valueOf(endStamp);
	int start=Integer.valueOf(begStamp);

	if(end-start<=3600)
	{
		suffix="HostOrig";
	}
	else if(end-start<=14400)
	{
		suffix="HostHour";
	}
	else
	{
		suffix="HostDay";
	}
	//String table_name="ns_hadoopadmin:BigMonitorMetricData"+suffix;
	String table_name="ns_hadoopadmin:BigMonitorMetricData"+suffix;
        //String table_name="ns_hadoopadmin:BigMonitorMetricDataHostOrig";
	args[0] = table_name;
	//String [] res = { GetData.get(), GetData.get() };
	String  title =  slaveHost;
	int len = mId.length;
	String [] hstr = new String[len];
	String [] divstr = new String[len];
	for(int i=0; i<len ;i++ ){
	    String yAtext = "";
            String [] mInfo = mId[i].split(":");
            args[2] = mInfo[0];
            String yLabels = "";
            String tooltip = "";
            if(mInfo[1].contains("mem") || mInfo[1].contains("swap")){
                yAtext  = "Mem(MB)";
                yLabels = ",labels: { formatter: function() { return Highcharts.numberFormat(this.value / 1024,2,'.'); } }";
                tooltip = "tooltip:{pointFormatter: function() { return 'value: <b>' + Highcharts.numberFormat(this.y/1024,1,'.') + 'MB</b>'}},";
            }else if(mInfo[1].contains("byte")){
                yAtext  = "Band(KB)";
                yLabels = ",labels: { formatter: function() { return Highcharts.numberFormat(this.value / 1024 ,2,'.'); } }";
                tooltip = "tooltip:{pointFormatter: function() { return 'value: <b>' + Highcharts.numberFormat(this.y/1024,1,'.') + 'KB</b>'}},";
            }else if(mInfo[1].contains("disk")){
                yAtext  = "Disk(GB)";
                yLabels = ",labels: { formatter: function() { return Highcharts.numberFormat(this.value ,2,'.'); } }";
                tooltip = "tooltip:{pointFormatter: function() { return 'value: <b>' + Highcharts.numberFormat(this.y,1,'.') + 'GB</b>'}},";
        }

	    hstr[i] = "$('#container"+i+"').highcharts({chart:{zoomType:'x'},title:{text:'" + title + " "  +mInfo[1] +"'}," +
	"subtitle:{text:document.ontouchstart===undefined?'" +
	"Clickanddragintheplotareatozoomin':'Pinchthecharttozoomin'},xAxis:{type:'datetime'}," +
	"yAxis:{title:{text:'"+ yAtext + " '}" + yLabels + "},legend:{enabled:false},plotOptions:{area:{fillColor:" +
	"{linearGradient:{x1:0,y1:0,x2:0,y2:1},stops:[[0,Highcharts.getOptions().colors[0]],[1," +
	"Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]]}," +
	"marker:{radius:2},lineWidth:1,states:{hover:{lineWidth:1}},threshold:null}}," + tooltip +
	"series:[{type:'area',name:'value',data:"+ getDataTest.get(args) +"}]});";
		divstr[i] = "<div id=\"container"+i+"\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"></div>";
	}

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
			$( function () {
				Highcharts.setOptions({
					global: {
						useUTC: false
					}
				});

				<%for(int i=0;i<len;i++) {
                    out.println(hstr[i]);
                }
                %>


			});





		</script>
	</head>
<body>
<script src="./Highcharts-4.2.6/js/highcharts.js"></script>
<script src="./Highcharts-4.2.6/modules/exporting.js"></script>

<%for(int i=0;i<len;i++) {
	out.println(divstr[i]);
}
%>

</body>
</html>
