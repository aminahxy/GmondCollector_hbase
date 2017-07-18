package com.sina.data.DataProducer;

import java.io.*;
import java.net.*;



/**
 */
public class EasyGet {



    public String getUrl(String urlString) {
        HttpURLConnection huc = null;
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader in = null;
        StringBuffer sb = new StringBuffer();
        try {
            URL url = new URL(urlString);
            huc = (HttpURLConnection)url.openConnection();
            is = huc.getInputStream();
            isr = new InputStreamReader(is);
            in = new BufferedReader(isr);
            String line = null;
            while(((line = in.readLine()) != null)) {
                if(line.length()==0)
                    continue;
                sb.append(line + "\n");


            }



        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                is.close();
                isr.close();
                in.close();
                huc.disconnect();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return sb.toString();

    }


    public static void main(String [] args ) {
        String urlString = "http://rm1.hadoop.data.sina.com.cn:9008/jmx";
        String res = new EasyGet().getUrl(urlString);
        System.out.println(res);

    }
}
