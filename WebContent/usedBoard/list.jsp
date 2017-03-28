<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="board.BoardDBBean"%>
<%@ page import="board.BoardDataBean"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%!
    int pageSize = 10;  // 한 페이지에 나타낼 글 수
    SimpleDateFormat sdf =
    new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {//페이지 번호가 인수로 넘어오지 않으면 1을 기억
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;  //그 페이지의 시작행 지정
    // 2페이지의 경우
    // (2-1)*10 + 1 = 11
    int endRow = currentPage * pageSize; // 그 페이지의 끝행 지정
    // 2페이지의 경우
    //  2+10 = 20
    int count = 0;    // 전체 글 수
    int number=0;   // 그 페이지에서 시작행 번호

    List articleList = null;
    BoardDBBean dbPro = BoardDBBean.getInstance();
    count = dbPro.getArticleCount();
    if (count > 0) {
    //    articleList = dbPro.getArticles(startRow, pageSize);
        articleList = dbPro.getArticles(startRow, endRow);
    }

    number=count-(currentPage-1)*pageSize;//그 페이지에서 시작 행 번호
    // 전체 52개의 글인 경우 2페이지 시작 행 번호
    //    52 - (2-1)*10 = 42
%>

<html>
    <head>
        <title>게시판</title>
        
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>

<body>
    <img src=".\img\head02.gif"><br>
       <center><img src=".\img\img02.gif">
    <br>

<%
    if (count == 0) {  // 등록된 글이 없는 경우
%>
    <table width="800" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                게시판에 저장된 글이 없습니다.
            </td>
        </tr>
    </table>

<%  } else {     // 등록된 글이 있는 경우%> 
    <table border="1" width="800" cellpadding="0" cellspacing="0" align="center">
	    
		
        <tr height="30" bgcolor="black">
            <td align="center"  width="25" ><font color="white" face="HY나무M" size="3">번 호</td>
            <td align="center"  width="250" ><font color="white" face="HY나무M" size="3">제   목</td>
            <td align="center"  width="100" ><font color="white" face="HY나무M" size="3">작성자</td>
            <td align="center"  width="150" ><font color="white" face="HY나무M" size="3">작성일</td>
            <td align="center"  width="50" ><font color="white" face="HY나무M" size="3">조 회</td>
           
        </tr>
<% 
    for (int i = 0 ; i < articleList.size() ; i++) {
        BoardDataBean article = (BoardDataBean)articleList.get(i);
%>
        <tr height="30">
            <td align="center"  width="50"> <%=number--%></td>
            <td  width="250" >
<%
    int wid=0;  // 들여쓰기 설정(레벨에 따라)
    if(article.getRe_level()>0){
        wid=5*(article.getRe_level());
%>
        <img src="images/level.gif" width="<%=wid%>" height="16">
        <img src="./img/ioc-reply.gif"">
<%}else{%>
        <img src="images/level.gif" width="<%=wid%>" height="16">
<%}%>
        <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&sstring=a">
        <%=article.getSubject()%></a>
<% if(article.getReadcount()>=20){%>
        <img src="./img/11.bmp" border="0"  height="16"><%}%> </td>
            <td align="center"  width="100">
            <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>
            <td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
            <td align="center"  width="50"><%=article.getReadcount()%></td>
        </tr>
<%}%>
	</table>
<%}%>
	
<table border="0" width="800">	
<tr>
<td><a href="wirteForm.jsp"><img src=".\img\btn_write.gif" border="0"></a></td>
</tr>
</table>
<%


    if (count > 0) {  // 등록된 글이 있는 경우
    int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
    // 총페이지 수 계산
    //  5 + 1 = 6(등록된 글이 52개인 경우)
    // 5 + 0 = 5 (등록된 글이 50개인 경우)     
    int startPage = (int)(currentPage/10)*10+1;
    int pageBlock=10;
    // 시작 페이지 번호
    // (int)15/10 * 10 + 1= 11(15페이지의 경우)
    int endPage = startPage + pageBlock-1;
    //
    if (endPage > pageCount) endPage = pageCount;

        if (startPage > 10) {    %>
            <a href="list.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
            <a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
            <a href="list.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
<form method="post" name="inform" action="searchList.jsp" >
<table>
<input type="hidden" name="flag" value="search">
<tr>
<td><select name="gubun">
    <option value="subject"> 제    목</option>
    <option value="content">내    용</option>
    <option value="writer">작성자</option>
</select>
<td><input type="text" name="sstring" size=30></td>
<td><input type="image" src="./img/btn_search.gif"></td>
</table>
</form> 
</center>
</body>
</html>

