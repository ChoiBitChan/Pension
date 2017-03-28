<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%
	request.setCharacterEncoding("euc-kr");

	String realFolder = "";
	String name = "";
	String title = "";
	String content = "";
	
	String saveFolder = "C:/saveImage";
	String serverFolder = "../saveImage";
	String encType = "euc-kr";
	int maxSize = 5*1024*1024;
	
	ServletContext context = getServletContext();
	
//	realFolder = context.getRealPath(saveFolder);
	realFolder = saveFolder;

try
{
   MultipartRequest multi = null;
  
   multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
   
 	name = multi.getParameter("name");
 	title = multi.getParameter("title");
 	content = multi.getParameter("content");
   
   Enumeration files = multi.getFileNames();
   int zoom=2;

   while(files.hasMoreElements()){
    
      String name1 = (String)files.nextElement();
     
      String filename = multi.getFilesystemName(name1);
      
      String orgFileNameView= saveFolder+"/"+filename;
      String orgFileName = saveFolder+"/"+filename;
      
      System.out.print(orgFileName);
      
      String thumbFileName= realFolder+"//small"+filename;
      
      photoGallery.PhotoGallery.createImage(orgFileName, thumbFileName, zoom);
%> 
<html>
	<head>
		<title>진한 향기와 천국같은 휴식공간</title>
	<style>
<!--
.bs3 {border-style:dotted;}
-->
</style>
	</head>
	<body>
		<img src="../project_img/img/photogelleryhead.gif"><p> 
		<div align="center"><img src="../project_img/img/photogallery.gif" ></div>
	<hr color="gray" class="bs3" width="800">
		<div align="center"><b><font size="4" face="휴먼편지체"> 내/용/보/기</font> </b> </div>
	<hr color="gray" class="bs3" width="800">
	<center><table border="0" width="800">
		<tr>
			<td><font size="6"><%=title%></font></td>	<td align="right"><%=name%></td> 
		</tr>	
	</table></center>
	<hr color="gray" class="bs3" width="800">	
						<center><img src="<%=orgFileNameView%>" border="0"></center><p>
						<center><%=content%></center>
	
	<hr color="gray" class="bs3" width="800">
		<center>
			<a href="PhotoGalleryUpdate.jsp"><img src="../project_img/img/update.jpg" border="0"></a>&nbsp;
			<a href="PhotoGalleryMain.jsp"><img src="../project_img/img/ok1.jpg" border="0"></a>&nbsp;
			<a href="PhotoGalleryMain.jsp"><img src="../project_img/img/index1.jpg" border="0"></a>
		</center>
	</body>
</html>

<%
      }
}catch(IOException ioe){
 ioe.printStackTrace();
}catch(Exception ex){
 ex.printStackTrace();
}
%>

