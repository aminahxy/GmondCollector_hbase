<!doctype html>
<script src="js/jquery-1.10.2.min.js"></script>
<body>
<button id="btn" onClick="edittxt()">change</button>
<textarea id="txt" disabled>
hahahaha</textarea>
<script type="text/javascript">
    var txt = document.getElementById('txt');
    var btn = document.getElementById('btn')
    function edittxt(){
            txt.removeAttribute('disabled');
        }  
</script>
</body>
