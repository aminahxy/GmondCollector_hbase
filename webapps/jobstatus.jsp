<%@ page
        contentType="text/html; charset=utf-8"
        import="java.text.SimpleDateFormat"
        import="java.util.*"
        import="javax.servlet.*"
        import="tentacles.http.test"
        import="java.util.LinkedHashMap"
        import="java.util.Map"
        import="tentacles.grab.tentacles_job"
        import="tentacles.grab.analyze"
        import="com.baidu.inf.ark.client.ClientException"

        
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

<div id="Content" class="sidebar">
<%
        out.println("<Br>");
        out.println("<Br>");
        out.println("<Br>");
        String clusterName = request.getParameter("clusterName");
        String jobId = request.getParameter("jobId");
        out.println("Cluster name : " + clusterName + "<Br>");
        
        out.println("job id : " + jobId + "<Br>");
        //new tentacles_job().main(new String[] {jobId});
        //test testa = new test();
        //String aaa = testa.main(new String [] {"a"});
        //out.println(aaa);
        //out.println("begin======================");
        Map<String,String> job_info_map = new LinkedHashMap<String, String>();
                try {
                    job_info_map = tentacles_job.get_job_info(new String[]{clusterName,jobId});
                } catch (ClientException e) {
                    e.printStackTrace();
                }
           //     for (Map.Entry<String, String> entry : job_info_map.entrySet()) {
           //         out.println(entry.getKey() + ": " + entry.getValue());
           //         out.println("<Br>");
           //     }
        if ( (job_info_map.get("job start time") != null) && ( ! job_info_map.containsKey("Error")) ){
            analyze analyze_client = new analyze();
            Map<String,String> abnormal_result = new HashMap<String, String>();
            Map<String,String> job_analyzed_result;
                            //job_analyzed_result = new analyze().analyze(job_info_map);
                            job_analyzed_result = analyze_client.analyze(job_info_map);
            String job_status = "NORMAL";
            if ( job_analyzed_result.get("JOB_ABNORMAL").equals("true")){
                job_status="ABNORMAL";
            }
              
            String fontColor = "black";
 
            out.println("<Br>");
                                //out.println("test  !!! JOB_ABNORMAL " + job_analyzed_result.get("JOB_ABNORMAL") + "<br>");
            

            out.println("<font size=4 face=Verdana>作业状态 : " + job_status + "</font><br>");

                            for (Map.Entry<String, String> entry : job_analyzed_result.entrySet()) {
                                fontColor = "black";
                                if( !entry.getKey().equals("JOB_ABNORMAL")){
                                    if(entry.getValue().split(";")[1].contains("ABNORMAL")){
                                        fontColor = "red";
                                        abnormal_result.put(entry.getValue().split(";")[0], "");
                                    }
                                    
                                    out.println("<font color=" + fontColor + " >" + entry.getKey() + ": " 
                                                     + entry.getValue().split(";")[0] + "</font>");
                                    out.println("<Br>");
                                }
                            }
                            Map<String, String> adviceResult = analyze_client.giveAdvice(abnormal_result);
                            if( ! adviceResult.isEmpty() ) {
                                out.println("<Br>");
                                out.println("<Br>");
                                out.println("=====================================================");
                                out.println("<Br>");
                                out.println("<font size=4 face=Verdana>问题优化建议 : </font>");
                                out.println("<Br>");
                                out.println("=====================================================");
                                out.println("<Br>");
                                for (Map.Entry<String, String> entry : adviceResult.entrySet()) {
                                   for( String line:entry.getValue().split("\n")){
                                      out.println("<font color=blue>" + line + "</font>");
                                      out.println("<Br>");
                                   }
                                }
                                out.println("<Br>");
                                out.println("作业详细信息见下方：");
                            }
                          
                            out.println("<Br>");
                            out.println("<Br>");
                            out.println("=====================================================");
                            out.println("<Br>");
                            out.println("<font size=4 face=Verdana>作业详细信息 : </font>");
                            out.println("<Br>");
                            out.println("=====================================================");
                            out.println("<Br>");
   

                            for (Map.Entry<String, String> entry : job_info_map.entrySet()) {
                                fontColor = "black";
                                String jobInfoItem = entry.getKey().split(":")[0];

                                if ( job_analyzed_result.get(jobInfoItem) != null &&
                                    job_analyzed_result.get(jobInfoItem).split(";")[1].contains("ABNORMAL")){

                                    fontColor = "red";
                                }
                                if ( entry.getValue().split(";").length > 1 ){
                                    out.println("<font color=" + fontColor + " ><a href=" + entry.getValue().split(";")[1]
                                           + ">" + entry.getKey() + ": " + entry.getValue().split(";")[0] + "</a></font>");
                                    out.println("<Br>");
                                }else{
                                    out.println("<font color=" + fontColor + " >" + entry.getKey()
                                                 + ": " + entry.getValue() + "</font>");
                                    out.println("<Br>");

                                }


                            }
        }else{
                 String fontColor = "blue";
                 for (Map.Entry<String, String> entry : job_info_map.entrySet()) {
                     if ( entry.getValue().split(";").length > 1 ){
                         out.println("<font color=" + fontColor + " ><a href=" + entry.getValue().split(";")[1]
                                + ">" + entry.getKey() + ": " + entry.getValue().split(";")[0] + "</a></font>");  
                     }else if( entry.getKey() == "Error"){ 
                         out.println("<font color=red  >" + entry.getKey() + ":" + entry.getValue() +  "</font>");
                     }else{
                         out.println(entry.getKey() + ": " + entry.getValue());
                     }
                     out.println("<Br>");
                 }
        }     




%>
</div>
</body>
