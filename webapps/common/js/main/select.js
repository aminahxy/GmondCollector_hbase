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
      var clustArray_1 = new Array();
      var pageFlag;

      //
      var loadArray = ["load_one","cpu_num","proc_run"];
      var cpuArray = ["cpu_user","cpu_system","cpu_wio"];
      var memArray = ["mem_total","mem_cached","mem_buffers","mem_free","mem_shared"];
      var netArray = ["bytes_in","bytes_out","pkts_in","pkts_out"];
      var loadflag = 0;
      var cpuflag = 0;
      var netflag = 0;
      var memflag = 0;
      var Number=4;
      var metlen=-1;
      var loadArrayRes = new Array();
      var cpuArrayRes = new Array();
      var memArrayRes = new Array();
      var netArrayRes = new Array();
      var multArray = new Array();
      var multArray_1 = new Array();
      var checkArray = new Array();
//      var multObject = new Object();
      var temp = 0;
      var pageNum = 0;

      function getContainers(){
        $.getJSON(data_interface+"/get?method=getClusters&format=json&jsoncallback=?",  
          function(data){
            var cluster = data.names;
            var src=getArgs();
            clusterlength = cluster.length;
            for(var i=0;i<clusterlength;i++){
             if(src==cluster[i]){
             clusterinfo = {
                "name": cluster[i],
                "metricnum":Number,
                "container":"container" + i 
              }
              clusterArray.push(clusterinfo);
              makeContainer(clusterinfo);
             }
            }
            getdata();
          }
        );
      }
       
       
      function getContain(){
    	  $("#pageBar").html("");
    	  var graphNum=(document.getElementById('select3')==undefined)?20:document.getElementById('select3').value;
    	  var src=getArgs();
          $.getJSON(data_interface+"/get?method=getClusterInfo&clustername="+src+"&format=json&jsoncallback=?",
            function(data){
        	  pageNum = 0;
        	  metrics = data.metrics;
              metlen=metrics.length;
              Number=metlen;
              var hostsLen =metrics.length;
    		  var len=Math.floor(hostsLen/graphNum);
    		  pageLen = Math.ceil(hostsLen/graphNum);
    		  var fill_flag = 0;
    		  
    		  var Tag_input = '<input style="width:20px" id="page_input" value="1">';
			  var pagebar_html = '<a class="btn" href="javascript:;" onClick="pageClick2(1,pageLen)">首页</a>...第'+Tag_input+"页/共"+pageLen+'页<a class="btn" href="javascript:;" onClick="pageClick2(this.previousSibling.previousSibling.value,pageLen)">跳转</a>...<a class="btn" href="javascript:;" onClick="pageClick2(pageLen,pageLen)">尾页</a>';
			  $("#pageBar").html(pagebar_html);
			  
    		  if(hostsLen > graphNum){
    			  flag = graphNum;
	    		  multArray = [];
	    		  clustArray = [];
	    		  $("#divcontain").html("");
	    		  temp = 0;
    		  for(var i = 0; i < graphNum; i++){
    			  var strs = new Array(); //定义一数组
    			  strs=metrics[i].split("#");
    			  var hostname = strs[1];
    			  metricinfo = {
    			      'hostname': hostname,
    			      'metric' : metricName,
    			      'contain' : 'contain'
    			  };
    			checkTime(1);
    			var contain=metricinfo.contain+i;
               $.getJSON(data_interface+"/get?method=getClusterMetric&clustername=" + src + "&metric=" + hostname + "&timeFrom=" + starttime +  "&timeTo=" + endtime + "&format=json&jsoncallback=?",  
                  function(data){
                    var obj = {"cluster":data.clusterName,"name":data.metricName,"data":data.data,"contain":contain}
                    fillContain(obj,fill_flag++);
                    //multArray.push(obj);
                  }
               );
                clustArray.push(metricinfo);
               if(i%2==0) makeContain(metricinfo);
                
             }
             //setTimeout("for(var i=0;i<multArray.length;i++)fillContain(multArray[i],i);", 1000);
           }
          }
         );
       }
       function pageClick2(pageNo,pageLen){
    	  if(!pageNo||pageNo==""||pageNo<1||pageNo>pageLen){
    		  return;
    	  }
    	  
    	  var src=getArgs();
     	  var graphNum=document.getElementById('select3').value;
     	  var start = (pageNo - 1) * graphNum;
     	  var end = graphNum;
     	  if(pageNo == pageLen){
     		  end = metrics.length - start;
     	  }
     	  multArray = [];
 		  clustArray = [];
 		  $("#divcontain").html("");
 		  temp = 0;
 		  var fill_flag = 0;
 		  for(var i = 0; i < end; i++){
 			  metricinfo = {
 			      'hostname': metrics[start + i],
 			      'metric' : metricName,
 			      'contain' : 'contain'
 			  };
 			  checkTime(1);
 			  var contain = metricinfo.contain + i;
 			  $.getJSON(data_interface+"/get?method=getClusterMetric&clustername="+src+"&metric="+metricinfo.hostname+"&timeFrom="+starttime+"&timeTo="+endtime + "&format=json&jsoncallback=?",
 			  function(data){
 				  var obj = {"cluster":data.clusterName,"name":data.metricName,"data":data.data,"contain":contain}
 				 fillContain(obj,fill_flag++);
 				  //multArray.push(obj);
 			  });
 			  clustArray.push(metricinfo);
               if(i%2==0) makeContain(metricinfo);
               var page_input = document.getElementById('page_input');
               page_input.value = pageNo;
             }
 		  //setTimeout("for(var i=0;i<multArray.length;i++) fillContain(multArray[i],i);", 1000);
       }
      function makeContain(object){
          //flagnum++;
          var htmlstr='';
          htmlstr = $("#divcontain")[0].innerHTML;
          var num = 2;
          for(i=0;i<num/2;i++){
            if(i<=num/2-1){
              htmlstr = htmlstr + 
                "<div class='row' style='margin:0'><div id='" + object.contain + (temp++) + "' class='span6' style='height: 300px;'></div>" +
                "<div id='" + object.contain + (temp++) + "' class='span6' style='height: 300px;'></div></div>"
            }else{
              htmlstr = htmlstr + 
                "<div class='row' style='margin:0'><div id='" + object.contain + (temp++) + "' class='span6' style='height: 300px;'></div></div>"
            }
          }
          $("#divcontain").html(htmlstr);
        }
      function makeNavigator(){
    	  var slt='<input type="checkbox" id="checkbox" style="margin-left:10px;margin-bottom:15px"><lebel>&nbsp;按主机查询</lebel>'+'&nbsp;&nbsp;<select id="select" class="chzn-select" style="width:105px;margin-left:20px;"></select>'+'<input type="button" class="btn btn-primary" value="search" style="margin-left:10px;margin-bottom:8px" onclick="change()"/>';
    	  $("#divNext").html(slt);
          slt='<input type="text" onfocus="WdatePicker({startDate:\'%y-%M-%d %H:%m:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})" class="Wdate" id="start0" style="width:136px">'+'<input type="text" onmouseout="blur()" onfocus="WdatePicker({startDate:\'%y-%M-%d %H:%m:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})" class="Wdate" id="end0" style="width:136px;margin-left:20px;">'+'<input type="button" class="btn btn-primary" value="search" style="margin-left:10px;margin-bottom:8px" onclick="checkout_1(0)"/>';
    	  $("#divnavigator").html(slt);
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
              "<div class='row' style='margin:0'><div id='" + object.container + (temp++) + "' class='span6' style='height:300px;'></div></div>"
          }
        }
        $("#divcontainer").html(htmlstr);
      }
    //赵敏添加；梁宇辰修改
      var metricName;
      var hosts;
      var flag = 0;
      var pageLen;
      function pageClick(pageNo,pageLen){
    	  if(!pageNo||pageNo==""||pageNo<1||pageNo>pageLen){
    		  return;
    	  }
    	  var graphNum=document.getElementById('select3').value;
    	  var start = (pageNo - 1) * graphNum;
    	  var end = graphNum;
    	  if(pageNo == pageLen){
    		  end = hosts.length - start;
    	  }
    	  multArray = [];
		  clustArray = [];
		  $("#divcontain").html("");
		  temp = 0;
		  var fill_flag = 0;
		  for(var i = 0; i < end; i++){
			  metricinfo = {
			      'hostname': hosts[start + i],
			      'metric' : metricName,
			      'contain' : 'contain'
			  };
			  var startdate = new Date();
			  var startmills = parseInt(startdate.getTime()/1000);
			  var contain = metricinfo.contain + i;
			  $.getJSON(data_interface+"/get?method=getHostMetric&hostname="+metricinfo.hostname+"&metric="+metricinfo.metric+"&timeFrom="+(startmills-3600)+"&timeTo="+startmills + "&format=json&jsoncallback=?",
			  function(data){
				  var obj = {"cluster":data.hostName,"name":data.hostName,"data":data.data,"contain":contain}
				  //multArray.push(obj);
				  fillContain(obj,fill_flag++);
			  });
			  clustArray.push(metricinfo);
              if(i%2==0) makeContain(metricinfo);
			  var page_input = document.getElementById('page_input');
              page_input.value = pageNo;
            }
		  //setTimeout("for(var i=0;i<multArray.length;i++) fillContain(multArray[i],i);", 1000);
      }
    //赵敏添加；梁宇辰修改 
      function changeSecond(){
    	  pageFlag=2;
    	  $("#pageBar").html("");
    	  var metric = $("#select2").find('option:selected').text();
    	  var strs = new Array(); //定义一数组
		  strs=metrics[i].split("#");
		  metric = strs[1];
    	  var graphNum=document.getElementById('select3').value;
    	  var src=getArgs();
    	  $.getJSON(data_interface+"/get?method=getClusterMetricRanking&clustername="+src+"&metric="+metric+"&format=json&jsoncallback=?",
    	  function(data){
    		  pageNum = 0;
    		  var clusterName = data.clusterName; 
    		  metricName = data.metricName;
    		  hosts = data.hosts;
    		  var hostsLen =hosts.length;
    		  var len=Math.floor(hostsLen/graphNum);
    		  pageLen = Math.ceil(hostsLen/graphNum);
    		  
    		  var Tag_input = '<input style="width:20px" id="page_input" value="1">';
			  var pagebar_html = '<a class="btn" href="javascript:;" onClick="pageClick(1,pageLen)">首页</a>...第'+Tag_input+"页/共"+pageLen+'页<a class="btn" href="javascript:;" onClick="pageClick(this.previousSibling.previousSibling.value,pageLen)">跳转</a>...<a class="btn" href="javascript:;" onClick="pageClick(pageLen,pageLen)">尾页</a>';
			  $("#pageBar").html(pagebar_html);
    		  if(hostsLen > graphNum){
    			  flag = graphNum;
	    		  multArray = [];
	    		  clustArray = [];
	    		  $("#divcontain").html("");
	    		  temp = 0;
	    		  var fill_flag = 0;
	    		  for(var i = 0; i < graphNum; i++){
	    			  metricinfo = {
	    			      'hostname': hosts[i],
	    			      'metric' : metricName,
	    			      'contain' : 'contain'
	    			  };
	    			  checkTime(1);
	    			  var contain = metricinfo.contain + i;
	    			  $.getJSON(data_interface+"/get?method=getHostMetric&hostname="+metricinfo.hostname+"&metric="+metricinfo.metric+"&timeFrom="+starttime+"&timeTo="+endtime + "&format=json&jsoncallback=?",
	    			  function(data){
	    				  var obj = {"cluster":data.hostName,"name":data.hostName,"data":data.data,"contain":contain}
	    				  fillContain(obj,fill_flag++);
	    				  //multArray.push(obj);
	    			  });
	    			  clustArray.push(metricinfo);
	    			  
	                  if(i%2==0) makeContain(metricinfo);
	                }
	    		  //setTimeout("for(var i=0;i<multArray.length;i++) fillContain(multArray[i],i);", 1000);
	    	   }
    		  else{
    			  flag = hostsLen;
    			  multArray = [];
	    		  clustArray = [];
	    		  $("#divcontain").html("");
	    		  temp = 0;
	    		  var fill_flag = 0;
	    		  for(var i = 0; i < hostsLen; i++){
	    			  metricinfo = {
	    			      'hostname': hosts[i],
	    			      'metric' : metricName,
	    			      'contain' : 'contain'
	    			  };
	    			  var startdate = new Date();
	    			  var startmills = parseInt(startdate.getTime()/1000);
	    			  var contain = metricinfo.contain + i;
	    			  $.getJSON(data_interface+"/get?method=getHostMetric&hostname="+metricinfo.hostname+"&metric="+metricinfo.metric+"&timeFrom="+(startmills-3600)+"&timeTo="+startmills + "&format=json&jsoncallback=?",
	    			  function(data){
	    				  
	    				  var obj = {"cluster":data.hostName,"name":data.hostName,"data":data.data,"contain":contain}
	    				  fillContain(obj,fill_flag++);
	    				  //multArray.push(obj);
	    			  });
	    			  clustArray.push(metricinfo);
	    			  
	                  if(i%2==0) makeContain(metricinfo);
	                }
	    		  //setTimeout("for(var i=0;i<multArray.length;i++) fillContain(multArray[i],i);", 1000);
    		  }
    	  });
      }
    //赵敏添加
      function changeFirst() {
    	  pageFlag=1;
    	  $("#pageBar").html("");
    	  multArray = [];
		  clustArray = [];
		  $("#divcontain").html("");
		  temp = 0;
		  getContain();
      }
    function changePage(){
 		if(pageFlag==2){
 		  changeSecond();
    	}
 		else{
 		  getContain();
 		}
    }
      function getArgs(){
  	    var args = {};
  	    var match = null;
  	    var src = decodeURIComponent(location.search.substring(1));
  	    var args=src.split('=')[1];
  	    return args;
  	}
      function checkTime(type){
          if(type==0){
        	  starttime=$('#start0').val();
        	  endtime=$('#end0').val();
          }
          else if(type==1){
        	  starttime=$('#start1').val();
        	  endtime=$('#end1').val();
          }
    	  
    	  
    	  if(starttime==undefined&&endtime==undefined){//不选择起止时间默认当前时间前一小时
          	  var startdate = new Date();
                endtime = parseInt(startdate.getTime()/1000);
                starttime=endtime-3600;
          }
    	  else if(starttime==''&&endtime==''){
          	  var startdate = new Date();
                endtime = parseInt(startdate.getTime()/1000);
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
          		alert('输入的起止时间不能相同！');
          		return;
          	  }
    	  }
      }
      
      function checkout_1(type){
      	var src=getArgs();
      	checkTime(type);
      	var host=document.getElementById('select').value;
      	var metric=document.getElementById('select2').value;
      	var num=document.getElementById('select3').value;
      	
		clusterArray.splice(0,1);
      	$("#divcontainer").html("");
		waitforcontainer();
        getContainers();
        //getContain();    	 
      }

      function getdata(){
      	var src=getArgs();
      	$.getJSON(data_interface+"/get?method=getClusterInfo&clustername="+src+"&format=json&jsoncallback=?",
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
      		   dd.appendChild(opt);
      		   //first.innerHTML=hosts[i];
      		   //first=first.nextSibling;
      		 }
      		 for(var i=0;i<metricslength;i++){
      		   var opt=document.createElement('option');
        	   opt.innerHTML=metrics[i];
        	   dd2.appendChild(opt);
      		 }
      		 var nav=document.getElementById('navigator');
      		 var src=getArgs();
      		 var navi='&nbsp;>>&nbsp;'+src;
      		  if(nav.innerHTML=="<a href=\"index.php/clustersummary\">Cluster Summary</a>"){
      		 	nav.innerHTML+=navi; 
      		  }
      		$(".chzn-select").chosen();
      	   }
      	);
      }
        function change(){
         var host = $("#select_chzn a span:eq(0)").html()||document.getElementById('select').value;
      	  //var host=document.getElementById('select').value;
      	  if(document.getElementById('checkbox').checked==true){
      		var cluster=getArgs();
      		var cookie='start='+cluster+"&"+host;
        	document.cookie=cookie;
      		window.location.href="index.php/monitor/hostDetail?src="+host;
      	  }
      	  $.getJSON(data_interface+"/get?method=getHostInfo&hostname="+host+"&format=json&jsoncallback=?",
              function(data){
      		  var metrics=data.metrics;
      		  var dd2=document.getElementById("select2");
      		  var dd2length=dd2.childNodes.length;
      		  for(var i=dd2length;dd2length!=0;dd2length--){
      			var first=dd2.childNodes[0];
      			dd2.removeChild(first);
      		  }
      	  	  metricslength=metrics.length;
      		  for(var i=0;i<metricslength;i++){
      		    var opt=document.createElement('option');
        		    opt.innerHTML=metrics[i];
        		    dd2.appendChild(opt);
      		  }
      	    }
      	  );
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
    	  
    	  clusterlength-=1;
        if(clusterlength == flagnum){
          //make graph,container has complete
          makeGraph();
          waitforMetric();
          return;
        }
        setTimeout("waitforcontainer()",10);
      }
      function init(){
    	  makeNavigator();
    	  waitforcontainer();
          getContainers();
          getContain();
      }
	  init();
      function makeGraph(){
    	checkTime(0);
      	
      	var metricArray = new Array();
        metricArray.push(loadArray);
        metricArray.push(cpuArray);
        metricArray.push(memArray);
        metricArray.push(netArray);
        
        loadArrayRes.splice(0,loadArrayRes.length); 
      	cpuArrayRes.splice(0,cpuArrayRes.length);
      	memArrayRes.splice(0,memArrayRes.length);
      	netArrayRes.splice(0,netArrayRes.length);

      	clusterlength = clusterArray.length;
      	for(var x=0;x<clusterArray.length;x++){
          var clustername = clusterArray[x].name;
          for(var y=0;y<metricArray.length;y++){
            var container = clusterArray[x].container+y;
            for(var z=0;z<metricArray[y].length;z++){
              $.getJSON(data_interface+"/get?method=getClusterMetric&clustername=" + clustername + "&metric=" + metricArray[y][z] + "&timeFrom=" + starttime +  "&timeTo=" + endtime + "&format=json&jsoncallback=?",  
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
              "series":resultArray[i],
              "color":""
            }
            showGraph(test3);
          }
        }
      function fillContain2(resArray,offset){
     	  var tempArray = new Array();
          var resultArray = new Array();
            if(!tempArray.contains(resArray.cluster)){
              tempArray.push(resArray.cluster)
              var tempResArray = new Array();
              tempResArray.push({"name":resArray.metricName,"data":resArray.data})
              resultArray.push(tempResArray);
            }else{
              for (var i = 0; i < tempArray.length; i++) {    
                if (tempArray[i] == resArray.cluster) { 
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