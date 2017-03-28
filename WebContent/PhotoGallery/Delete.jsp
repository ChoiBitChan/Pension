<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<html>
<head>
	<title>글삭제</title>
<link href="style.css" rel="stylesheet" type="text/css">

   <script language="javascript">
     <!--
       function begin(){
         document.myform.passwd.focus();
       }

       function checkIt(){
		  if(!document.myform.passwd.value){
           alert("비밀번호를 입력하지 않으셨습니다.");
           document.myform.passwd.focus();
           return false;
         }
	   }   
     -->
   </script>
</head>
<BODY onload="begin()">
<form name="myform" action="deletepro.jsp" method="post" onSubmit="return checkIt()">
<TABLE cellSpacing=1 cellPadding=1 width="260" border=1 align="center" >
  
  <TR height="30">
    <TD colspan="2" align="middle">
	  <font size="+1" ><b>글삭제</b></font></TD></TR>
  
  <TR height="30">
    <TD width="110" align=center>비밀번호</TD>
    <TD width="150" align=center>
      <INPUT type=password name="passwd"  size="15" maxlength="12"></TD></TR>
  <TR height="30">
    <TD colspan="2" align="middle" >
      <INPUT type=submit value="삭제"> 
      <input type="button" value="취  소" onclick="javascript:window.location='Main.jsp'"></TD></TR>
</TABLE>
</form>
</BODY>
</HTML>
