<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="board.BoardDBBean" %>
<%@ page import="board.BoardDataBean" %>
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

<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardDataBean"%><html>
    <head>
        <title>게시판</title>
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>

<body bgcolor="green">
    <center><b>글목록(전체 글:<%=count%>)</b>
    <table width="700">
        <tr>
            <td align="right" bgcolor="green">
                <a href="writeForm.jsp">글쓰기</a>
            </td>
        </tr>
    </table>

<%
    if (count == 0) {  // 등록된 글이 없는 경우
%>
    <table width="700" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                게시판에 저장된 글이 없습니다.
            </td>
        </tr>
    </table>

<%  } else {    %>  // 등록된 글이 있는 경우
    <table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
        <tr height="30" bgcolor="green">
            <td align="center"  width="50"  >번 호</td>
            <td align="center"  width="250" >제   목</td>
            <td align="center"  width="100" >작성자</td>
            <td align="center"  width="150" >작성일</td>
            <td align="center"  width="50" >조 회</td>
            <td align="center"  width="100" >IP</td>   
        </tr>
<% 
    for (int i = 0 ; i < articleList.size() ; i++) {
        BoardDataBean article = (BoardDataBean)articleList.get(i);
%>
<%}%>
    </table>
<%}%>

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
        </center>
    </body>
</html>