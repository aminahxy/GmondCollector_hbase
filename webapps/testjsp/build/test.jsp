<select id="select1" name="select1" onchange="tt(this.id)">
<option value="">choose</option>
<option value="value1">opt1</option>
<option value="2">opt2</option>
<option value="3">opt3</option>
</select>
<input type="text" id="txt1">
<script>
function tt(id) {
  var aa = document.getElementById(id);
  //alert(aa.value);
  if(aa.value=="value1") 
 {document.getElementById('txt1').value= "hahahah"; 
 document.getElementById('txt1').style.color='#C0C0C0';  
}  
else if(aa.value=="2")
document.getElementById('txt1').value= "lalala";
else
document.getElementById('txt1').value= "qusi";
}
</script>

