<%@ page
        contentType="text/html; charset=utf-8"
        import="java.text.SimpleDateFormat"
        import="java.util.*"
        import="javax.servlet.*"
        import="java.io.*"

        import="org.json.JSONException"
        import="org.json.JSONObject"
        import="org.json.JSONArray"
        import="java.io.BufferedReader"
        import="java.io.InputStream"
        import="java.io.InputStreamReader"
        import="java.io.IOException"
       

        
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
        <meta name="description" content="AppStart admin template - new premium responsive admin template. This template is designed to help you build the site admin
istration without losing valuable time.Template contains all the important functions which must have one backend system.Build on great twitter boostrap framework">
        <meta name="keywords" content="admin, admin template, admin theme, responsive, responsive admin, responsive admin template, responsive theme, themeforest, 96
0 grid system, grid, grid theme, liquid, jquery, administration, administration template, administration theme, mobile, touch , responsive layout, boostrap, twitter 
boostrap">
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
    <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0
.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startCo
lorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index:
 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style></head>
 <body class="">
        <div id="preloader" style="display: none;">
            <div id="preloader-logo" style="display: none;">
                <img src="./Dashboard   AppStart - Admin Template_files/preloader-logo.png" alt="Logo">
            </div>
            <div id="preloader-icon" style="display: none;">
                <i class="im-spinner icon-spin"></i>
            </div>
        </div>

<div id="Content" class="sidebar">
<%
        out.println("<Br>");
        out.println("<Br>");
        out.println("<Br>");
        String clusterName = request.getParameter("cluster");
        out.println("Cluster name : " + clusterName + "<Br>");
        

        Runtime rt = null;
        StringBuffer buffer = new StringBuffer();
        InputStream in = null;
        //String [] command =  {"sh", "/home/tentacles/findblock/findblockOne.sh ", clusterName,  blockId, " 2>&1"};
        //String [] command =  {"sh", "/home/tentacles/queueshow/genJs.sh", clusterName};
        //String command =  "sh /home/tentacles/queueshow/genJs.sh " ;
        String command =  "sh /home/tentacles/queueshow/hk-dlb/genJs.sh ";
        //String [] command =  {"echo", "test"};
        Process proc = null;
        BufferedReader reader = null;
        rt = Runtime.getRuntime();
        int count = 0;
        try {
                        in = rt.exec(command).getInputStream();
                        reader = new BufferedReader(new InputStreamReader(in));
                        String str = null;
                        count = 0;
                        while ((str = reader.readLine()) != null) {
                                count++;
                                //out.println(str);
                                buffer.append(str +  "\n");
                        }
                        //out.println(count);
                        if(count == 0){
                                out.println("first !! ");
                                return;
                        }

                } catch (Throwable e) {
                        e.printStackTrace();
                        out.println("second !! ");
                        return;
                } finally {
                        try {
                                if (reader != null) reader.close();
                                if (in != null) in.close();
                        } catch (IOException e) {
                                e.printStackTrace();
                        }
                }
        

out.println(buffer.toString());


%>
</div>
</body>
