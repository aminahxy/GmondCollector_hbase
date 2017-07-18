<%@ page import="java.util.List" %>
<%@ page import="com.sina.data.util.MySql" %>
<%@ page
        contentType="text/html; charset=utf-8"
%>
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


<form action="./1.jsp"  class="form-horizontal" role="form">

    <legend>Metric Setting</legend>
    <div class="form-group">
        <label for="firstname" class="col-sm-2 control-label">Register Name</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="firstname"
                  >
        </div>
    </div>
    <div class="form-group">
        <label for="metric" class="col-sm-2 control-label">Metric Name</label>
        <div class="col-sm-7">
            <input name="metric" class="form-control" id="metric"
                   >

        </div>
    </div>

    <div class="form-group">
        <label for="host" class="col-sm-2 control-label">Host List</label>
        <div class="col-sm-7">
            <input name="host" class="form-control" id="host"
                   >

        </div>
    </div>

    <div class="form-group">
        <label for="threshold" class="col-sm-2 control-label">Threshold</label>
        <div class="col-sm-7">
            <input name="threshold" class="form-control" id="threshold"
                   >

        </div>
    </div>

    <div class="form-group">
        <label for="metric_judge_type" class="col-sm-2 control-label">Judge Type</label>
        <div class="col-sm-7">
            <select id="metric_judge_type"  class="form-control"  name="metric_judge_type" class="chzn-select required" >
                <option>le</option>
                <option>lt</option>
                <option>ge</option>
                <option>eq</option>
                <option>ne</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="ex" class="col-sm-2 control-label">Extends</label>
        <div class="col-sm-7">
            <textarea name="ex" class="form-control" rows="3" id="ex" ></textarea>


        </div>
    </div>
    <legend>Email</legend>
    <div class="control-group">

    </div>






    <div class="form-group">
        <label  class="col-sm-2 control-label">Sent People</label>
        <div class="col-sm-7">
            <input name="email_sent_people" class="form-control" id="email_sent_people"
            value="hadoop_admin@staff.sina.com.cn">

        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Recieve List</label>
        <div class="col-sm-7">
            <input name="email_receive_list" class="form-control" id="email_receive_list"
                   >

        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Theme</label>
        <div class="col-sm-7">
            <input name="email_theme" class="form-control" id="email_theme"
                 value="Hadoop Cluster Warning!"  >

        </div>
    </div>

    <div class="form-group">
        <!--label class="control-label" for="textarea2">Content</label-->
        <label  class="col-sm-2 control-label">Content</label>

        <div class="col-sm-7">
            <textarea name="email_content"  class="form-control"   id="email_content" rows="3" >"The cunrrent value of metric(%metric%) is %current_value%,which exceeded the threshold(%threshold%)"</textarea>


        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Interval time</label>
        <div class="col-sm-7">
            <input name="email_interval_time" class="form-control" id="email_interval_time"
                    >

        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Last Time</label>
        <div class="col-sm-7">
            <input name="email_last_time" class="form-control" id="email_last_time"
                  >

        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">extends</label>
        <div class="col-sm-7">
            <input name=email" class="form-control" id="email"
                  >

        </div>
        <div class="col-sm-7">


        </div>
    </div>




    <legend>SMS</legend>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Recieve List</label>
        <div class="col-sm-7">
            <input name="sms_receive_list" class="form-control" id="sms_receive_list"
                >

        </div>
    </div>

    <div class="form-group">
        <label  class="col-sm-2 control-label">Content</label>
        <div class="col-sm-7">
            <textarea name="sms_content" class="form-control" rows="3" id="sms_content" >"The cunrrent value of metric(%metric%) is %current_value%,which exceeded the threshold(%threshold%)" </textarea>

        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Interval time</label>
        <div class="col-sm-7">
            <input name="sms_interval_time" class="form-control" id="sms_interval_time"
                    >

        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Last Time</label>
        <div class="col-sm-7">
            <input name="sms_last_time"  class="form-control" id="sms_last_time"
                   >

        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">Extends</label>
        <div class="col-sm-7">
            <input name="sms_extends" class="form-control" id="sms_extends"
                    >

        </div>
        <div class="col-sm-7">


        </div>
    </div>

    <div class="form-group">
        <label  class="col-sm-2 control-label"></label>
        <div class="col-sm-7">

            <button   class="btn btn-primary btn-large" type="submit">保存</button>
            <button   class="btn btn-large btn-danger" type="button" onClick="quit()">退出</button>
        </div>
        <div class="col-sm-7">


        </div>
    </div>
</form>

</body>
</html>

