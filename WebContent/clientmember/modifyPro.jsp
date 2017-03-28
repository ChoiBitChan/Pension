<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="clientmember.LogonDBBean"%>

<% request.setCharacterEncoding("euc-kr");%>

<jsp:useBean id="member" class="clientmember.LogonDataBean">
	<jsp:setProperty name="member" property="*"/>
</jsp:useBean>

<%
	String id= (String)session.getAttribute("memId");
	member.setId(id);

	LogonDBBean manager = LogonDBBean.getInstance();
	manager.updateMember(member);
%>
<html>
<body>
<table border="0" cellspacing="0" cellpadding="5" align="center">
	<tr>
		<td align="center"><h4>회원정보가 수정되었습니다.</h4></td>
	</tr>
	<tr>
		<td align="center">입력하신 내용대로 수정이 완료되었습니다.</td>
	</tr>
	<tr>
		<td align="center">
			<form>
				<input type="button" value="메인으로" onClick="window.location='../Main/centerMain.jsp'">
			</form>
		</td>
	</tr>
</table>
</body>
</html>