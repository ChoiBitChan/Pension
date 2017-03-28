<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@page import="board.BoardDBBean1"%>
<%@page import="board.BoardDataBean"%>
<html>
<head>
   <title>°Ô½ÃÆÇ</title>
   <link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
	String gogo=null;
	request.setCharacterEncoding("euc-kr");
	String flag = request.getParameter("flag");
	String gubun = request.getParameter("gubun");
	String sstring = new String(request.getParameter("sstring").getBytes("ISO-8859-1"),"EUC-KR");
   

   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try{
      BoardDBBean1 dbPro = BoardDBBean1.getInstance();
      BoardDataBean article =  dbPro.getArticle(num);
 
      int ref=article.getRef();
      int re_step=article.getRe_step();
      int re_level=article.getRe_level();
%>
<body> 
<img src=".\img\head03.gif"><br>
       <center><img src=".\img\img03.gif"></center>
    <br>
 
<form>
<table width="500" cellspacing="3" cellpadding="0" align="center" border="0"> 
       
  <tr height="30">
    <td><img src="./img/7.gif"></td>
    <td><%=article.getWriter()%></td>
  </tr>  
  
  <tr>
    <td><img src="./img/8.gif"></td>
    <td><%= sdf.format(article.getReg_date())%></td>
  </tr>
  
  <tr> 
  	   <td><img src="./img/05.gif"></td>
       <td><%=article.getSubject()%></td>
  </tr>
  
  <tr>
    <td> <img src="./img/06.gif"></td>
    <td align="left" width="375" colspan="3"><pre><%=article.getContent()%></pre></td>
  </tr>

 <tr height="30">     
    <td colspan="4" align="right" >
      <a href="updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>"><img src="./img/btn_modify.gif" border="0"></a>
  
      <a href="deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>"><img src="./img/btn_delete.gif" border="0"></a>

      <a href="wirteForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>">
      <img src="./img/btn_write.gif" border="0"></a>
      
     
      
    
      <a href="list.jsp?pageNum=<%=pageNum%>"> <img src="./img/btn_list.gif" border="0"></a>

    </td>
  </tr>
</table>    
<%
 }catch(Exception e){}
 %>
  <% 
     
     if(flag != null && flag.equals("search")) { 
		%>
         <a href="searchList.jsp?pageNum=<%=pageNum%>&gubun=<%=gubun%>&sstring=<%=sstring%>&flag=search1">
         </a>

     <% } %>
</form>     
</body>
</html> 