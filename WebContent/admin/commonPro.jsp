<%@ page contentType="text/html; charset=euc-kr" 
	import="common.CommonAction"
%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="common" class="common.CommonBean">
	<jsp:setProperty name="common" property="*" />
</jsp:useBean>
<%
	CommonAction action = CommonAction.getInstance();
	common.setSseason(request.getParameter("sseason1")+"-"+request.getParameter("sseason2"));
	common.setEseason(request.getParameter("eseason1")+"-"+request.getParameter("eseason2"));
	action.updateCommon(common);
	response.sendRedirect("common.jsp");
%>