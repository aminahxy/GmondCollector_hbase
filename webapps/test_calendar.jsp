<%@ page
	contentType="text/html; charset=utf-8"
	import="java.text.SimpleDateFormat"
	import="java.util.*"
%>
<%
	SimpleDateFormat dateFormat = 
		new SimpleDateFormat("yyyy-MM-dd" + " " + "HH:mm:ss");
	Date reqTime = new Date();
	String begStr = request.getParameter("startTime");
	String endStr = request.getParameter("endTime");
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
		</form>
	</li>

</ul>

</div>
</body>
</html>
