<%@ page
		contentType="text/html; charset=utf-8"
%>
<%@ page
		contentType="text/html; charset=utf-8"
		import="java.util.*"
		import="com.sina.data.bigmonitor.web.*"
		import="com.sina.data.bigmonitor.web.ClusterWithHost.*"
%>
<!DOCTYPE html>
<html lang="en" class=" js no-touch"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Tentacles</title>
	<!--[if IE]><meta http-equiv="x-ua-compatible" content="IE=9" /><![endif]-->
	<link href="download/appstart/assets/css/test.css" rel="stylesheet">
	<br>
	<br>
	<br>
<body class="">
<div id="preloader" style="display: none;">
	<div id="preloader-logo" style="display: none;">
		<img src="./Dashboard   AppStart - Admin Template_files/preloader-logo.png" alt="Logo">
	</div>
	<div id="preloader-icon" style="display: none;">
		<i class="im-spinner icon-spin"></i>
	</div>
</div>
<!-- Start #header -->
<div id="header" class="header-fixed">
	<div class="container-fluid">
		<div class="navbar">
			<div class="navbar-header">
				<!-- Show logo for large screens and laptops -->
				<a class="navbar-brand visible-lg visible-md" href="./main.jsp">
					<img src="resources/logo-min.png" alt="Jump start">
				</a>
			</div>
			<nav id="top-nav" class="navbar-no-collapse" role="navigation">
				<ul class="dropdown"   style="width:900px; margin:0 auto;top:15px;" >
					<div id="menu">
						<ul>
							<form action="slavetimer_info.jsp" method="POST" >
								<input id="sub_button" type="submit" value="监控查看" />
									<%
                        ClusterWithHost cwh=new ClusterWithHost();
                        List<ClusterHostBean> hosts= cwh.getClusterHostBeans();
                        //List<String> testhb=hosts.get(0).getHosts();
                        boolean checkedB = false;
                        for(ClusterHostBean hblist:hosts){
                            for(String hb:hblist.getHosts()){
                                if(checkedB){
                                    %><div><input type="radio" name="slaveHost" value="<%=hb%>">[<%=hb%>]</div><%
                                }else{
                                    %><div><input type="radio" name="slaveHost" checked=checked value="<%=hb%>">[<%=hb%>]</div><%
                                    checkedB = true;
                                }
                            }
                        }
                %>
					</div>
					</form>

					</li>
				</ul>
			</nav>



		</div>
	</div>
</div>
<iframe src="welcome_info.html"  id="iframepage" name="main_display" allowTransparency="false" width=100%   frameborder="0" marginheight=55px  scrolling=no  onLoad="iFrameHeight()"></iframe>


</body>
</html>

<script type="text/javascript" language="javascript">
	function iFrameHeight() {
		var ifm= document.getElementById("iframepage");
		var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;
		if(ifm != null && subWeb != null) {
			ifm.height = subWeb.body.scrollHeight;
		}
	}
</script>