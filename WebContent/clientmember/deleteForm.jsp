<%@ page contentType="text/html;charset=euc-kr"%>
<html>
	<head>
	<link href="style.css" rel="stylesheet" type="text/css"></link>
	<script language="javascript">
	<!--
		function begin(){
			document.myform.id.focus();
		}
		
		function checkIt(){
			if(document.myform.id.value==" " || document.myform.passwd.value=" "){
				alert("아이디와 패스워드를 입력해주세요.");
				document.myform.id.focus();
				return false;
			}
		}
	-->
	</script>
	</head>
	<body onLoad="begin()">
		<form name="myform" action="deletePro.jsp" method="post" onSubmit="return checkIt()">
			<table cellspacing="0"cellpadding="3" width="260" border="1" align="center">
				<tr>
					<td colspan="2" align="middle">
						회원탈퇴를 위해 다시 한 번 아이디와 비밀번호를 입력해주세요.
					</td>
				</tr>	
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" size="15" maxlength="15"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" size="15" maxlength="15"></td>
				</tr>
				<tr align="center">
					<td colspan="2"><input type="submit" name="btn_quit" value="회원탈퇴" class="f2"></td>
				</tr>
			</table>
		</form>
	</body>
</html>