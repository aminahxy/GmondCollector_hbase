package com.sina.data.bigmonitor.web;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class FileUtils {
    public static void readToBuffer(StringBuffer buffer, String filePath) throws IOException {
        InputStream is = new FileInputStream(filePath);
        String line;
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        line = reader.readLine();
        while (line != null) {
            buffer.append(line);
            buffer.append("\n");
            line = reader.readLine();
        }
        reader.close();
        is.close();
    }

    public static String readFile(String filePath) throws IOException {
        StringBuffer sb = new StringBuffer();
        FileUtils.readToBuffer(sb, filePath);
        return sb.toString();
    }
    public static void main(String[] args) {
        FileUtils test=new FileUtils();
        String sb="";
        try {
             sb= test.readFile("doc/fileid");
        }
        catch (IOException e)
        {

        }
       // System.out.print(sb);
        String[] value=sb.split("\n");
        System.out.println(value.length);
        //System.out.println(value[21]);
        for(int i=0;i<30;i++)
        {
            System.out.println(value[i]);
        }

    }
}
