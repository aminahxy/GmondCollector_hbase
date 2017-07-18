package com.sina.data.DataProducer;
import com.google.gson.Gson;
import com.sina.data.bigmonitor.web.HbaseClient.HbaseClient;

import java.util.List;

/**
 *
 */
public class getDataTest {
    public static String get(String[] args){
        //List res = new HbaseClient().GetRangeList()
        //List list = new HbaseClient().GetRangeList(args[0], args[1], args[2], args[3], args[4]);
        List list = HbaseClient.getHc().GetRangeList(args[0], args[1], args[2], args[3], args[4]);
	Gson gson = new Gson();
        //Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String res = gson.toJson(list);
        //res = res.replaceAll("\"","");
        return res;
    }
    public static void main(String[] args)
    {
        System.out.println(getDataTest.get(args));
    }
}
