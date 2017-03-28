<jsp:include page="head.jsp" />
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    import="java.util.Vector"
    import="common.MemberBean"
    import="common.CommonAction"
%>
<%	
	request.setCharacterEncoding("euc-kr");
	String searcht = request.getParameter("searcht") == null ? "":request.getParameter("searcht");
	String searchv = request.getParameter("searchv") == null ? "":request.getParameter("searchv");

	// 총 수
	Vector<MemberBean> cvmb = CommonAction.getInstance().selectMember(searcht,searchv,0,0);
	int count = cvmb.get(0).getMno();	// 검색된 리스트 총 수 반환
	int currentPage = Integer.parseInt(request.getParameter("currentPage")==null?"1":request.getParameter("currentPage"));
	if( currentPage < 1 )currentPage = 1;
	int pageSize = 12;								// 한 페이지에 보여질 리스트 수
	int startNum = ((currentPage-1) * pageSize)+1;	// 페이징을 위한 시작값
	int endNum = currentPage * pageSize;			// 페이징을 위한 끝값
	// 리스트
	Vector<MemberBean> vmb = CommonAction.getInstance().selectMember(searcht,searchv,startNum,endNum);
/**
	count - 총개수
	currentPage - 현재 페이지 값
	targetPage - 현재 페이지명
	addPrameter - 페이지에 넘기는값
*/
	String addParmeter = "&searcht="+searcht+"&searchv="+searchv;
	String targetPage = "member.jsp";
%>
<form method="post" action="member.jsp">
<table border="1">
	<tr>
		<th colspan="2" class="tableSubject1">회원리스트</th>
	</tr>
	<tr>
		<td class="tableSubject2">일반검색</td>
		<td>
			<select name="searcht">
				<option value="" <% if(searcht.equals("")) out.print("selected"); %> />::검색 타이틀::
				<option value="name" <% if(searcht.equals("name")) out.print("selected"); %> />이름
				<option value="addr1" <% if(searcht.equals("addr1")) out.print("selected"); %> />주소
				<option value="email" <% if(searcht.equals("email")) out.print("selected"); %> />이메일
			</select> 
			<input type="text" name="searchv" /> 
			<input type="submit" value="검색" />
		</td>
	</tr>
</table>
</form>
<p />
<table border="1">
	<tr>
		<td class="tableSubject2">번호</td>
		<td class="tableSubject2">아이디</td>
		<td class="tableSubject2">이름</td>
		<td class="tableSubject2">이메일</td>
		<td class="tableSubject2">수신여부</td>
		<td class="tableSubject2">집전화</td>
		<td class="tableSubject2">휴대폰</td>
		<td class="tableSubject2">가입일</td>
	</tr>
<%
	if( vmb == null ){
%>
	<tr>
		<td colspan="8" class="center1">[ 찾으시는 내용이 없습니다 ]</td>
	</tr>
<%
	}else
	for( int i=0; i<vmb.size() ; i++ ){
		MemberBean mb = vmb.get(i);
%>
	<tr>
		<td><%= vmb.size()-i %></td>
		<td><%= mb.getId() %></td>
		<td><%= mb.getName() %></td>
		<td><%= mb.getEmail() %></td>
		<td><%= mb.getRecv_yn() %></td>
		<td><%= mb.getPhone1()+"-"+mb.getPhone2()+""+mb.getPhone3() %></td>
		<td><%= mb.getCell1()+"-"+mb.getCell2()+"-"+mb.getCell3() %></td>
		<td><%= mb.getReg_date() %></td>
	</tr>
<% 	} %>
	<tr>
		<td colspan="8" class="tableSubject2">
			<%@ include file="../common/paging.jsp" %>
		</td>
	</tr>
</table>
<jsp:include page="foot.html" />