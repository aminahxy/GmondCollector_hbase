<%@ page import="java.util.List" %>
<%@ page import="com.sina.data.util.MySql" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%
    String register=request.getParameter("register");
    List<Object> res=MySql.GetFromDataBase("cluster_monitor","cluster_monitor_register",register);
    Object metric=res.get(1);
    Object host=res.get(2);
    Object Threshold=res.get(3);
    Object type=res.get(4);
    Object ex=res.get(5);
    List<Object> res_mail=MySql.GetFromDataBase("cluster_monitor","email_monitor_register",register);
    List<Object> res_sms=MySql.GetFromDataBase("cluster_monitor","sms_monitor_register",register);

   // List<Object> email_res=MySql.GetFromDataBase("cluster_monitor","email_monitor_register",register);
    Object send_people=res_mail.get(2);
    Object rev_list=res_mail.get(1);
    Object theme=res_mail.get(3);
    Object content=res_mail.get(4);
   // out.println(content);
    Object in_time=res_mail.get(5);
    Object last_time=res_mail.get(6);
    Object exten=res_mail.get(7);

    Object sms_rev=res_sms.get(1);
    Object sms_content=res_sms.get(3);
    Object sms_in_time=res_sms.get(4);
    Object sms_last_time=res_sms.get(5);
    Object sms_ext=res_sms.get(6);



   /* for(Object a:res)
    {
        String test=a.toString();
        System.out.println(test);
    }
    */




%>

<form class="form-horizontal" role="form">
    <legend>Metric Setting</legend>
    <div class="form-group">
        <label for="firstname" class="col-sm-2 control-label">Register Name</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="firstname"
                   placeholder=<%=register%> readonly="">
        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Metric Name</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=metric%> readonly="">

        </div>
    </div>

    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Host List</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=host%>
                   readonly="">

        </div>
    </div>

    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Threshold</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=Threshold%> readonly="">

        </div>
    </div>

    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Judge Type</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=type%> readonly="">

        </div>
    </div>

    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Extends</label>
        <div class="col-sm-7">
            <textarea class="form-control" rows="3" id="lastname" placeholder=<%=ex%> readonly=""></textarea>


        </div>
    </div>
    <legend>Email</legend>
    <div class="control-group">

    </div>


    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label"></label>
        <div class="col-sm-7">
            <input class="uniform_on" type="checkbox" id="optionsCheckbox" checked="1" value="1" disabled="false">Enable

        </div>
    </div>




    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Sent People</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=send_people%> readonly="">

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Recieve List</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=rev_list%> readonly="">

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Theme</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=theme%> readonly="">

        </div>
    </div>

    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Content</label>
        <div class="col-sm-7">
            <textarea class="form-control" rows="3" id="lastname" placeholder="<%=content%>"  readonly=""></textarea>

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Interval time</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=in_time%>  readonly="">

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Last Time</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=last_time%>  readonly="">

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Extends</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=exten%>  readonly="">

        </div>
    </div>


    <legend>SMS</legend>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label"></label>
        <div class="col-sm-7">
            <input class="uniform_on" type="checkbox" id="optionsCheckbox" checked="1" value="1" disabled="false">Enable

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Recieve List</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=sms_rev%> readonly="">

        </div>
    </div>

    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Content</label>
        <div class="col-sm-7">
            <textarea class="form-control" rows="3" id="lastname" placeholder="<%=sms_content%>" readonly=""></textarea>

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Interval time</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=sms_in_time%> readonly="">

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Last Time</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=sms_last_time%> readonly="">

        </div>
    </div>
    <div class="form-group">
        <label for="lastname" class="col-sm-2 control-label">Extends</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="lastname"
                   placeholder=<%=sms_ext%> readonly="">

        </div>
    </div>

</form>

</body>
</html>

