<%@ page pageEncoding="EUC-KR" %>
<!-- paging -->
<%
	/** 
		count - 총개수
		pageSize - 한페이지에 보여줄 리스트 개수
		pageBlock - 화면에 보여줄 페이지수(하단에 [1][2]...)
		currentPage - 현재 페이지 값
		targetPage - 사용할 페이지명
		addParmeter - 페이지에 추가로 넘기는 값
	*/
	/* int pageBlock = 5;
	int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1 );
	int startPage = currentPage / (pageBlock + 1) +1 ;
	if( startPage > 1 ){
		startPage = ((startPage-1) * pageBlock)+1;
	}
	int endPage = startPage + pageBlock - 1;
	if( endPage > pageCount ) endPage = pageCount;
	
	if( startPage > pageBlock ){ */
%>
	<%-- <a href="<%= targetPage %>?currentPage=<%= (startPage - 1)+addParmeter %>">[back]</a> --%>
<%
	/* }
	for( int i=startPage; i<=endPage; i++ ){ */
%>
	<%-- <a href="<%= targetPage %>?currentPage=<%= i+addParmeter %>">[<%= i %>]</a> --%>
<%
	/* }
	if( endPage < pageCount ){ */
%>
	<%-- <a href="<%= targetPage %>?currentPage=<%= (endPage + 1)+addParmeter %>">[front]</a> --%>
<%
	/* } */
%>
<!-- /paging -->