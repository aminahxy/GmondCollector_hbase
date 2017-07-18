<%
    //get parameters
    String username = request.getParameter("username");

//check null
    if (username == null ) {
        response.sendRedirect("login.jsp");
    }

//validate
    boolean isValid = false;
    if(username.equals("miao"))
    {
        isValid=true;
    }
    if (isValid) {
        session.setAttribute("username", username);
        response.sendRedirect("welcome.jsp");
    } else {
        response.sendRedirect("login.jsp");
    }
%>