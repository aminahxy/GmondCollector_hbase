$(".chzn-select").chosen();
      $("#datediv").datepicker()
                      .on('changeDate', function(ev){
                        startDate = new Date(ev.date);
                        $('#date01').text($('#datediv').data('date'));
                        $('#datediv').datepicker('hide');
                      });
      
      $("#editForm").validate();
      
      jQuery.validator.addMethod("registerName", function(value) {
    	  var re=new RegExp("[\u4e00-\u9fa5]+");
          return !re.test(value);
  	},"Please do not input Chinese");

      jQuery.validator.addMethod("hostList", function(value) {
          var re=new RegExp("^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$");
          return re.test(value);
  	},"Please input a valid ip");

      jQuery.validator.addMethod("emailReceiveList", function(value) {
    	  var result = true;
    	  ch = new Array;
          ch = value.split(",");
          var re=new RegExp("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$");
          for(i=0;i<ch.length;i++){
			if(!re.test(ch[i]))
				result = false;
          }
          return result;
  	},"Please input valid email addresses with ',' between each one");

      jQuery.validator.addMethod("smsReceiveList", function(value) {
    	  var result = true;
    	  ch = new Array;
          ch = value.split(",");
          var re=new RegExp("^1[3|5|8][0-9]{9}");
          for(i=0;i<ch.length;i++){
			if(!re.test(ch[i]))
				result = false;
          }
          return result;
  	},"Please input valid mobile phone numbers with ',' between each one");

      function enableEmail(obj){
          var ched = obj.getAttribute("checked");
          if(ched==1){
              obj.setAttribute("checked",0);
              obj.setAttribute("value",0);
          }
          else{
        	  obj.setAttribute("checked",1);
        	  obj.setAttribute("value",1);
          }
          excute_enable("email_enable");
      }
      function enableSMS(obj){
          var ched = obj.getAttribute("checked");
          if(ched==1){
              obj.setAttribute("checked",0);
              obj.setAttribute("value",0);
          }
          else{
        	  obj.setAttribute("checked",1);
        	  obj.setAttribute("value",1);
          }
          excute_enable("sms_enable");
      }
	  function excute_enable(method){
		  var plate = document.getElementById(method);
		  var ched = plate.getAttribute("checked");
		  if(method=="email_enable"){
			  var z = document.getElementById("email_sent_people");
			  var y = document.getElementById("email_receive_list");
			  var x = document.getElementById("email_theme");
			  var w = document.getElementById("email_content");
			  var v = document.getElementById("email_interval_time");
			  var u = document.getElementById("email_last_time");
			  var t = document.getElementById("email_extends");
			  if(ched==1){
					z.removeAttribute("readonly","");
					y.removeAttribute("readonly","");
					x.removeAttribute("readonly","");
					v.removeAttribute("readonly","");
					u.removeAttribute("readonly","");
					w.removeAttribute("readonly","");
					t.removeAttribute("readonly","");
					z.setAttribute("class","required email");
					y.setAttribute("class","required emailReceiveList");
					x.setAttribute("class","required");
					v.setAttribute("class","required");
					u.setAttribute("class","required number");
					w.setAttribute("class","required");
					t.setAttribute("class","required");
					
				  }
				  else{
					  z.setAttribute("readonly","");
						y.setAttribute("readonly","");
						x.setAttribute("readonly","");
						v.setAttribute("readonly","");
						u.setAttribute("readonly","");
						w.setAttribute("readonly","");
						t.setAttribute("readonly","");
						z.removeAttribute("class","");
						y.removeAttribute("class","");
						x.removeAttribute("class","");
						v.removeAttribute("class","");
						u.removeAttribute("class","");
						w.removeAttribute("class","");
						t.removeAttribute("class","");
				  }
		  }
		  else if(method=="sms_enable"){
			  var z = document.getElementById("sms_receive_list");
			  var y = document.getElementById("sms_content");
			  var x = document.getElementById("sms_interval_time");
			  var w = document.getElementById("sms_last_time");
			  var v = document.getElementById("sms_extends");
			  if(ched==1){
					z.removeAttribute("readonly","");
					y.removeAttribute("readonly","");
					x.removeAttribute("readonly","");
					w.removeAttribute("readonly","");
					v.removeAttribute("readonly","");
					z.setAttribute("class","required smsReceiveList");
					y.setAttribute("class","required");
					x.setAttribute("class","required number");
					w.setAttribute("class","required number");
					v.setAttribute("class","required");
				  }
				  else{
					  z.setAttribute("readonly","");
						y.setAttribute("readonly","");
						x.setAttribute("readonly","");
						w.setAttribute("readonly","");
						v.setAttribute("readonly","");
						z.removeAttribute("class","");
						y.removeAttribute("class","");
						x.removeAttribute("class","");
						w.removeAttribute("class","");
						v.removeAttribute("class","");
				  }
		  }
		  
		  
      }
      
      excute_enable("email_enable");
      excute_enable("sms_enable");

      function cancel(){
    	  window.location.href="http://<?= base_url()?>/index.php/metriclist";
      }