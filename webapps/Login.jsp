<%@ page import="java.util.List" %>
<%@ page import="com.sina.data.util.MySql" %>
<%@ page
        contentType="text/html; charset=utf-8"
%>
<!DOCTYPE html>
<html lang="en" class=" js no-touch"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tentacles</title>

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

<%
  // String username=request.getParameter("username");
    String username="miaomiao";
%>

    <div class="btn-group pull-right">
        <!--a class="btn dropdown-toggle" data-toggle="dropdown" href="./logout.jsp">
            <i class="icon-user" ></i-->
            <a class="btn dropdown-toggle" href="./1.jsp" >
                <i class="icon-user"></i><%=username%>
            <span class="caret"></span>
        </a>
        </div>


    <meta charset="utf-8">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>




<ul class="nav nav-pills" style="width: 100%;">
    <li class="active"><a href="#">metric list</a></li>
    <li><a href="new_edit.jsp">metric set</a></li>






    <meta name="description" content="datatables is jquery-plugin">

    <!-- Le styles -->
    <link href="http://www.zhuhaihengxin.com/libs/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://www.zhuhaihengxin.com/libs/bootstrap/2.3.2/css/bootstrap-responsive.min.css" rel="stylesheet">
    <!--代码高亮-->
    <link href="http://www.zhuhaihengxin.com/libs/syntaxhighlighter/3.0.83/styles/shCore.css" rel="stylesheet" type="text/css"/>
    <link href="http://www.zhuhaihengxin.com/libs/syntaxhighlighter/3.0.83/styles/shThemeDefault.css" rel="stylesheet" type="text/css"/>

    <link href="http://www.zhuhaihengxin.com/libs/datatables/1.10.0/css/jquery.dataTables.css" rel="stylesheet">
    <link href="/css/docs.css" rel="stylesheet">
    <header class="jumbotron subhead" id="overview">
        <div class="container">
            <!--<a class="btn btn-lg btn-primary btn-shadow bs3-link" href="./zero_configuration_code.html" target="_blank"-->
            <!--role="button">代码回放</a>-->
        </div>
    </header>
    <div class="container">

            <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>

            <script>
                (adsbygoogle = window.adsbygoogle || []).push({});
            </script>
        </div>

            <%
    List<List<Object>> res= MySql.GetFromDataBase("cluster_monitor","cluster_monitor_register");
    List<Object> register = res.get(0);
    List<Object> metric = res.get(1);
    List<Object> host = res.get(2);

%>

        <form action="./2.jsp" method="GET" id="myform">
        <div class="row-fluid" style="margin-top:20px">
            <!-- 表格开始 -->
            <table id="example" class="display dataTable" cellspacing="0" width="100%" role="grid" aria-describedby="example_info"
                   style="width: 100%;">
                <thead>
                <tr role="row">
                    <th class="sorting_asc" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending"
                        aria-label="Name: activate to sort column ascending" style="width: 135px;">register_name
                    </th>
                    <th class="sorting" tabindex="0" aria-controls="example" rowspan="1" colspan="1"
                        aria-label="Position: activate to sort column ascending" style="width: 223px;">metric_name
                    </th>
                    <th class="sorting" tabindex="0" aria-controls="example" rowspan="1" colspan="1"
                        aria-label="Office: activate to sort column ascending" style="width: 99px;">host_list
                    </th>
                    <th class="sorting" tabindex="0" aria-controls="example" rowspan="1" colspan="1"
                        aria-label="Salary: activate to sort column ascending" style="width: 78px;">Actions
                    </th>
                </tr>
                </thead>

                <tbody>
                <%
                    for(int i=0;i<register.size();i++){
                %><tr>
                    <td>

                       <%=register.get(i)%>

                    </td>

                    <td>
                        <%=metric.get(i)%>

                    </td>

                    <td>
                        <%=host.get(i)%>
                    </td>
                    <td>

                        <p>
                            <a href="./2.jsp?register=<%=register.get(i)%>" target="_top">
                            <button type="button"  class="btn btn-info"  width=100px name="button1" id="button1">查看</button>
                        </p>
                        <p><a href="./edit.jsp?register=<%=register.get(i)%>" target="_top"><button type="button" class="btn btn-primary" width=100px >编辑</button></a></p>
                        <p><a href="./delete.jsp?register=<%=register.get(i)%>" target="_top"><button type="button" class="btn btn-danger" width=100px >删除</button></a></p>
                    </td>
                </tr><%
                    }
                %>
                </tbody>
            </table>

            <!-- 表格结束 -->
            <script src="http://www.zhuhaihengxin.com/libs/jquery/1.10.2/jquery.min.js"></script>
            <script src="http://www.zhuhaihengxin.com/libs/bootstrap/3.0.3/js/bootstrap.min.js"></script>

            <script type="text/javascript" charset="utf8" src="http://www.zhuhaihengxin.com/libs/datatables/1.10.4/js/jquery.dataTables.min.js"></script>



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
                        window.location.href="2.jsp?" + res;

                        return false;
                    } );



                });
            </script>
</form>
        </ul>
            </body>
</html>
