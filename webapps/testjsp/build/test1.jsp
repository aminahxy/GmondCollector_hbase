<body>
<script language="javascript">
var seltxt='';
function check(){
   alert(seltxt);
}
function getSelText(o){
    o.focus();
    if(typeof document.selection !="undefined"){
        return document.selection.createRange().text;  
    } else {
        return o.value.substr(o.selectionStart,o.selectionEnd-o.selectionStart);
    }
}
</script>
<textarea cols="50" rows="10" name="description" onselect="javascript:seltxt=getSelText(this);">abcdefg</textarea>
<input type="button" onclick="check()" />
</body>
