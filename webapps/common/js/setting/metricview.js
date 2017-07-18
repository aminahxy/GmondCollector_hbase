$(".chzn-select").chosen();
      $("#datediv").datepicker()
                      .on('changeDate', function(ev){
                        startDate = new Date(ev.date);
                        $('#date01').text($('#datediv').data('date'));
                        $('#datediv').datepicker('hide');
                      });
      function back(){
    	  window.location.href="<?= base_url()?>/index.php/<?= SETTING_MODULE_NAME ?>/metriclist";
      }