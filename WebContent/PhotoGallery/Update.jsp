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
   int zoom=2;
 
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

	<script language="javascript" src="script.js">

	</script>
</head>

<body>
	<img src="C:\project_img\img\photogelleryhead.gif"><p> 
	<div align="center"><img src="C:\project_img\img\photogallery.gif" align="middle"></div>
	
<form name="regform" method="post" action="Pro.jsp" enctype="multipart/form-data" onsubmit="return checIt()">

			<center><table class="ba3" cellpadding="10" cellspacing="0" border="1" width="800" frame="hsides">
				<tr>
					<td colspan="2"><center><b><font size="4" face="휴먼편지체"> 수/정/하/기</font></b></center></td>
				</tr>
			</table>
			<center><table width="800" frame="below" rules="none" cellpadding="3" cellspacing="10" border="1">	
				<tr>
 					<td align=right width="150"><font size="4" face="휴먼편지체">Name</font></td>
					<td align=left><input type="text" name="name" size="20" maxlength="20" value="<%=multi.getParameter("name")%>"></td>
				</tr>

				<tr>
					<td align=right><font size="4" face="휴먼편지체">Password</font></td>
					<td align=left><input type="password" name="passwd" size=21 maxlength="20" value="<%=multi.getParameter("passwd")%>"></td>
				</tr>
   
				<tr>
					<td align=right><font size="4" face="휴먼편지체">E-mail</font></td>
					<td align=left><input name="email" type="text" size="40" maxlength="64" value="<%=multi.getParameter("email")%>"></td>
				</tr>

				<tr>
					<td align=right><font size="4" face="휴먼편지체">Homepage</font></td>
					<td align=left><input name="homepage" type="text" size="40" maxlength="64" value="<%=multi.getParameter("homepage")%>"></td>
				</tr>
				
				<tr>
					<td align=right><font size="4" face="휴먼편지체">Title</font></td>
					<td align=left><input name="title" type="text" size="60" maxlength="64" value="<%=multi.getParameter("title")%>">
					</td>
				</tr>
				
				<tr>
					<td align=right><font size="4" face="휴먼편지체">Contents</font></td>
					<td align=left><textarea name="content" cols="70" rows="16"><%=multi.getParameter("content")%></textarea></td>
				</tr>
				
				<tr>
					<td align=right><font size="4" face="휴먼편지체">Image</font></td>
					<td align=left><input type="file" name="uploadfile" size="45"><font size="4" face="휴먼편지체">&nbsp;*5MB이하</font></td>
				</tr>
			</table></center> <p>
			<table>
	 <center>
	 <input type="image" src="C:\project_img\img\확인.jpg" border="0">&nbsp;&nbsp;
	 <a href="PhotoGalleryMain.jsp"><img src="C:\project_img\img\미리보기.jpg" border="0"></a>&nbsp;&nbsp;
	 <a href="PhotoGalleryMain.jsp"><img src="C:\project_img\img\목록.jpg" border="0"></a>
	</center>
			</table>
 </form>
</body>
</html>
<%
   }
   }catch(Exception e){
   }
%>