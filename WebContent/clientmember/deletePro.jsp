<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="clientmember.LogonDBBean"%>

<html>
	<head>
	</head>
	<%
		String id=(String)session.getAttribute("memId");
		String passwd=request.getParameter("passwd");

		LogonDBBean manager=LogonDBBean.getInstance();
		int check = manager.deleteMember(id,passwd);

		if(check == 1){
			session.invalidate();
	%>
	<body>
		<form method="post" action="main.jsp" name="userprint">
			<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
				<tr align="center">
					<td><b>회원 정보가 삭제되었습니다.</b></td>
				</tr>
				<tr>
					<td><meta http-equiv="Refresh"content="5;url=../index.jsp"></td>
				</tr>
				<tr>
					<td align="center"><input type="submit" value="확인"></td>
				</tr>
			</table>
		</form>
		<%}else{%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>
		<%}%>
	</body>
</html>