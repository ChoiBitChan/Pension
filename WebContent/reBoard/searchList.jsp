<%@ page contentType = "text/html; charset=euc-kr" %>
<%@page import="board.BoardDBBean1"%>
<%@page import="board.BoardDataBean"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<%!
    int pageSize = 10;  // 한 페이지에 나타낼 글 수
    SimpleDateFormat sdf =
    new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
request.setCharacterEncoding("euc-kr");
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
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
    
    String gubun = request.getParameter("gubun");
    String gubun1 = gubun; 
 
    String sstring = request.getParameter("sstring");
    String sstring1 = sstring; 
    String flag = request.getParameter("flag");
    
	   if(flag.equals("search1")) {
		    sstring =  new String(request.getParameter("sstring1").getBytes("ISO-8859-1"),"EUC-KR");
	   }
	 List articleList = null;
    BoardDBBean1 dbPro = BoardDBBean1.getInstance();
    
    count = dbPro.getArticleCount1(gubun,sstring);
    
 
    if (count > 0) {
    //    articleList = dbPro.getArticles(startRow, pageSize);
        articleList = dbPro.getArticles(startRow, endRow, gubun, sstring);

    }

    number=count-(currentPage-1)*pageSize;
    System.out.println("articleList : " + articleList);

%>

<html>
    <head>
        <title>게시판</title>
        
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>

<body>
    <img src=".\img\head03.gif"><br>
       <center><img src=".\img\img03.gif"></center>
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
        <img src="images/re.gif">
<%}else{%>
        <img src="images/level.gif" width="<%=wid%>" height="16">
<%}%>


        <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&flag=search&gubun=<%=gubun1%>&sstring=<%=sstring1%>">
        <%=article.getSubject()%></a>
<% if(article.getReadcount()>=20){%>
        <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
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
    <a href="searchList.jsp?pageNum=<%= startPage - 10 %>&gubun=<%=gubun1%>&sstring=<%=sstring1%>&flag=search">[이전]</a>
<%      }
for (int i = startPage ; i <= endPage ; i++) {  %>
    <a href="searchList.jsp?pageNum=<%= i %>&gubun=<%=gubun1%>&sstring=<%=sstring1%>&flag=search">[<%= i %>]</a>
<%
       }
if (endPage < pageCount) {  %>
<a href="searchList.jsp?pageNum=<%= startPage + 10 %>&gubun=<%=gubun1%>&sstring=<%=sstring1%>&flag=search">[다음]</a>
<%
}
   }
%>


<form method="post" name="inform" action="searchList.jsp" >
<input type="hidden" name="flag" value="search">
<table>
<tr>
<td><select name="gubun">
    <option value="subject"> 제    목</option>
    <option value="content">내    용</option>
    <option value="writer">작성자</option>
</select></td>
<td><input type="text" name="sstring" size=30></td>
<td><input type="image" src="./img/btn_search.gif"></td>

</table>
</form> 
</center>
</body>
</html>

