<%@ page
        contentType="text/html; charset=utf-8"
%>
<%@ page
        contentType="text/html; charset=utf-8"
        import="java.text.SimpleDateFormat"
        import="java.util.*"
        import="com.sina.data.bigmonitor.web.*"
        import="java.io.IOException"
        import="com.sina.data.bigmonitor.web.ClusterWithHost.*"
%>
<%


    ClusterWithHost cwh=new ClusterWithHost();
    List<ClusterHostBean> hosts= cwh.getHbaseHosts();
    boolean checkedB = false;
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
                            <!DOCTYPE html>
                            <html>
                            <head>
                                <!-- Le styles -->
                                <link href="http://www.zhuhaihengxin.com/libs/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet">
                                <link href="http://www.zhuhaihengxin.com/libs/bootstrap/2.3.2/css/bootstrap-responsive.min.css" rel="stylesheet">
                                <!--代码高亮-->
                                <link href="http://www.zhuhaihengxin.com/libs/syntaxhighlighter/3.0.83/styles/shCore.css" rel="stylesheet" type="text/css"/>
                                <link href="http://www.zhuhaihengxin.com/libs/syntaxhighlighter/3.0.83/styles/shThemeDefault.css" rel="stylesheet" type="text/css"/>

                                <link href="http://www.zhuhaihengxin.com/libs/datatables/1.10.0/css/jquery.dataTables.css" rel="stylesheet">
                                <link href="/css/docs.css" rel="stylesheet">
                            </head>
                            <body>

                            <header class="jumbotron subhead" id="overview">
                                <div class="container">
                                    <!--<a class="btn btn-lg btn-primary btn-shadow bs3-link" href="./filter_only_code.html" target="_blank"-->
                                    <!--role="button">代码回放</a>-->
                                </div>
                            </header>

                            <div class="container">
                                <div style="margin:10px 0">
                                    <!-- test -->
                                    <ins class="adsbygoogle"
                                         style="display:block"
                                         data-ad-client="ca-pub-2101546703939638"
                                         data-ad-slot="9922577908"
                                         data-ad-format="auto"></ins>
                                    <script>
                                        (adsbygoogle = window.adsbygoogle || []).push({});
                                    </script>
                                </div>
                                <div class="row-fluid" style="margin-top:20px">
                                    <form action="slavetimer_info.jsp" method="GET" id="myform">
                                        <!-- 表格开始 -->
                                        <button  type="submit">监控查看</button>
                                        <table id="example" class="display" cellspacing="0" width="100%">
                                            <thead>
                                            <tr>
                                                <th>host</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                List<String> filter=new ArrayList<String>();
                                                for(int i=0;i<20;i++)
                                                {
                                                    String tmp="10.39.3."+(i+42);
                                                    filter.add(tmp);
                                                }
                                                filter.add("10.39.6.85");
                                                filter.add("10.39.6.86");
                                                filter.add("10.39.6.87");
                                                for(String hb:filter){
                                              //  for(ClusterHostBean hblist:hosts) {
                                                //    for(String hb:hblist.getHosts()){

                                                            if(checkedB){
                                            %><tr>
                                                <td>
                                                    <input type="radio" name="hosts"  value="<%=hb%>"><%=hb%>
                                                </td>
                                            </tr><%
                                            }
                                            else
                                            {
                                            %><tr>
                                                <td>
                                                    <input type="radio" name="hosts"  checked=checked value="<%=hb%>"><%=hb%>
                                                </td>
                                            </tr><%
                                                                checkedB = true;
                                                            }


                                                }

                                                      for(ClusterHostBean hblist:hosts) {
                                                        for(String hb:hblist.getHosts()){

                                                    if(checkedB){
                                            %><tr>
                                                <td>
                                                    <input type="radio" name="hosts"  value="<%=hb%>"><%=hb%>
                                                </td>
                                            </tr><%
                                            }
                                            else
                                            {
                                            %><tr>
                                                <td>
                                                    <input type="radio" name="hosts"  checked=checked value="<%=hb%>"><%=hb%>
                                                </td>
                                            </tr><%
                                                        checkedB = true;
                                                    }


                                                }
                                                }

                                            %>



                                            </tbody>
                                        </table>

                                        <!-- 表格结束 -->

                                        <script>
                                            (function(){
                                                var bp = document.createElement('script');
                                                bp.src = '//push.zhanzhang.baidu.com/push.js';
                                                var s = document.getElementsByTagName("script")[0];
                                                s.parentNode.insertBefore(bp, s);
                                            })();
                                        </script>

                                        <script type="text/javascript">
                                            function noteTitle(obj){
                                                var note = $(obj).attr("title");
                                                alert(note);
                                            }
                                        </script>

                                        <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->

                                        <script src="http://www.zhuhaihengxin.com/libs/jquery/1.10.2/jquery.min.js"></script>

                                        <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->

                                        <script src="http://www.zhuhaihengxin.com/libs/bootstrap/3.0.3/js/bootstrap.min.js"></script>




                                        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>

                                        <script type="text/javascript">
                                            //判断是否显示更新提示
                                            $.get("/assets/updatelog.txt", function (data) {
                                                var json = JSON.parse(data);
                                                if (json.isNote) {
                                                    var cache = localStorage['dt.thxopen.com.note'];
                                                    if (typeof cache == 'undefined') {
                                                        $("#updateFlag").addClass("hot");
                                                    } else {
                                                        var current = new Date().getTime();
                                                        var bl = current - cache;
                                                        var s = 24 * 60 * 60 * 1000;
                                                        if (bl > s) {
                                                            $("#updateFlag").addClass("hot");
                                                        }
                                                    }
                                                }
                                            });
                                        </script>


                                        <script type="text/javascript">
                                            var table;
                                            $(document).ready(function () {
                                                table = $('#example').dataTable();

                                                $('#myform').submit( function() {
                                                    var res = table.$('input').serialize();
                                                    //alert( "The following data would have been submitted to the server: \n\n"+ res );
                                                    window.location.href="slavetimer_info.jsp?" + res;

                                                    return false;
                                                } );


                                            });
                                        </script>
                            </html>
