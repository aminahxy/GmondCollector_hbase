<html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<head>
   <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <script src="../bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="../jquery.confirm/jquery.confirm.css" />
<script src="../jquery.min.js"></script>
<script src="../jquery.confirm/jquery.confirm.js"></script>
<script type="text/javascript" src="jquery.form.min.js"></script>
<meta name="keywords" content="" />
<title></title>
</head>
<body>
<p>
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">操作目的</label>
    <textarea class="form-control" id="mudi"  name="mudi" type="txt" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"></textarea>
   </div>
<hr>
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">操作步骤</label>
   </div>
<script language="javascript">

function addRowToTable()
{
var tbl = document.getElementById('tblSample');
var lastRow = tbl.rows.length;
// if there's no header row in the table, then iteration = lastRow + 1

var iteration = lastRow;
var row = tbl.insertRow(lastRow);
// left cell

var cellLeft = row.insertCell(0);
var textNode = document.createTextNode(iteration);
//cellLeft.appendChild(sel);
cellLeft.appendChild(textNode);
// right cell
var cellRightSel = row.insertCell(1);
var sel = document.createElement('select');
var sel_1 = document.createElement('select');
sel.name = 'selRow' + iteration;
sel.id = 'selRow' + iteration;
sel_1.name = 'seltest' + iteration;
sel.options[0] = new Option('文件修改', 'value0');
sel.options[1] = new Option('包合并', 'value1');

sel_1.options[0] = new Option('add', 'valu0');
sel_1.options[1] = new Option('delete', 'valu1');
sel_1.options[1] = new Option('modify', 'valu2');
cellRightSel.appendChild(sel);
cellRightSel.appendChild(sel_1);
var cellRight = row.insertCell(2);
var el = document.createElement('input');
var el_1 = document.createElement('input');
el.type = 'text';
el.name = 'txtRow' + iteration;
el.id = 'txtRow' + iteration;
el.size = 40;
el_1.type = 'text';
el_1.name = 'txtRo' + iteration;
el_1.id = 'txtRo' + iteration;
el_1.size = 40;
cellRight.appendChild(el);
cellRight.appendChild(el_1);
}

function keyPressTest(e, obj)
{
var validateChkb = document.getElementById('chkValidateOnKeyPress');
if (validateChkb.checked) {
var displayObj = document.getElementById('spanOutput');
var key;
if(window.event) {
key = window.event.keyCode;
}
else if(e.which) {
key = e.which;
}

var objId;
if (obj != null) {
objId = obj.id;
} else {
objId = this.id;
}
displayObj.innerHTML = objId + ' : ' + String.fromCharCode(key);
}
}
function removeRowFromTable()
{
var tbl = document.getElementById('tblSample');
var lastRow = tbl.rows.length;
if (lastRow > 2) tbl.deleteRow(lastRow - 1);
}

function openInNewWindow(frm)
{
// open a blank window

var aWindow = window.open('', 'TableAddRowNewWindow',
'scrollbars=yes,menubar=yes,resizable=yes,toolbar=no,width=400,height=400');
// set the target to the blank window

frm.target = 'TableAddRowNewWindow';
// submit

frm.submit();
}
function validateRow(frm)
{
var chkb = document.getElementById('chkValidate');
if (chkb.checked) {
var tbl = document.getElementById('tblSample');
var lastRow = tbl.rows.length - 1;
var i;
for (i=1; i<=lastRow; i++) {
var aRow = document.getElementById('txtRow' + i);
if (aRow.value.length <= 0) {
alert('Row ' + i + ' is empty');
return;
}
}
}
openInNewWindow(frm);
}

</script>
<script type="text/javascript">
$(function(){
	var options = {
       // target:        '#output',   // target element(s) to be updated with server response
        beforeSubmit:  showRequest,  // pre-submit callback
        success:       showResponse,  // post-submit callback
		resetForm: true,
		dataType:  'json'

        // other available options:
        //url:       url         // override for form's 'action' attribute
        //type:      type        // 'get' or 'post', override for form's 'method' attribute
        //dataType:  null        // 'xml', 'script', or 'json' (expected server response type)
        //clearForm: true        // clear all form fields after successful submit
        //resetForm: true        // reset the form after successful submit

        // $.ajax options can be used here too, for example:
        //timeout:   3000
    };

    // bind to the form's submit event
    $('#my_form').submit(function() {
        // inside event callbacks 'this' is the DOM element so we first
        // wrap it in a jQuery object and then invoke ajaxSubmit
        $(this).ajaxSubmit(options);

        // !!! Important !!!
        // always return false to prevent standard browser submit and page navigation
        return false;
    });
});
// pre-submit callback
function showRequest(formData, jqForm, options) {

	$("#msg").html("正在保存...");

    return true;
}


