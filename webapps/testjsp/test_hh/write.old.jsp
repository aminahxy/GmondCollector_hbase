<%@ page
import="java.io.File"
import="java.io.FileWriter"
import="java.io.BufferedWriter"
import="java.io.IOException"
%>

<%
String data = request.getParameter("txt");
//String data = " This content will append to the end of the file";
try{
    File file =new File("/home/tentacles/tentacles-v1.0/webapp/test/test.txt");
    if(!file.exists()){
        file.createNewFile();
    }
    //FileWriter fileWritter = new FileWriter(file.getName(),true);
    FileWriter fileWritter = new FileWriter(file);
    BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
    bufferWritter.write(data);
    bufferWritter.close();
}catch(IOException e){
    e.printStackTrace();
}
%>
