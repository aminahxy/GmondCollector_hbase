      $("#datediv").datepicker()
                      .on('changeDate', function(ev){
                        startDate = new Date(ev.date);
                        $('#date01').text($('#datediv').data('date'));
                        $('#datediv').datepicker('hide');
                      });
      //HighChart start
      var data_interface = $("#data_interface").html();
      var clusterlength = -1;
      var flagnum = 0;
      var clusterArray = new Array();
      var clustArray = new Array();

      //
      var loadArray = ["load_one","cpu_num","proc_run"];
      var cpuArray = ["cpu_user","cpu_system","cpu_wio"];
      var memArray = ["mem_total","mem_cached","mem_buffers","mem_free","mem_shared"];
      var netArray = ["bytes_in","bytes_out","pkts_in","pkts_out"];
      var loadflag = 0;
      var cpuflag = 0;
      var netflag = 0;
      var memflag = 0;
      var metlen=-1;
      var loadArrayRes = new Array();
      var cpuArrayRes = new Array();
      var memArrayRes = new Array();
      var netArrayRes = new Array();
      var multArray = new Array();
      var checkArray = new Array();
      var temp = 0;
      var cluster;
      var host;
      var metrics;
      var starttime;
      var endtime;
      

      function arguements(){
    	  var allcookies=document.cookie;
    	  var pos=allcookies.indexOf('indexof=');
    	  if(pos!= -1){
    		var start=pos+8;
    		var end=allcookies.indexOf(';',start);
    		if(end== -1)end=allcookies.length;
    		var string=allcookies.substring(start,end);
    		var argues=string.split('&');
    		cluster=argues[0];
    		host=argues[1];
    		metric=argues[2];
    		var strs = new Array(); //定义一数组
	  		strs=metric.split("#");
	  		metric = strs[1];
    		starttime=argues[3];
    		endtime=argues[4];
    	  }
    	  var nav=document.getElementById('navigator');
    	  var navi='&nbsp;>>&nbsp;'+'<a href="index.php/monitor/select?src='+cluster+'">'+cluster+'</a>'+'&nbsp;>>&nbsp;'+'<a href="index.php/monitor/hostDetail?src='+getArgs()+'">'+getArgs()+'</a>';
    	  nav.innerHTML+=navi;
      }
      function getContainers(){
    	  arguements();
        var contain='divcon';
        if(starttime>endtime){var wamp=starttime;starttime=endtime;endtime=wamp;}
    	$.getJSON(data_interface+"/get?method=getHostMetric&hostname=" + host + "&metric=" + metric + "&timeFrom=" + starttime+  "&timeTo=" + endtime + "&format=json&jsoncallback=?",  
          function(data){
            var obj = {"hostName":data.hostName,"metricName":data.metricName,"data":data.data,"contain":contain}
            checkArray.push(obj);
          }
        );

    	var slt='<select class="chzn-select" id="select" onchange="change()" style="width:105px;margin-left:20px;"></select>'+'&nbsp;&nbsp;<select id="select2"  class="chzn-select" onchange="changeselect2()" style="width:250px;margin-left:20px;"></select>';
        slt+='<input type="text" onfocus="WdatePicker({startDate:\'%y-%M-%d %H:%m:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})" class="Wdate" id="start" style="width:136px;margin-left:20px">'+'<input type="text" onmouseout="blur()" onfocus="WdatePicker({startDate:\'%y-%M-%d %H:%m:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})" class="Wdate" id="end" style="width:136px;margin-left:20px;">'+'<input type="button" class="btn btn-primary" value="查询" style="margin-left:10px;margin-bottom:8px" onclick="makegrapher()"/>';
        htmlstr = $("#divcontainer")[0].innerHTML+slt;
        var temp = 0;
        setTimeout("htmlstr = htmlstr + \"<div class='row' id='row' style='margin:0'><div id='\" + checkArray[0].contain + (temp++) + \"' class='span8' style='width: 760px;height:420px;margin:0 auto;'></div></div>\";$(\"#divcontainer\").html(htmlstr);fillContain2(checkArray[0],0);getdata();", 1000);
      }
      function makegrapher(){
    	//var host=document.getElementById('select').value;
    	var host = $("#select_chzn a span:eq(0)").html();
    	$("#navigator a:eq(2)").html(host);
    	$("#navigator a:eq(2)").attr('href','index.php/hostDetail?src='+host);
    	//var metric=document.getElementById('select2').value;
    	var metric = $("#select2_chzn a span:eq(0)").html();
    	var strs = new Array(); //定义一数组
		strs=metric.split("#");
		metric = strs[1];
    	var starttime=document.getElementById('start').value;
    	var endtime=document.getElementById('end').value;
    	if(starttime==''&&endtime==''){//不选择起止时间默认当前时间前一小时
      	  var enddate = new Date();
      	  endtime = parseInt(enddate.getTime()/1000);
          starttime=endtime-3600;
        }
      	else if(starttime&&endtime){
      	  var start = new Date(starttime.replace(/-/g, '/'));
      	  var end = new Date(endtime.replace(/-/g, '/'));
      	  starttime=parseInt(start.getTime()/1000);
      	  endtime=parseInt(end.getTime()/1000);
      	  if(starttime>endtime){
      		var wrap=starttime;
      		starttime=endtime;
      		endtime=wrap;
      	  }
      	  else if(starttime==endtime){
      		alert('查询的起止时间不能相同！');
      		return;
      	  }
      	}
    	var contain='divcon';
    	if(starttime>endtime){var wamp=starttime;starttime=endtime;endtime=wamp;}
      	$.getJSON(data_interface+"/get?method=getHostMetric&hostname=" + host + "&metric=" + metric + "&timeFrom=" + starttime+  "&timeTo=" + endtime + "&format=json&jsoncallback=?",  
            function(data){
              var obj = {"hostName":data.hostName,"metricName":data.metricName,"data":data.data,"contain":contain}
              fillContain2(obj,0);
              checkArray.push(obj);
            }
          );
          getdata();
      }
      function makeContainer(object){
        flagnum++;
        var htmlstr = $("#divcontainer")[0].innerHTML;
        var num = 4;
        var temp = 0;
        for(i=0;i<num/2;i++){
          if(i<=num/2-1){
            htmlstr = htmlstr + 
              "<div class='row' style='margin:0'><div id='" + object.container + (temp++) + "' class='span6' style='height: 300px;'></div>" +
              "<div id='" + object.container + (temp++) + "' class='span6' style='height: 300px;'></div></div>"
          }else{
            htmlstr = htmlstr + 
              "<div class='row' style='margin:0'><div id='" + object.container + (temp++) + "' class='span6' style='height: 300px;'></div></div>"
          }
        }
        $("#divcontainer").html(htmlstr);
      }
      function checkout(){
    	starttime=document.getElementById('start').value;
    	endtime=document.getElementById('end').value;
    	if(starttime==''&&endtime==''){//不选择起止时间默认当前时间前一小时
    	  var startdate = new Date();
          starttime = parseInt(startdate.getTime()/1000);
          endtime=starttime-3600;
        }
    	else if(starttime&&endtime){
    	  var start = new Date(starttime.replace(/-/g, '/'));
    	  var end = new Date(endtime.replace(/-/g, '/'));
    	  starttime=parseInt(start.getTime()/1000);
    	  endtime=parseInt(end.getTime()/1000);
    	  if(starttime>endtime){
    		var wrap=starttime;
    		starttime=endtime;
    		endtime=wrap;
    	  }
    	  else if(starttime==endtime){
    		alert('输入的起止时间不能相同！');
    		return;
    	  }
    	}
    	var ip=document.getElementById('select').value;
    	var metric=document.getElementById('select2').value;
    	var strs = new Array(); //定义一数组
		strs=metrics.split("#");
		metric = strs[1];
    	var num=document.getElementById('select3').value;
    	var contain='divcon';
    	if(starttime>endtime){var wamp=starttime;starttime=endtime;endtime=wamp;}
    	$.getJSON(data_interface+"/get?method=getHostMetric&hostname=" + ip + "&metric=" + metric + "&timeFrom=" + starttime+  "&timeTo=" + endtime + "&format=json&jsoncallback=?",  
          function(data){
            var obj = {"hostName":data.hostName,"metricName":data.metricName,"data":data.data,"contain":contain}
            checkArray.push(obj);
          }
        );
    	var htmlstr='';
        htmlstr = $("#divcontainer")[0].innerHTML;
        var temp = 0;
            htmlstr = htmlstr + 
              "<div class='row' id='row' style='margin:0'><div id='" + checkArray[0].contain + (temp++) + "' class='span6' style='width:760px;height: 420px;'></div></div>"

        $("#divcontainer").html(htmlstr);
        fillContain2(checkArray[0],0);
      }
      function getdata(){
//      	var src=getArgs();
      	$.getJSON(data_interface+"/get?method=getClusterInfo&clustername="+cluster+"&format=json&jsoncallback=?",
           function(data){
      		 var hosts=data.hosts;
      		 var metrics=data.metrics;
      		 var dd=document.getElementById("select");
      		 var dd2=document.getElementById("select2");
      		 hostslength=hosts.length;
      		 metricslength=metrics.length;
      		for(var i=0;i<hostslength;i++){
      		   var opt=document.createElement('option');
      		   opt.innerHTML=hosts[i];
      		   if(hosts[i] == getArgs())
      			   opt.selected = true;
      		   dd.appendChild(opt);
      		 }
      		
      		for(var i=0;i<metricslength;i++){
      		   var opt=document.createElement('option');
        	   opt.innerHTML=metrics[i];
        	   if(metrics[i] == metric)
      			   opt.selected = true;
        	   dd2.appendChild(opt);
      		 }
      		$(".chzn-select").chosen();
      	   }
      	);
      }
        function change(){
      	  var ip=document.getElementById('select').value;
      	  $.getJSON(data_interface+"/get?method=getHostInfo&hostname="+ip+"&format=json&jsoncallback=?",
              function(data){
      		  var metrics=data.metrics;
      		  var dd2=document.getElementById("select2");
      		  var ul=$('.chzn-results')[1];
      		  var ullength=ul.getElementsByTagName('li').length;
      		  var dd2length=dd2.childNodes.length;
      		  for(var i=dd2length;dd2length!=0;dd2length--){
      			var first=dd2.childNodes[0];
      			dd2.removeChild(first);
      		  }
      		  for(var i=ullength;ullength!=0;ullength--){
      			var firstli=ul.childNodes[0];
      			ul.removeChild(firstli);
      		  }
      		  //$('#select2_chzn a span:eq(0)').html(metrics[0]);
      	  	  metricslength=metrics.length;
      		  for(var i=0;i<metricslength;i++){
      		    var opt=document.createElement('option');
      		    var li=document.createElement('li');
      		    li.setAttribute('class','active-result');
      		    var id='select_chzn_o_'+i;
      		    li.setAttribute('id',id);
      		    li.innerHTML=metrics[i];
      		    ul.appendChild(li);
        		    opt.innerHTML=metrics[i];
        		    dd2.appendChild(opt);
      		  }
      		}
      	  );
        }
        function changeselect2(){
          var con=$("[class='active-result result-selected']")[1].innerHTML;
          $('#select2_chzn a span:eq(0)').html(con);
        }
      Array.prototype.contains = function (element) {    
        for (var i = 0; i < this.length; i++) {    
          if (this[i] == element) {
            return true;    
          }    
        }    
        return false;    
      }  
      function waitforcontainer(){
    	  clusterlength+=1;
        if(clusterlength == flagnum){
          //make graph,container has complete
          makeGraph();
          waitforMetric();
          return;
        }
        setTimeout("waitforcontainer()",10);
      }
      waitforcontainer();
      getContainers();
