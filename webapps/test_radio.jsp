<html>

<form method=post action="a.jsp">
    <%
        String name=request.getParameter("username");
        session.setAttribute("username",name);
    %>
    Yournameis:<%=request.getParameter("username")%>
    <input type=submit value=submit>
</form>
</html>
