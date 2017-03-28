<%@ page contentType="text/html;charset=euc-kr" %>


<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script language="JavaScript">     
<!--     
  function deleteSave(){   
    if(document.delForm.passwd.value==''){
    alert("비밀번호를 입력하십시요.");
    document.delForm.passwd.focus();
    return false;
 }
}   
// -->     
</script>
</head>

<body>
<img src="./img/head03.gif"><br>
       <center><img src="./img/img03.gif"></center>
    <br>
<br>
<form method="POST" name="delForm"  action="deletePro.jsp?pageNum=<%=pageNum%>"
   onsubmit="return deleteSave()">
 <table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
  <tr height="30">
     <td align=center>
       <b>비밀번호를 입력해 주세요.</b></td>
  </tr>
  <tr height="30">
     <td align=center>비밀번호 :  
       <input type="password" name="passwd" size="8" maxlength="12">
       <input type="hidden" name="num" value="<%=num%>"></td>
 </tr>
 <tr height="30">
    <td align=center>
      <input type="image" src="./img/btn_ok.gif">
     <a href="list.jsp?pageNum=<%=pageNum%>"><img src="./img/btn_read.gif" border="0">    
   </a>
   </td>
 </tr> 
</table>
</form>
</body>
</html>

