<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="photoGallery.DBB" %>
<%@ page import="photoGallery.DB" %>

<% 
	request.setCharacterEncoding("euc-kr");

	String realFolder = "";
	String name = "";
	String title = "";
	String content = "";
	
	String saveFolder = "C:/project/Project/WebContent/saveImage";
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
 	
	DB member = new DB();
	member.setName(multi.getParameter("name"));
	member.setPasswd(multi.getParameter("passwd"));
	member.setTitle(multi.getParameter("title"));
	member.setEmail(multi.getParameter("email"));
	member.setContent(multi.getParameter("content"));
	member.setHomepage(multi.getParameter("homepage"));
	member.setUploadfile(multi.getFile("uploadfile").getPath()); 
    member.setReg_date(new Timestamp(System.currentTimeMillis()) );
    
    DBB manager = DBB.getInstance();
    manager.insertMember(member);
   
   Enumeration files = multi.getFileNames();
   int zoom=1;
 
   while(files.hasMoreElements()){
    
      String name1 = (String)files.nextElement();
     
      String filename = multi.getFilesystemName(name1);
      
   
      String orgFileName= realFolder+"\\"+filename;
      
     
      String thumbFileName= realFolder+"\\small"+filename;
      
      
      photoGallery.PhotoGallery.createImage(orgFileName, thumbFileName, zoom);
%> 

<html>
	<head>
		<title>진한 향기와 천국같은 휴식공간</title>

	</head>
	
	<body>

		<img src="C:\project_img\img\photogelleryhead.gif"><p> 
		<div align="center"><img src="C:\project_img\img\photogallery.gif" ></div>
	<hr color="gray" width="800">
		<div align="center"><b><font size="4" face="휴먼편지체"> 내/용/보/기</font> </b> </div>
	<hr color="gray" width="800">
	<center><table border="0" width="800">
		<tr>
			<td><font size="6"><%=title%></font></td>	<td align="right"><%=name%></td> 
		</tr>	
	</table></center>
	<hr color="gray" width="800">	
						<center><img src="<%=orgFileName%>" border="0"></center><p>
						<center><%=content%></center>
	
	<hr color="gray" width="800">	
		<center>
			<a href="Update.jsp"><img src="C:\project_img\img\update.jpg" border="0"></a>&nbsp;
			<a href="PhotoGalleryMain.jsp"><img src="C:\project_img\img\확인.jpg" border="0"></a>&nbsp;
			<a href="Delete.jsp"><img src="C:\project_img\img\삭제.jpg" border="0"></a>
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
