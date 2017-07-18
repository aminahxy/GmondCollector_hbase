<%@ page
        contentType="text/html; charset=utf-8"
        import="java.text.SimpleDateFormat"
        import="java.util.*"
        import="javax.servlet.*"
%>

<%
        String[] clusters = {
                "nj01-nanling","szwg-ecomon","szwg-ston","szwg-stoff","szwg-kun",
                "nj01-yulong","nmg01-khan","nmg01-mulan","nmg01-taihang","nmg01-global",
                "szjjh-build","nj01-rp","yq01-wutai","yq01-heng","yq01-global","szwg-lu","idle"
        };
        String clusterName = request.getParameter("clusterName");
        if (clusterName == null) clusterName = clusters[0];
        clusterName = clusterName.toUpperCase();

        String userClusterName = request.getParameter("userClusterName");
        if (userClusterName == null) userClusterName = clusters[0];
        userClusterName = userClusterName.toUpperCase();

%>

<!DOCTYPE html>
<html lang="en" class=" js no-touch"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <title>Tentacles</title>
        <!-- Mobile specific metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <!-- Force IE9 to render in normal mode -->
        <!--[if IE]><meta http-equiv="x-ua-compatible" content="IE=9" /><![endif]-->
        <meta name="author" content="SuggeElson">
        <meta name="description" content="AppStart admin template - new premium responsive admin template. This template is designed to help you build the site administration without losing valuable time.Template contains all the important functions which must have one backend system.Build on great twitter boostrap framework">
        <meta name="keywords" content="admin, admin template, admin theme, responsive, responsive admin, responsive admin template, responsive theme, themeforest, 960 grid system, grid, grid theme, liquid, jquery, administration, administration template, administration theme, mobile, touch , responsive layout, boostrap, twitter boostrap">
        <meta name="application-name" content="AppStart admin template">
        <!-- Import google fonts - Heading first/ text second -->
        <link href="./Dashboard   AppStart - Admin Template_files/css" rel="stylesheet" type="text/css">
        <!-- Css files -->
        <!-- Icons -->
        <link href="bootstrap/css/icons.css" rel="stylesheet">
        <!-- Bootstrap stylesheets (included template modifications) -->
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
        <!-- jQueryUI -->
        <!-- Plugins stylesheets (all plugin custom css) -->
        <!-- Main stylesheets (template main css file) -->
        <link href="download/appstart/assets/css/main.css" rel="stylesheet">
        <!-- Custom stylesheets ( Put your own changes here ) -->
        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="resources/favico.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="resources/favico.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="resources/favico.png">
        <link rel="icon" href="resources/favico.png" type="image/png">
        <!-- Windows8 touch icon ( http://www.buildmypinnedsite.com/ )-->
        <meta name="msapplication-TileColor" content="#3399cc">
    <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style></head>
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

                            <li>
                               <form action="jobstatus.jsp"   method="POST" target="main_display">
                                    <B>Cluster:</B><select name="clusterName">
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
                                     <B>&nbsp;job id:</B><input size="25" style="width:222px;height:21px"  maxlength="50" name="jobId"  type="text" />



                                     <input id="sub_button" class="btn btn-primary " style="margin-right:1000px;height:25px;text-align:center; margin:0px; padding-top:2px; border:0px;" type="submit" value="go!" target="main_display"/>
                                </form>
                           </li>
                      </ul>
                      </nav>
                        

                        
                 </div> 
             </div>
         </div>     
        <iframe src="welcome.html"  id="iframepage" name="main_display" allowTransparency="false" width=100%   frameborder="0" marginheight=55px  scrolling=no  onLoad="iFrameHeight()"></iframe>


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