// post-submit callback
function showResponse(responseText, statusText)  {
	$("#msg").html('保存成功');
      document.getElementById("test").disabled=false;
    // for normal html responses, the first argument to the success callback
    // is the XMLHttpRequest object's responseText property

    // if the ajaxSubmit method was passed an Options Object with the dataType
    // property set to 'xml' then the first argument to the success callback
    // is the XMLHttpRequest object's responseXML property

    // if the ajaxSubmit method was passed an Options Object with the dataType
    // property set to 'json' then the first argument to the success callback
    // is the json data object returned by the server

    //alert('status: ' + statusText + '\n\nresponseText: \n' + responseText +
    //    '\n\nThe output div should have already been updated with the responseText.');
}
</script>
<p>
</select>
<select name="sel_cluster">
<option value="cluster0">gzns-lizhu</option>
<option value="cluster1">nj01-jiuying</option>
<option value="cluster2">mix-test</option>
<option value="cluster3">cq02-baihua</option>
<option value="cluster4">nmg01-luwu</option>
<option value="cluster5">yq01-baize</option>
</select>
<select name="selmodule">
<option value="module0">idle_agent</option>
<option value="module1">afs_agent</option>
<option value="module2">nma</option>
<option value="module3">check_env</option>
<option value="module4">matrix</option>
</select>
<input type="button" value="添加" onclick="addRowToTable();" />
<input type="button" value="删除" onclick="removeRowFromTable();" />
<input type="button" value="提交" onclick="validateRow(this.form);" />
<input type="checkbox" id="chkValidate" /> Validate Submit
</p>
<table border="1" id="tblSample">
<tr>
<th colspan="3">添加选项,eg:</th>
</tr>
<tr>
<td>1</td>
<td>
<select id="selRow0" name="selRow0" onchange="tt(this.id)">
<option value="">choose</option>
<option value="value0">文件修改</option>
<option value="value1">包合并</option>
</select>
<select name="seltest">
<option value="valu0">add</option>
<option value="valu1">delete</option>
<option value="valu2">modify</option>
</select>
</td>
<td>
<input type="text" name="txtRow1" id="txtRow1" size="40" />
<input type="text" name="txtRo1" id="txtRo1" size="40" />
</td>
</tr>
</table>
<p><button type="button" id="test" disabled="true" onclick="firm()"  class="btn btn-default btn-lg" width=100px >下一步</button></a></p>
<form id="my_form" action="aa.jsp" method="post">
<p><input type="submit" class="btn" value="保存模板"><span id="msg"></span></p>
</form>
</body>
</html>
<script language="javascript"  charset="utf8">
function tt(id) {
  var aa = document.getElementById(id);
  //alert(aa.value);
  if(aa.value=="value0")
 {
 document.getElementById('txtRow1').value= "hahahah";
 document.getElementById('txtRow1').style.color='#C0C0C0';
 document.getElementById('txtRo1').value= "miaomiaomiao";
 document.getElementById('txtRo1').style.color='#C0C0C0';
}
else
{
document.getElementById('txtRow1').value= "lalala";
document.getElementById('txtRo1').value= "wangwangwang";
document.getElementById('txtRo1').style.color='#C0C0C0';
}
}
function StandardPost (url,args) 
    {
        var form = $("<form method='post'></form>");
        form.attr({"action":url});
        for (arg in args)
        {
            var input = $("<input type='hidden'>");
            input.attr({"name":arg});
            input.val(args[arg]);
            form.append(input);
        }
        form.submit();
    }
function firm()

{
           $.confirm({
                        'title'         : '是否还有其他模块需要升级',
                        'message'       : '是否还有其他模块需要升级？（eg:idle_agent,afs_agent,nma等）<br />有，点是!!继续填写其他模板的升级步骤（eg:idle_agent,afs_agent,nma等）<br />没有点否，则进入下一步做包过程，嗯',
                        'buttons'       : {
                                '是'   : {
                                        'class' : 'blue',
                                        'action': function(){
                  
                                 var porjectid=document.getElementById("mudi").value;
                               //   $.post("http://tentacles.dmop.baidu.com:8010/build/add_little.jsp")
                              //encodeURI(encodeURI($("#porjectid").val()));
                              StandardPost("http://tentacles.dmop.baidu.com:8010/build/add_little.jsp",{id:porjectid});
                              //  location.href="http://tentacles.dmop.baidu.com:8010/build/add_little.jsp?id="+porjectid;

                                   }
                                },
                                '否'    : {
                                        'class' : 'gray',
                                        'action': function(){
                                }
                                }
                        }
                });


}
</script>
