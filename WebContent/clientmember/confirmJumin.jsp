<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="clientmember.LogonDBBean"%>
<html>
	<head><title>주민등록번호 중복 확인</title>
	<link href="style.css" rel="stylesheet" type="text/css"></link>
	</head>
	<%
		request.setCharacterEncoding("euc-kr");	
		String jumin1 = request.getParameter("jumin1");
		String jumin2 = request.getParameter("jumin2");
		LogonDBBean manager = LogonDBBean.getInstance();
		int check = manager.confirmJumin(jumin1,jumin2);
	%>
	<body>
		<% if(check == 1){ %>
		<table width="270" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td height="39"><p>당신은 주민등록번호를 도용하고 있어. 자수해 -_-</p>
					<input type="button" value="닫기" class="f2" onClick="resetJumin()" />
				</td>
			</tr>
		</table>
		<%}else{%>
		<table width="270" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td>
					<p>가입할 수 있는 주민등록번호입니다.</p>
					<input type="button" value="닫기" onclick="setJumin()" class="f2">
				</td>
			</tr>
		</table>
		<%}%>
	</body>
</html>
<script language="javascript">
<!--
	function resetJumin(){
		opener.document.memberjoin.jumin1.value="";
		opener.document.memberjoin.jumin2.value="";
		self.close();
	}
	function setJumin(){
		opener.document.memberjoin.jumin1.value="<%=jumin1%>";
		opener.document.memberjoin.jumin2.value="<%=jumin2%>";
		opener.document.memberjoin.juminCheck.value="yes";
		self.close();
	}
-->
</script>