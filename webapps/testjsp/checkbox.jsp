<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <form name="op" action="./333.jsp" method="post">
        <title>test</title>
        <style type="text/css">
            .ct{
                text-align:center;
            }
        </style>
        <script type="text/javascript">
            function allCheck(){
                var obj=document.getElementsByTagName("input");
                if(document.getElementById("all").checked==true){
                    for(var i=0;i<obj.length;i++){
                        obj[i].checked=true;
                    }
                }else{
                    for(var i=0;i<obj.length;i++){
                        obj[i].checked=false;
                    }
                }
            }
            function checkT_F(){
                var obj=document.getElementsByTagName("input");
                var j=0;
                for(var i=0;i<obj.length;i++){
                    if(obj[i].id!='all'){
                        if(obj[i].checked==true){
                            j++;
                        }
                    }
                }
                if(j==(obj.length-1)){
                    document.getElementById("all").checked=true;
                }else{
                    document.getElementById("all").checked=false;
                }
            }
        </script>
        </head>
<body>
<div>
    <div class="zuo">
        <div><input type="checkbox" id="all"  onclick="javascript:allCheck()"/>all</div>
    </div>
    <%

        String[] a=new String[10];
        for (int j=0;j<10;j++)
        {  a[j]=String.valueOf(j);
        }
        for(int i=0;i<10;i++) {
    %><div><input type="checkbox" name="phy" value="<%=a[i]%>">[<%=a[i]%>]</div><%
    }
%>



</div>

</body>
</html>
