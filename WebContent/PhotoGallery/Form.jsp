<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

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
					<td colspan="2"><center><b><font size="4" face="휴먼편지체"> 새/글/쓰/기</font></b></center></td>
				</tr>
			</table>
			<center><table width="800" frame="below" rules="none" cellpadding="3" cellspacing="10" border="1">	
				<tr>
 					<td align=right width="150"><font size="4" face="휴먼편지체">Name</font></td>
					<td align=left><input type="text" name="name" size="20" maxlength="20"></td>
				</tr>

				<tr>
					<td align=right><font size="4" face="휴먼편지체">Password</font></td>
					<td align=left><input type="password" name="passwd" size=21 maxlength="20"></td>
				</tr>
   
				<tr>
					<td align=right><font size="4" face="휴먼편지체">E-mail</font></td>
					<td align=left><input name="email" type="text" size="40" maxlength="64"></td>
				</tr>
				
				<tr>
					<td align=right><font size="4" face="휴먼편지체">Homepage</font></td>
					<td align=left><input name="homepage" type="text" size="40" maxlength="64"></td>
				</tr>
				
				<tr>
					<td align=right><font size="4" face="휴먼편지체">Title</font></td>
					<td align=left><input name="title" type="text" size="60" maxlength="64">
					</td>
				</tr>
				
				<tr>
					<td align=right><font size="4" face="휴먼편지체">Contents</font></td>
					<td align=left><textarea name="content" cols="70" rows="16"></textarea></td>
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