<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="photoGallery.DBBean" %>
<%@ page import="photoGallery.DataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    int pageSize = 20;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    List articleList = null;
    DBBean dbPro = DBBean.getInstance();
    count = dbPro.getArticleCount();
    if (count > 0) {
        articleList = dbPro.getArticles(startRow, pageSize);
    }

	number=count-(currentPage-1)*pageSize;
%>
<html>
<head>
<title>진한 향기와 천국같은 휴식공간</title>
</head>

<body>
<FORM>
<img src="../project_img\img\photogelleryhead.gif"><p> 
	<div align="center"><img src="../project_img\img\photogallery.gif" align="center"></div>
	
<center>
<table border="1" width="800">
    <tr><td >
      <table border="1">
    	<tr><td width="200">
            	<p>이미지</p>
        </td></tr>
        <tr><td width="200">
                <p>작성자</p>
        </td></tr>
      </table>
          
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
    <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
     <td><table border="1">
     <tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
        </td>
    </tr>
</table>
</center><br>

<center>
<table border="1" width="800">
    <tr><td >
      <table border="1">
    	<tr><td width="200">
            	<p>이미지</p>
        </td></tr>
        <tr><td width="200">
                <p>작성자</p>
        </td></tr>
      </table>
          
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
    <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
        </td>
    </tr>
</table>
</center><br>

<center>
<table border="1" width="800">
    <tr><td >
      <table border="1">
    	<tr><td width="200">
            	<p>이미지</p>
        </td></tr>
        <tr><td width="200">
                <p>작성자</p>
        </td></tr>
      </table>
          
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
    <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
        </td>
    </tr>
</table>
</center><br>

<center>
<table border="1" width="800">
    <tr><td >
      <table border="1">
    	<tr><td width="200">
            	<p>이미지</p>
        </td></tr>
        <tr><td width="200">
                <p>작성자</p>
        </td></tr>
      </table>
          
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
    <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
        </td>
    </tr>
</table>
</center><br>

<center>
<table border="1" width="800">
    <tr><td >
      <table border="1">
    	<tr><td width="200">
            	<p>이미지</p>
        </td></tr>
        <tr><td width="200">
                <p>작성자</p>
        </td></tr>
      </table>
          
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
    <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
     
     <td><table border="1">
     	<tr><td width="200">
                <p>이미지</p>
     	</td></tr>
     	<tr><td width="200">
                <p>작성자</p>
    	 </td></tr>
     </table></td>
        </td>
    </tr>
</table>
</center><p>
<hr>
<center>
	<table border="0" width="800">
		<tr>
			<td align="left">
				<img src="../project_img\img\index1.jpg">
				<img src="../project_img\img\write1.jpg" onClick="location.href='./PhotoGalleryForm.jsp'" style="cursor:hand;">
			</td>
			<td align="center"></td>
			<td align="right">
				<img src="../project_img\img\back1.jpg">
				<img src="../project_img\img\next1.jpg">
			</td>
		</tr>
	</table>
</center>
</FORM>
</body>
</html>