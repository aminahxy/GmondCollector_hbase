$(".chzn-select").chosen();
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

var loadArray = ["load_one","cpu_num","proc_run"];
var cpuArray = ["cpu_user","cpu_system","cpu_wio"];
var memArray = ["mem_total","mem_cached","mem_buffers","mem_free","mem_shared"];
var netArray = ["bytes_in","bytes_out","pkts_in","pkts_out"];
var loadflag = 0;
var cpuflag = 0;
var memflag = 0;
var netflag = 0;
var loadArrayRes = new Array();
var cpuArrayRes = new Array();
var memArrayRes = new Array();
var netArrayRes = new Array();


/**
 * 从接口获得集群的名字
 */
function getContainers(){
	$.getJSON(data_interface+"/get?method=getClusters&format=json&jsoncallback=?",function(data){
	    var cluster = data.names;
	    clusterlength = cluster.length;
	    for(var i=0;i<clusterlength;i++){
	    	clusterinfo = {
    			"name": cluster[i],
    			"metricnum":4,
    			"container":"container" + i 
	    	}
	        clusterArray.push(clusterinfo);
	        makeContainer(clusterinfo);
	    }
	});
}
/**
 * 每个集群在页面上的显示
 * @param object
 */
function makeContainer(object){
    flagnum++;
    var htmlstr = $("#divcontainer")[0].innerHTML+'<div id="accordion2" class="accordion"><div class="accordion-group">';
    htmlstr += '<div class="accordion-heading" style="position:relative;background-color:#EEE"><a class="accordion-toggle" href="#'+object.name+'" data-parent="#accordion2" data-toggle="collapse"><h4>'+object.name+'</h4></a>';
    htmlstr += '<a style="float:right;position:absolute;top:9px;left:1000px" href="index.php/monitor/select?src='+object.name+'"><h4>Detail...</h4></a></div>';
    if(object.name=='hadoop') htmlstr += '<div id="'+object.name+'" class="accordion-body collapse in"><div class="accordion-inner">';
    else htmlstr += '<div id="'+object.name+'" class="accordion-body collapse"><div class="accordion-inner">';
    
    var num = object.metricnum;
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
    htmlstr = htmlstr + '</div></div></div></div>';
    $("#divcontainer").html(htmlstr);
}

Array.prototype.contains = function (element) {    
	for (var i = 0; i < this.length; i++) {    
		if (this[i] == element) {
			return true;    
		}    
    }    
    return false;    
}  
/**
 * 判断所有集群的div是否已绘制完成
 * 绘制完成后，开始加载数据
 */
function waitforcontainer(){
    if(clusterlength == flagnum){
	  makeGraph();
	  waitforMetric(); 
	  return;
	}
    setTimeout("waitforcontainer()",10);
}
/**
 * 从接口加载数据
 */
function makeGraph(){
	var metricArray = new Array();
    metricArray.push(loadArray);
    metricArray.push(cpuArray);
    metricArray.push(memArray);
    metricArray.push(netArray);
    var startdate = new Date();
    var startmills = parseInt(startdate.getTime()/1000);
    for(var x=0;x<clusterArray.length;x++){//集群数量 x=4
    	var clustername = clusterArray[x].name;
    	for(var y=0;y<metricArray.length;y++){//每个集群内图表的数量 y=4
    		var container = clusterArray[x].container+y;//指标线应在哪张图表
    		for(var z=0;z<metricArray[y].length;z++){//每场表内指标的数量
    			$.getJSON(data_interface+"/get?method=getClusterMetric&clustername=" + clustername + "&metric=" + metricArray[y][z] + "&timeFrom=" + (startmills - 3600)+  "&timeTo=" + startmills + "&format=json&jsoncallback=?",  function(data){
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
    			});
    		}
    	}
    }
}
/**
 * 判断metric数据是否已全部加载
 */
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
/**
 * 处理数据格式，用于绘制highcharts图表
 * @param resArray 数据
 * @param offset 集群编号
 */
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
    		for(var i = 0; i < tempArray.length; i++){
    			if(tempArray[i] == resArray[a].cluster){
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
/**
 * init
 */
waitforcontainer();
getContainers();
  