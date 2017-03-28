<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	try{
		if(session.getAttribute("ultraId")==null){
%>
<html>
	<head>
	<title>펜션 관리자 로그인</title>
	<script language="Javascript">
		function focusIt(){
			document.login.id.focus();
		}
		function checkIt(){
			var inputForm=eval("document.login");
			if(!inputForm.id.value){
				alert("운영자님 아이디좀");
				inputForm.id.focus();
				return;
			}
			if(!inputForm.passwd.value){
				alert("비밀번호도 아이잉");
				inputForm.passwd.focus();
				return;
			}
			document.login.submit();
		}
	</script>
	<link rel="stylesheet" type="text/css" href="./css/admin.css" />
	</head>
	<body onLoad="focusIt()"><br /><br /><br /><br />
	<h2 align="center" style="background:#C4B4E1;">*운영자님  어서 옵숑*</h2><br /><br />
		<form method="post" action="LoginPro.jsp" name="login">
			<table border="0" align="center" width="350">
				<tr align="center">
					<td class="tableSubject2" height="60" width="350">
						ID&nbsp;<input type="text" name="id" size="10" /> 
						passwd&nbsp;<input type="password" name="passwd" size="10" onkeypress="javascript:if(event.keyCode==13)checkIt();" />
					</td>
				</tr>
				<tr>
					<td class="tableSubject3" onClick="checkIt()" style="cursor:hand;" height="100">로그인</td>
				</tr>
			</table >
		</form>
		<%} else { %>
		<script language="javascript">
			location.href="reservationList.jsp";
		</script>
	<%	  }
	} catch(NullPointerException e){}
	%>
	</body>
</html>	