//      navigator();

      function makeGraph(){
        var metricArray = new Array();
        metricArray.push(loadArray);
        metricArray.push(cpuArray);
        metricArray.push(memArray);
        metricArray.push(netArray);
        var startdate = new Date();
        var startmills = parseInt(startdate.getTime()/1000);
        for(var x=0;x<clusterArray.length;x++){
          var clustername = clusterArray[x].name;
          for(var y=0;y<metricArray.length;y++){
            var container = clusterArray[x].container+y;
            for(var z=0;z<metricArray[y].length;z++){
              $.getJSON(data_interface+"/get?method=getClusterMetric&clustername=" + clustername + "&metric=" + metricArray[y][z] + "&timeFrom=" + (startmills - 3600)+  "&timeTo=" + startmills + "&format=json&jsoncallback=?",  
                function(data){
                  var obj = {"cluster":data.clusterName,"name":data.metricName,"data":data.data,"container":container}
                  if(loadArray.contains(data.metricName)){
                    loadArrayRes.push(obj);
                  }else if(cpuArray.contains(data.metricName)){
                    cpuArrayRes.push(obj);
                  }else if(memArray.contains(data.metricName)){
                    memArrayRes.push(obj);
                  }else{
                    netArrayRes.push(obj);
                  }
                }
              );
            }
          }
        }
      }
      function fillContainer(resArray,offset){
        var tempArray = new Array();
        var resultArray = new Array();
        for(var a=0;a<resArray.length;a++){
          if(!tempArray.contains(resArray[a].cluster)){
            tempArray.push(resArray[a].cluster)
            var tempResArray = new Array();
            tempResArray.push({"name":resArray[a].name,"data":resArray[a].data})
            resultArray.push(tempResArray);
          }else{
            for (var i = 0; i < tempArray.length; i++) {    
              if (tempArray[i] == resArray[a].cluster) { 
                resultArray[i].push({"name":resArray[a].name,"data":resArray[a].data})
                break; 
              }    
            }    
          }
        }
        for(var i=0;i<tempArray.length;i++){
          var containerid = "";
          for(var t=0;t<clusterArray.length;t++){
            if(clusterArray[t].name==tempArray[i]){
              containerid = clusterArray[t].container;
              break;
            }
          }
          var test2 = {
            "render":containerid+offset,
            "text":"",
            "series":resultArray[i]
          }
          showGraph(test2);
        }
      }
      function fillContain(resArray,offset){
          var tempArray = new Array();
          var resultArray = new Array();
//          for(var a=0;a<resArray.length;a++){
            if(!tempArray.contains(resArray.cluster)){
              tempArray.push(resArray.cluster)
              var tempResArray = new Array();
              tempResArray.push({"name":resArray.name,"data":resArray.data})
              resultArray.push(tempResArray);
            }else{
              for (var i = 0; i < tempArray.length; i++) {    
                if (tempArray[i] == resArray.cluster) { 
                  resultArray[i].push({"name":resArray.name,"data":resArray.data})
                  break; 
                }    
              }    
            }
//          }
          for(var i=0;i<tempArray.length;i++){
        	var containerid='contain';
            var test3 = {
              "render":containerid+offset,
              "text":"",
              "series":resultArray[i]
            }
            showGraph(test3);
          }
        }
      function fillContain2(resArray,offset){
     	  var tempArray = new Array();
          var resultArray = new Array();
            if(!tempArray.contains(resArray.hostName)){
              tempArray.push(resArray.hostName)
              var tempResArray = new Array();
              tempResArray.push({"name":resArray.metricName,"data":resArray.data})
              resultArray.push(tempResArray);
            }else{
              for (var i = 0; i < tempArray.length; i++) {    
                if (tempArray[i] == resArray.hostName) { 
                  resultArray[i].push({"name":resArray.metricName,"data":resArray.data})
                  break; 
                }    
              }    
            }
          for(var i=0;i<tempArray.length;i++){
        	var containerid='divcon';
            var test3 = {
              "render":containerid+offset,
              "text":"",
              "series":resultArray[i]
            }
            showGraph(test3);
          }
          
          checkArray.pop()
        }
      function getArgs(){
  	    var args = {};
  	    var match = null;
  	    var src = decodeURIComponent(location.search.substring(1));
  	    var args=src.split('=')[1];
  	    return args;
  	}
      function waitforMetric(){
        var temp = 0;
        if(clusterlength>0 && clusterlength * loadArray.length  == loadArrayRes.length){
          temp++;
        }
        if(clusterlength>0 && clusterlength * cpuArray.length  == cpuArrayRes.length){
          temp++;
        }
        if(clusterlength>0 && clusterlength * memArray.length  == memArrayRes.length){
          temp++;
        }
        if(clusterlength>0 && clusterlength * netArray.length  == netArrayRes.length){
          temp++;
        }
        if(temp==4){
          fillContainer(loadArrayRes,0);
          fillContainer(cpuArrayRes,1);
          fillContainer(memArrayRes,2);
          fillContainer(netArrayRes,3);
          return;
        }
        setTimeout("waitforMetric()",30);
      }