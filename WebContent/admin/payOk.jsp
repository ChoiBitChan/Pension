<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="reservation.ActionBean"%>
입금 완료 처리중 .....
<%
	int rsno = Integer.parseInt(request.getParameter("rsno"));
	String currentPage = request.getParameter("currentPage");
	new ActionBean().setPayOk(rsno);
%>
<script language="javascript">
	opener.document.searchFrm.currentPage.value = <%= currentPage %>;
	opener.document.searchFrm.submit();
	self.close();
</script>