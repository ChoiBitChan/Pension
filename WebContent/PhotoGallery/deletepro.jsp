<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="photoGallery.DBB" %>

<html>
<head>
<title>글삭제</title>

</head>

<%
    String name = request.getParameter("name");
	String passwd  = request.getParameter("passwd");
	
	DBB manager = DBB.getInstance();
    int check = manager.deleteMember(name,passwd);
	
	if(check==1){
		session.invalidate();
%>
<body>
<form method="post" action="jspTestMain.jsp" name="userinput" >
<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr> 
    <td height="39" align="center">
	  <font size="+1" ><b>글이 삭제되었습니다.</b></font></td>
  </tr>
  <tr>
    <td align="center"> 
      <p>흑흑.... 서운합니다. 안녕히 가세요.</p>
      <meta http-equiv="Refresh" content="5;url=main.jsp" >
    </td>
  </tr>
  <tr >
    <td align="center"> 
      <input type="submit" value="확인">
    </td>
  </tr>
</table>
</form>
<%}else {%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}%>

</body>
</html>
