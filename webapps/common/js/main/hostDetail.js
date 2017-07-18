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
      var hostArray = new Array();
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
//      var multObject = new Object();
      var temp = 0;
	  var flag=0;
	  
	  var m_array;
      var category = new Array();
      var cat;
      var cat_content = new Array();

      var src=getArgs();
      function getContainers(){
          $.getJSON(data_interface+"/get?method=getHostInfo&hostname="+src+"&format=json&jsoncallback=?",  
            function(data){
              var host = data.name;
              clusterlength = 1;
               if(src==host){
               hostinfo = {
                  "name": host,
                  "metricnum":Number,
                  "container":"container1"
                }
                hostArray.push(hostinfo);
               makeContainer(hostinfo);
               }
              getdata();
            }
          );
        }
      
        function arguements(){
      	  var allcookies=document.cookie;
      	  var pos=allcookies.indexOf('start=');
      	  if(pos!= -1){
      		var start=pos+6;
      		var end=allcookies.indexOf(';',start);
      		if(end== -1)end=allcookies.length;
      		var string=allcookies.substring(start,end);
      		var argues=string.split('&');
      		cluster=argues[0];
      		host=argues[1];
      	  }
      	  if(flag==0){
      	  var nav=document.getElementById('navigator');
   		  var navi='&nbsp;>>&nbsp;'+'<a href="index.php/monitor/select?src='+cluster+'">'+cluster+'</a>'+'&nbsp;>>&nbsp;'+src;
      	  nav.innerHTML+=navi;
      	  flag++;
      	  }
        }
        
        function getCategory(){
        	var cat=document.getElementById('select4').value;
        	for(var j=0;j<category.length;j++){
        		if(cat==category[j])
        			break;
        	}
        	cat = j;
        	$("#divcontain").html("");
        	var fill_flag = 0;
        	temp = 0;
        	var pagestarttime=document.getElementById('pagestart1').value;
        	var pageendtime=document.getElementById('pageend1').value;
        	if(pagestarttime==''&&pageendtime==''){//不选择起止时间默认当前时间前一小时
        	  var pageenddate = new Date();
              pageendtime = parseInt(pageenddate.getTime()/1000);
              pagestarttime=pageendtime-3600;
            }
        	else if(pagestarttime&&pageendtime){
        	  var pagestart = new Date(pagestarttime.replace(/-/g, '/'));
        	  var pageend = new Date(pageendtime.replace(/-/g, '/'));
        	  pagestarttime=parseInt(pagestart.getTime()/1000);
        	  pageendtime=parseInt(pageend.getTime()/1000);
        	  if(pagestarttime>pageendtime){
        		var pagewrap=pagestarttime;
        		pagestarttime=pageendtime;
        		pageendtime=pagewrap;
        	  }
        	  else if(pagestarttime==pageendtime){
        		alert('输入的起止时间不能相同！');
        		return;
        	  }
        	}
        	for(var j=0;j<cat_content[cat].length;j++){
        		metricinfo = {
                    	  "metricnum":cat_content[cat].length,
                          "name": cat_content[cat][j],
                          "contain":"contain"  
                        }
                       var contain=metricinfo.contain+j;
                       $.getJSON(data_interface+"/get?method=getHostMetric&hostname=" + host + "&metric=" + cat_content[cat][j] + "&timeFrom=" + pagestarttime +  "&timeTo=" + pageendtime + "&format=json&jsoncallback=?",  
                          function(data){
                            var obj = {"cluster":data.clusterName,"name":data.metricName,"data":data.data,"contain":contain}
                            fillContain(obj,fill_flag++);
                            //multArray.push(obj);
                          }
                       );
                        //clustArray.push(metricinfo);
                       if(j%2==0) makeContain(metricinfo);         		
        	}
        }        
      function getContain(){
    	  arguements();
          $.getJSON(data_interface+"/get?method=getHostInfo&hostname="+host+"&format=json&jsoncallback=?",
            function(data){
        	  var metrics8089 = data.metrics;
              metlen=metrics8089.length;
              Number=metlen;
              
              var isExist;
              var htmlstr=$("#divcategory")[0].innerHTML;
              for(var i=0;i<metlen;i++){
            	  m_array = metrics8089[i].split("#");
            	  cat = m_array[0];
            	  isExist = 0;
            	  for(var j=0;j<category.length;j++){
            		  if(cat==category[j]){
            			  isExist = 1;
            			  cat_content[j].push(m_array[1]);
            		  }
            	  }
            	  if(isExist==0){
            		  category.push(cat);
            		  cat_content.push(new Array());
            		  cat_content[cat_content.length-1].push(m_array[1]);
            	  }
             }
     		 var dd4=document.getElementById("select4");
     		for(var j=0;j<category.length;j++){
     		   var opt=document.createElement('option');
       	       opt.innerHTML=category[j];
       	       dd4.appendChild(opt);
     		 }
              /******/
           	  getCategory();
              /******/
             //setTimeout("for(var i=0;i<multArray.length;i++)fillContain(multArray[i],i);", 1000);
           }
         );
    	  getdata();
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

      function makeContainer(object){
        flagnum++;
        var slt='';
        var htmlstr = $("#divcontainer")[0].innerHTML;
        var num = 4;
        var temp = 0;
        for(i=0;i<num/2;i++){
          if(i<=num/2-1){
        	  slt = slt + 
              "<div class='row' style='margin:0'><div id='" + object.container + (temp++) + "' class='span6' style='height: 300px;'></div>" +
              "<div id='" + object.container + (temp++) + "' class='span6' style='height: 300px;'></div></div>"
          }else{
        	  slt = slt + 
              "<div class='row' style='margin:0'><div id='" + object.container + (temp++) + "' class='span6' style='height:300px;'></div></div>"
          }
        }
        htmlstr = slt + "<hr><br>" + htmlstr;
        $("#divcontainer").html(htmlstr);
      }
       function getArgs(){
  	    var args = {};
  	    var match = null;
  	    var src = decodeURIComponent(location.search.substring(1));
  	    var args=src.split('=')[1];
  	    return args;
  	}
      function checkout(){
    	var src=getArgs();
    	arguements();
    	var starttime=document.getElementById('start').value;
    	var endtime=document.getElementById('end').value;
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
//    	var host=document.getElementById('select').value;
    	var metric=document.getElementById('select2').value;
    	var num=document.getElementById('select3').value;
    	var cookie="indexof="+cluster+"&"+host+"&"+metric+"&"+starttime+"&"+endtime;
    	document.cookie=cookie;
    	window.location.href="index.php/monitor/detail?src="+src;
    	var contain='divcon';
    	$.getJSON(data_interface+"/get?method=getHostMetric&hostname=" + host + "&metric=" + metric + "&timeFrom=" + starttime+  "&timeTo=" + endtime + "&format=json&jsoncallback=?",  
          function(data){
            var obj = {"hostName":data.hostName,"metricName":data.metricName,"data":data.data,"contain":contain}
            checkArray.push(obj);
          }
        );
        fillContain2(checkArray[0],0);
      }

      //导航下拉菜单
       function getdata(){
    	  arguements()
        	$.getJSON(data_interface+"/get?method=getHostInfo&hostname="+host+"&format=json&jsoncallback=?",
             function(data){
        		 var metrics=data.metrics;
        		 var dd2=document.getElementById("select2");
        		 metricslength=metrics.length;
        		 for(var i=0;i<metricslength;i++){
        		   var opt=document.createElement('option');
          	       opt.innerHTML=metrics[i];
          	       dd2.appendChild(opt);
        		 }
        		 $(".chzn-select").chosen();
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
    	  clusterlength=1;//----------注意这里--------alert(' clusterlength'+clusterlength+' flagnum'+flagnum);
        if(clusterlength == flagnum){
          //make graph,container has complete
            
          makeGraph();
          waitforMetric(); 
          return;
        }
        setTimeout("waitforcontainer()",30);
      }
      waitforcontainer();
      getContainers();
//      navigator();
      getContain();
      
      function makeGraph(){
        var pagestarttime=document.getElementById('pagestart0').value;
    	var pageendtime=document.getElementById('pageend0').value;
    	if(pagestarttime==''&&pageendtime==''){//不选择起止时间默认当前时间前一小时
    	  var pageenddate = new Date();
          pageendtime = parseInt(pageenddate.getTime()/1000);
          pagestarttime=pageendtime-3600;
        }
    	else if(pagestarttime&&pageendtime){
    	  var pagestart = new Date(pagestarttime.replace(/-/g, '/'));
    	  var pageend = new Date(pageendtime.replace(/-/g, '/'));
    	  pagestarttime=parseInt(pagestart.getTime()/1000);
    	  pageendtime=parseInt(pageend.getTime()/1000);
    	  if(pagestarttime>pageendtime){
    		var pagewrap=pagestarttime;
    		pagestarttime=pageendtime;
    		pageendtime=pagewrap;
    	  }
    	  else if(pagestarttime==pageendtime){
    		alert('输入的起止时间不能相同！');
    		return;
    	  }
    	}
      	var metricArray = new Array();
        metricArray.push(loadArray);
        metricArray.push(cpuArray);
        metricArray.push(memArray);
        metricArray.push(netArray);
        
        loadArrayRes.splice(0,loadArrayRes.length); 
      	cpuArrayRes.splice(0,cpuArrayRes.length);
      	memArrayRes.splice(0,memArrayRes.length);
      	netArrayRes.splice(0,netArrayRes.length);

        for(var x=0;x<hostArray.length;x++){//1
          var hostname = hostArray[x].name;//10.39.1.57
          for(var y=0;y<metricArray.length;y++){//4
            var container = hostArray[x].container+y;
            for(var z=0;z<metricArray[y].length;z++){
            	$.getJSON(data_interface+"/get?method=getHostMetric&hostname=" + src + "&metric=" + metricArray[y][z] + "&timeFrom=" + pagestarttime+  "&timeTo=" + pageendtime + "&format=json&jsoncallback=?",  
                function(data){
                  var obj = {"host":data.hostName,"name":data.metricName,"data":data.data,"container":container}
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
        for(var i=0;i<tempArray.length;i++){//1
          var containerid = "";
          for(var t=0;t<hostArray.length;t++){//1
            //if(hostArray[t].name==tempArray[i]){
              containerid = hostArray[t].container;
              break;
            //}
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
/*         	  var src=getArgs();
        	  if(src=='hadoop'){ */
        		  var containerid='contain';
/*         	  }
        	  else if(src=='master'){
        		containerid='contain';
        	  } */
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
        setTimeout("waitforMetric()",50);
      }
      function checkout_host(){
    	  hostArray.splice(0,1);
    	  flagnum = 0;
      	$("#divcontainer").html("");
		waitforcontainer();
        getContainers();
        //getContain();
      }