<%@ page import="com.sina.data.bigmonitor.web.ClusterWithHost" %>
<%@ page
        contentType="text/html; charset=utf-8"
        import="java.util.*"
        import="com.sina.data.bigmonitor.web.ClusterWithHost.*"
%>

<!DOCTYPE html>
<html>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>DataTables example - Zero configuration</title>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
<style type="text/css" class="init">
</style>
<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.3.js">
</script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js">
</script>
<script type="text/javascript" class="init">


    $(document).ready(function() {
        $('#example').DataTable();
    } );
</script>

<form action="./2.jsp" method="get">
    <input type="text" name="q" placeholder="Search . . ." autocomplete="off"> <button>Search</button>
    <%


        ClusterWithHost cwh=new ClusterWithHost();
        List<ClusterHostBean> hosts= cwh.getClusterHostBeans();
       // boolean checkedB = false;
%>
    <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th>host</th>
        </tr>
        </thead>
        <tbody>
        <%

            for(int i=0;i<100;i++)
            {
        %><tr>
            <td>
                <input type="checkbox" name="hosts"  value="<%=i%>"><%=i%>
            </td>
        </tr> <%
            }
        %>
        </tbody>
    </table>
</form>