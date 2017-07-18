<html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>
<script type="text/javascript">
function disp_prompt()
  {
  var name=prompt("请输入您的名字","Bill Gates")
  if (name!=null && name!="")
    {
       document.write("hahaha");
       var div = document.createElement("div");
       div.innerHTML = "<b>zswang 路过</b>";
       document.body.appendChild(div);
    }
  }
</script>
</head>
<body>

<input type="button" onclick="disp_prompt()" value="显示一个提示框" />

</body>

