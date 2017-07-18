<html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="jquery.confirm/jquery.confirm.css" />
<script src="../../jquery.min.js"></script>
<script src="jquery.confirm/jquery.confirm.js"></script>
</head>
<body>
<script type="text/javascript">
function disp_pr()
  {
    $.confirm({
                        'title'         : '是否存在',
                        'message'       : '之前是否有其他集群升级过相同内容？<br />有，点是，若没有点不存在，创建升级内容',
                        'buttons'       : {
                                '是'   : {
                                        'class' : 'blue',
                                        'action': function(){
                            location.href="http://tentacles.dmop.baidu.com:8010/build/1.html";     
                                   }
                                },
                                '不存在'    : {
                                        'class' : 'gray',
                                        'action': function(){
                                    location.href="http://tentacles.dmop.baidu.com:8010/build/0.html"; }  
                                }
                        }
                });  
}
</script>
<input type="button" onclick="disp_pr()" value="test啊" />

</body>
</html>
