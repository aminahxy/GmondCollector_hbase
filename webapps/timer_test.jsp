<%@ page
	contentType="text/html; charset=utf-8"
	import="java.text.SimpleDateFormat"
	import="java.util.*"
%>
<%@ page
		 import="com.sina.data.bigmonitor.web.AllMetrics"
		 import="com.sina.data.bigmonitor.web.metricInfo"
%>
<%@ page import="java.io.IOException" %>
<%@ page import="com.sina.data.bigmonitor.web.MetricName" %>


<%
	SimpleDateFormat dateFormat = 
		new SimpleDateFormat("yyyy-MM-dd" + " " + "HH:mm:ss");
	Date reqTime = new Date();
	String endStr = request.getParameter("endTime");
	String clusterName = request.getParameter("clusterName");
	String begStr = request.getParameter("startTime");
	session.setAttribute("cluster", clusterName);
	if (endStr == null || endStr.equals("")) {
		endStr = dateFormat.format(reqTime);
	}
	if (begStr == null || begStr.equals("")) {
		begStr = dateFormat.format(
				new Date(reqTime.getTime() - 3600 * 1000));
	}
%>
<html>
<script language="javascript" type="text/javascript" src="js/Main.js"></script>
<script language="javascript" type="text/javascript" src="js/WebCalendar.js"></script>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="resources/HomePageStyle.css" rel="stylesheet" media="screen" type="text/css" charset="utf-8"></link>
</head>

<body>

<div id="menu">
<ul>
	<li>
		<form action="highchart_test.jsp" method="POST" >
			<label id="deltaTimeLabel" for="deltaTime"><B>Last: </B></label>
			<select name="deltaTime" id="deltaTime" onchange="time_refresh()" >
				<option value="10" >10 min</option>
				<option value="30" >30 min</option>
				<option value="60" SELECTED>hour</option>
				<option value="120" >2 hour</option>
				<option value="180" >3 hour</option>
				<option value="360" >6 hour</option>
				<option value="1440" >day</option>
				<option value="2880" >2 day</option>
				<option value="4320" >3 day</option>
				<option value="10080" >week</option>
			</select>
			
			<label id="startTimeLabel" for="startTime"><B>From: </B></label>
			<input name="startTime" id="startTime" type="text" class="form_css" 
				value="<% out.print(begStr); %>"
				onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',0,0)" 
				onchange="time_check()" />
			
			<label id="endTimeLabel" for="endTime"><B>To: </B></label>
			<input name="endTime" id="endTime" type="text" class="form_css" 
				value="<% out.print(endStr); %>"
				onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',0,0)" 
				onchange="time_check()" />

			<!--label id="endTimeLabel" for="endTime"><B>To: </B></label-->


	</li>
			<style type="text/css">
				.ct{
					text-align:center;
				}
			</style>
			<script type="text/javascript">
				function allCheck(){
					var obj=document.getElementsByTagName("input");
					if(document.getElementById("all").checked==true){
						for(var i=0;i<obj.length;i++){
							obj[i].checked=true;
						}
					}else{
						for(var i=0;i<obj.length;i++){
							obj[i].checked=false;
						}
					}
				}
				function checkT_F(){
					var obj=document.getElementsByTagName("input");
					var j=0;
					for(var i=0;i<obj.length;i++){
						if(obj[i].id!='all'){
							if(obj[i].checked==true){
								j++;
							}
						}
					}
					if(j==(obj.length-1)){
						document.getElementById("all").checked=true;
					}else{
						document.getElementById("all").checked=false;
					}
				}
			</script>
			</head>
	<body>
	<div>
		<div class="zuo">
			<div><input type="checkbox" id="all"  onclick="javascript:allCheck()"/>all</div>
		</div>
		<%

			String[] a=new String[10];

			for (int j=0;j<10;j++)
			{
				a[j]=String.valueOf(j)+"#";
			}
			for(int i=0;i<10;i++) {
		%><div><input type="checkbox" name="metric" value="<%=a[i]%>">[<%=a[i].substring(0,a[i].length()-1)%>]</div><%
		}
	%>
	</div>
	<!--div><input type="checkbox" name="p" value="hahaha">miaomiaomiao</div-->

	<input id="sub_button" type="submit" value="监控查看" />
	</form>


</ul>

</div>
</body>
</html>
