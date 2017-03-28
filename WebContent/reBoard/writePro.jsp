<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%@page import="board.BoardDBBean1"%>
<%@page import="java.sql.Timestamp"%>

<jsp:useBean id="article" class="board.BoardDataBean" scope="page">
<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
article.setReg_date(new Timestamp(System.currentTimeMillis()) );

BoardDBBean1 dbPro = BoardDBBean1.getInstance();

dbPro.insertArticle(article);

response.sendRedirect("list.jsp");


%>