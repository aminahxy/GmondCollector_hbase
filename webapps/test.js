 var showAlert = function(msg){
            jAlert(msg, "提示！");
        }
        window.alert=showAlert;

        $.alerts={
            verticalOffset:-75,horizontalOffset:0,repositionOnResize:true,overlayOpacity:.01,overlayColor:'#FFF',draggable:true,okButton:' OK ',cancelButton:' Cancel ',dialogClass:null,alert:function(message,title,callback){
                if(title==null)title='Alert';
                $.alerts._show(title,message,null,'alert',function(result){
                    if(callback)callback(result)
                })
            }
            ,_show:function(title,msg,value,type,callback){
                $.alerts._hide();
                $.alerts._overlay('show');
                $("BODY").append('<div id="popup_container">'+'<h1 id="popup_title"></h1>'+'<div id="popup_content">'+'<div id="popup_message"></div>'+'</div>'+'</div>');
                if($.alerts.dialogClass)$("#popup_container").addClass($.alerts.dialogClass);
                var pos=($.browser.msie&&parseInt($.browser.version)<=6)?'absolute':'fixed';
                $("#popup_container").css({
                    position:pos,zIndex:99999,padding:0,margin:0
                });
                $("#popup_title").text(title);
                $("#popup_content").addClass(type);
                $("#popup_message").text(msg);
                $("#popup_message").html($("#popup_message").text().replace(/\n/g,'<br />'));
                $("#popup_container").css({
                    minWidth:$("#popup_container").outerWidth(),maxWidth:$("#popup_container").outerWidth()
                });
                $.alerts._reposition();
                $.alerts._maintainPosition(true);
                switch(type){
                    case'alert':$("#popup_message").after('<div id="popup_panel"><input type="button" value="'+$.alerts.okButton+'" id="popup_ok" /></div>');
                        $("#popup_ok").click(function(){
                            $.alerts._hide();
                            callback(true)
                        });
                        $("#popup_ok").focus().keypress(function(e){
                            if(e.keyCode==13||e.keyCode==27)$("#popup_ok").trigger('click')
                        });
                        break
                };
                if($.alerts.draggable){
                    try{
                        $("#popup_container").draggable({
                            handle:$("#popup_title")
                        });
                        $("#popup_title").css({
                            cursor:'move'
                        })
                    }
                    catch(e){}
                }
            }
            ,_hide:function(){
                $("#popup_container").remove();
                $.alerts._overlay('hide');
                $.alerts._maintainPosition(false)
            }
            ,_overlay:function(status){
                switch(status){
                    case'show':$.alerts._overlay('hide');
                        $("BODY").append('<div id="popup_overlay"></div>');
                        $("#popup_overlay").css({
                            position:'absolute',zIndex:99998,top:'0px',left:'0px',width:'100%',height:$(document).height(),background:$.alerts.overlayColor,opacity:$.alerts.overlayOpacity
                        });
                        break;
                    case'hide':$("#popup_overlay").remove();
                        break
                }
            }
            ,_reposition:function(){
                var top=(($(window).height()/ 2) - ($("#popup_container").outerHeight() /2))+$.alerts.verticalOffset;
                var left=(($(window).width()/ 2) - ($("#popup_container").outerWidth() /2))+$.alerts.horizontalOffset;
                if(top<0)top=0;
                if(left<0)left=0;
                if($.browser.msie&&parseInt($.browser.version)<=6)top=top+$(window).scrollTop();
                $("#popup_container").css({
                    top:top+'px',left:left+'px'
                });
                $("#popup_overlay").height($(document).height())
            }
            ,_maintainPosition:function(status){
                if($.alerts.repositionOnResize){
                    switch(status){
                        case true:$(window).bind('resize',function(){
                            $.alerts._reposition()
                        });
                            break;
                        case false:$(window).unbind('resize');
                            break
                    }
                }
            }
        };
        jAlert=function(message,title,callback){
            $.alerts.alert(message,title,callback)
        }

        $(function(){alert("hello word！")})
