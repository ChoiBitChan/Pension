<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="board.BoardDBBean"%>
<%@ page import="board.BoardDataBean"%><html>
<head>
<title>°Ô½ÃÆÇ</title>
 <link href="style.css" rel="stylesheet" type="text/css">

<script language="JavaScript" src="script.js"></script>
</head>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  try{
      BoardDBBean dbPro = BoardDBBean.getInstance();
      BoardDataBean article = dbPro.updateGetArticle(num);

%>
<body> 

   <img src="./img/head02.gif"><br>
       <center><img src="./img/img02.gif"></center>
    <br>
    <form method="post" name="writeform" action="updatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
   	<input type="hidden" name="num" value="<%= article.getNum() %>" />
    <table cellspacing="3" align="center" >
      <tr>
        <td><img src="./img/01.gif"></td>		
         <td><input type="text" size="15" maxlength="10" name="writer" value="<%=article.getWriter()%>"></td>	
      </tr>
    
      <tr>
        <td><img src="./img/05.gif"></td> 
        <td  width="330"><input type="text" size="40" maxlength="50" name="subject" value="<%=article.getSubject()%>"></td>
      </tr>


      <tr>
        <td><img src="./img/03.gif"></td>
        <td  width="330">
           <input type="text" size="30" maxlength="30" name="email" value="<%=article.getEmail()%>"></td>
      </tr>
      
      
      <tr>
        <td><img src="./img/06.gif"></td>
        <td  width="330" >
         <textarea name="content" rows="13" cols="40"><%=article.getContent()%></textarea> </td>
      </tr>
      
      
      <tr>
        <td><img src="./img/02.gif"></td>
        <td  width="330" >
         <input type="password" size="10" maxlength="12" name="passwd">
         </td>
      </tr>
      
      
    <tr>     
     <td colspan=2  align="center">
      <input type="image" src="./img/btn_save.gif">
      <a href="list.jsp"><img src="./img/btn_return.gif" border="0"></a>
      <input type="image" src="./img/btn_read.gif" 
      OnClick="window.location='list.jsp'" >
    </td>
    </tr>
    </table>   
    </form>     
    <%
}catch(Exception e){}%>     
     
</body>
</html>

