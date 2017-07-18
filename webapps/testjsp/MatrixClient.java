import com.baidu.inf.matrix.master.rpc.common.ThriftUGI;
import com.baidu.inf.matrix.master.rpc.masterclientproto.*;
import com.baidu.inf.matrix.resourcemanager.rpc.thrift.proto.client.ResourceManagerException;
import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TFramedTransport;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.thrift.transport.TTransportException;
/**
 * Created by weizhonghui on 2015/9/23.
 */
public class MatrixClient {
    public static void main(String [] args ) {

/*        String node = args[0];
        String matrix_server = null;
        String user = null;
        String token = null;
        String servicename = null;
        String tag = null;
        int port = 28526;
        String [] nodeInfo = node.split(":");
        if ( nodeInfo.length == 5 ) {
            matrix_server = nodeInfo[0];
            port = 28526;
            user = nodeInfo[1];
            token = nodeInfo[2];
            servicename = nodeInfo[3];
            tag = nodeInfo[4];

        } else if ( nodeInfo.length == 6 ) {
            matrix_server = nodeInfo[0];
            port = Integer.parseInt(nodeInfo[1]);
            user = nodeInfo[2];
            token = nodeInfo[3];
            servicename = nodeInfo[4];
            tag = nodeInfo[5];
        } else {
            System.out.println("Input content is not expected!");
        }

        TSocket socket = new TSocket(matrix_server, port);
        TTransport transport = new TFramedTransport(socket);
        try {
            transport.open();
        } catch (TTransportException e) {
            e.printStackTrace();
        }
        TProtocol tprotocol = new TBinaryProtocol(transport);

        //MasterClientProtocol.Client matrixClient =  new MasterClientProtocol.Client.Factory().getClient(tprotocol);
        MasterClientProtocol.Client matrixClient =  new MasterClientProtocol.Client(tprotocol);

        ThriftUGI ugi = new ThriftUGI(user,token);
        ugi.setUserName(user);
        ugi.setToken(token);

        List<ThriftInstanceDetail> allInstanceInfo;
        allInstanceInfo = null;

        try {
            allInstanceInfo = matrixClient.getInstanceDetailList(ugi,servicename);
        } catch (TException e) {
            e.printStackTrace();
        }


        ExclusionStrategy myExclusionStrategy = new ExclusionStrategy() {


            @Override
            public boolean shouldSkipClass(Class<?> aClass) {
                return false;
            }

            @Override
            public boolean shouldSkipField(FieldAttributes fieldAttributes) {
                return fieldAttributes.getName().startsWith("_");
            }
        };
//        String gson_test="hello";
//       Gson test=new Gson();
//        String a=test.toJson(gson_test);

//        test.fromJson()
//        GsonBuilder test=new GsonBuilder();
//        test.toString()
//        test.

*/

//        GsonBuilder gb = new GsonBuilder().setExclusionStrategies(myExclusionStrategy);
//


//        for ( ThriftInstanceDetail instanceInfo : allInstanceInfo) {
            /*System.out.println(instanceInfo.getHostIp());
            System.out.println(instanceInfo.getHostName());
            System.out.println(instanceInfo.getOffset());
            System.out.println(instanceInfo.getState());
            System.out.println(instanceInfo.getError());*/

            //System.out.println(gb.create().toJson(instanceInfo.getMeta().getResourceRequirement().getCpu().getNormalizedCore(), ThriftResourceItem.class));
//            System.out.println(gb.create().toJson(instanceInfo.getMeta(), ThriftInstanceMeta.class));


//        GsonBuilder gb = new GsonBuilder();


        /*String host = request.getParameter("host");
        String metajson = request.getParameter("metajson");
        String matrix_service = request.getParameter("matrix_service");
        String user = request.getParameter("user");
        String token = request.getParameter("token");
        String op=request.getParameter("op");*/
//        String host="10.209.96.24";
//        String file=null;
        String matrix_service="nmg01.matrix.master2.noah.baidu.com";
//        String serviceName="on_normandy_agent";
        String user="normandy-on-agent";
        String token="normandy-on-agent";
//        String op="delete";
//        Gson testgson=new Gson();
//        StringBuffer sb = new StringBuffer();
       /* try{
            FileUtils.readToBuffer(sb,"/home/tentacles/tentacles-v1.0/webapp/metajson");}
        catch (IOException e)
        {
          e.printStackTrace();
        }*/

        matrix_adminop clientop=new matrix_adminop();

      try{
        clientop.matrix_admin_open(matrix_service);
       }
       catch ( TTransportException e)
       {
           e.printStackTrace();
       }
        String host="10.74.218.17";
        String tags="khan-lsp_phy";
        List<String> test=new ArrayList<>();
        test.add(tags);
//        List<String> test="[{khan-mix_phy}]";
        System.out.println(test);
//        List <String> tags= "["khan-mix_phy"];
//        matrix_addtag(String user,String token,String host,List<String> tags)
       try {
           clientop.matrix_updatetag(user, token, host, test);
       }catch (ResourceManagerException e)
       {
           e.printStackTrace();
       }
        catch (org.apache.thrift.TException ee)
        {
            ee.printStackTrace();
        }
      //System.out.println(sb);

//        ThriftInstanceMeta metatest=testgson.fromJson(sb.toString(), ThriftInstanceMeta.class);
       //ystem.out.println(metatest);

//        int offset=102099624;
//        clientop.matrix_delete();
//        clientop.matrix_delete(user,token,serviceName,offset);
//        try{
//        clientop.matrix_add(user,token,serviceName,offset,metatest);}
//        catch (TException e)
//        {
//            e.printStackTrace();
//        }







//        hz01.master.matrix.baidu.com:normandy-mix:normandy-mix:pegasus-fcr-normandy-agent.NJ01-PEGASUS.hz01:fcr_phy

//        get_host get_host=new get_host();
//        System.out.println(get_host.get_host_op(host));
//        System.out.println(get_host.get_host_op(host).toString().replace(".",""));
//        System.out.println(metatest);




//        clientop.matrix_close();
        /*clientop.matrix_delete(user,token,serv,offset);
        clientop.matrix_update(user,token,sename,offset.meta);
        clientop.matrix_reset(user,token,sename,offset,meta);*/


    }
}

