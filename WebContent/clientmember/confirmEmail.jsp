<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="clientmember.LogonDBBean"%>

<html>
	<head><title>이메일 중복 확인</title>
	<link href="style.css" rel="stylesheet" type="text/css"></link>
	</head>
	<%
		request.setCharacterEncoding("euc-kr");	
		String email = request.getParameter("email");
		LogonDBBean manager = LogonDBBean.getInstance();
		int check = manager.confirmEmail(email);

	%>
	<body>
		<%
			if(check == 1){ %>
		<table width="270" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td height="39"><%=email%> 이미 사용중인 이메일입니다</td>
			</tr>
		</table>
		<form name="checkForm" method="post" action="confirmEmail.jsp">
		<table width="270" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td>
					다른 이메일을 적는 게 좋을 걸...<p>
					<input type="text" size="15" maxlength="15" name="email">
					<input type="submit" value="이메일 중복확인" class="f2">
				</td>
			</tr>
		</table>
		</form>
		<%}else{%>
		<table width="270" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td>
					<p>이 <%=email%>이메일은 사용할 수 있으셩.</p>
					<input type="button" value="닫기" onclick="setEmail()" class="f2">
				</td>
			</tr>
		</table>
		<%}%>
	</body>
</html>
<script language="javascript">
		
			function setEmail(){
				opener.document.memberjoin.email.value="<%=email%>";
				opener.document.memberjoin.emailCheck.value="yes";
				self.close();
			}
		
	</script>