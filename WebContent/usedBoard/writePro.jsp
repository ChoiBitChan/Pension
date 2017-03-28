<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="board.BoardDBBean"%>
<%@ page import="java.sql.Timestamp"%>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="article" class="board.BoardDataBean" scope="page">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
	article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	BoardDBBean dbPro = BoardDBBean.getInstance();
	dbPro.insertArticle(article);
	response.sendRedirect("list.jsp");
%>