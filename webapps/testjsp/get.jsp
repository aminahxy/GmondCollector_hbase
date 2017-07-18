<%@page contentType="text/html; charset=GB2312"%>
<html>
    <head>
        <title>
            get.jsp file
        </title>
    </head>

    <body style="background-color:lightblue">
        <%
            out.println(request.getAttribute("name"));
        %>
    </body>
</html>
