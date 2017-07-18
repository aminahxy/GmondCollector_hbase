<%@ page
        language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
        session = "true"
        import="java.util.*"
        import="com.sina.data.util.MySql"
        import="com.sina.data.DataProducer.*"


%>
<%
    /***
     ** http://cas.erp.sina.com.cn/cas/login?ext=&service=http://10.39.2.150:8080/login.jsp
     ***/
    String loginJspName = "login.jsp";
    String host = request.getHeader("Host");
    String requestUrl = "http://" + host + "/" + loginJspName;
    String cas = "http://cas.erp.sina.com.cn/cas/";
    String logoutUrl = cas  + "logout?service=" + requestUrl;
    response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
    response.setHeader("Location",logoutUrl);

%>