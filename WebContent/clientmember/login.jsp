<%@ page contentType="text/html; charset=euc-kr"%>
<html>
	<head><title>메인입니다..</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	</head>
<%
 try{
   if(session.getAttribute("memId")==null){%>
	<script language="javascript">
	<!--
		function focusIt(){      
			document.inform.id.focus();
		}
		function checkIt(){
			inputForm=eval("document.inform");
			if(!inputForm.id.value){
				alert("아이디를 입력하세요..");
				inputForm.id.focus();
				return false;
			}
			if(!inputForm.passwd.value){
				alert("패스워드를 입력하세요..");
				inputForm.passwd.focus();
				return false;
			}
	 	}
	//-->
	</script>
	</head>
	<body onLoad="focusIt();">
	  <table cellpadding="0" cellspacing="0"  align="center" border="1" >
	      <tr>
	       <form name="inform" method="post" action="../clientmember/loginPro.jsp"  onSubmit="return checkIt();">
	        <td width="100" align="right">아이디</td>
	        <td width="100" >
	            <input type="text" name="id" size="15" maxlength="10"></td>
	      </tr>
	      <tr > 
	         <td width="100" align="right">패스워드</td>
	         <td width="100">
	            <input type="password" name="passwd" size="15" maxlength="10"></td>
	       </tr>
	       <tr>
	          <td colspan="3" align="center">
	            <input type="submit" name="Submit" value="로그인" class="f2">
	            <input type="button"  value="회원가입" onclick="javascript:window.parent.center.location='../clientmember/MemberJoin.jsp'" class="f2">
	          </td></form></tr></table>
	     <%}else{%>
	       <table cellpadding="0" cellspacing="0"  align="center" border="1" >
	         <tr>
	             <%=session.getAttribute("memId")%>님이 <br>
	             방문하셨습니다
	             <form  method="post" action="../clientmember/logout.jsp">  
		             <input type="submit" value="로그아웃">
		             <input type="button" value="회원정보변경" onclick="javascript:parent.center.location='modifyForm.jsp'">
	             </form>
	         </td>
	        </tr>
	     </table>
	     <br>
	 <%}
	 }catch(NullPointerException e){}
	 %>
	 </body>
</html>