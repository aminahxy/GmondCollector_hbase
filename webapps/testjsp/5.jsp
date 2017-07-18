<!DOCTYPE html>
<html>
<head>
   <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <script src="./jquery.min.js"></script>
   <script src="./bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<form name="op" action="./matrix_op.jsp" method="post">
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">host</label> 
    <textarea class="form-control" id="host"  name="host" type="txt" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"></textarea>
   </div> 
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">metajson file path</label> 
    <textarea class="form-control" id="metajson"  name="metajson" type="txt" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"></textarea>
   </div> 
   
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">serviceName</label> 
    <textarea class="form-control" id="serviceName"  name="serviceName" type="txt" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"></textarea>
   </div> 
   
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">matrix_service</label> 
    <textarea class="form-control" id="matrix_service"  name="matrix_service" type="txt" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"></textarea>
   </div> 
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">user</label> 
    <textarea class="form-control" id="user"  name="user" type="txt" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"></textarea>
   </div> 
    <div class="form-group">
   <label class="form-control" max-width="80%" style="max-width:80%;"  for="name">token</label> 
    <textarea class="form-control" id="token"  name="token" type="txt" aria-describedby="sizing-addon1" max-width="80%" style="max-width:80%;"></textarea>
   </div> 
  <label class="checkbox-inline">
      <input type="radio" name="op" id="add" 
         value="add" checked>add
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="op" id="delete" 
         value="delete">delete
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="op" id="update" 
         value="update">update
   </label>
   <label class="checkbox-inline">
      <input type="radio" name="op" id="reset" 
         value="reset">reset
   </label>
   <label class="checkbox-inline">
  <input type ="submit" value ="Submit"> 
  </label>
</form>

</body>
</html>			
