<jsp:include page="head.jsp" />
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    import="java.util.Calendar"
    import="java.util.Vector"
    import="common.CommonAction"
    import="reservation.ReservationBean"
%>
<%
	request.setCharacterEncoding("euc-kr");
	Calendar cal = Calendar.getInstance();

	String syear = request.getParameter("syear") == null ? cal.get(Calendar.YEAR)+"" :request.getParameter("syear");
	String smonth = request.getParameter("smonth") == null ? (cal.get(Calendar.MONTH)+1)+"" :request.getParameter("smonth");
	String sdate = request.getParameter("sdate") == null ? cal.get(Calendar.DATE)+"" :request.getParameter("sdate");
	String eyear = request.getParameter("eyear") == null ? cal.get(Calendar.YEAR)+"" :request.getParameter("eyear");
	String emonth = request.getParameter("emonth") == null ? (cal.get(Calendar.MONTH)+1)+"" :request.getParameter("emonth");
	String edate = request.getParameter("edate") == null ? cal.get(Calendar.DATE)+"" :request.getParameter("edate");
	
	String card = request.getParameter("card") == null ? "":request.getParameter("card");
	String bank = request.getParameter("bank") == null ? "":request.getParameter("bank");
	String banksub = request.getParameter("banksub") == null ? "":request.getParameter("banksub");
	
	String searcht = request.getParameter("searcht") == null ? "":request.getParameter("searcht");
	String searchv = request.getParameter("searchv") == null ? "":request.getParameter("searchv");
	
	int currentPage = Integer.parseInt((request.getParameter("currentPage")==null || request.getParameter("currentPage").equals(""))?"1":request.getParameter("currentPage"));
%>
<script language="javascript">
<!--
	// 입금 완료 처리 후 다시 보여줌
	function payOk(rsno){
		window.open('payOk.jsp?rsno='+rsno+'&currentPage='+<%= currentPage %>,'','width=1 height=1');
	}
-->
</script>
<form name="searchFrm" method="post" action="reservationList.jsp">
<input type="hidden" name="currentPage" value="" /><!-- payOk.jsp 팝업파일에서 사용하는 hidden -->
<table border="1">
	<tr>
		<th colspan="2" class="tableSubject1">펜션 예약 목록</th>
	</tr>
	<tr>
		<td class="tableSubject2">검색기간</td>
		<td>
			<select name="syear">
			<% for( int i=2008; i<2011; i++ ){ %>
				<option value="<%= i %>" <% if(Integer.parseInt(syear)==i)out.print("selected"); %> /><%= i %>
			<% } %>
			</select>년 
			<select name="smonth">
			<% for( int i=1; i<13; i++ ){ %>
				<option value="<%= (i<10)?"0"+i:i %>" <% if(Integer.parseInt(smonth)==i)out.print("selected"); %> /><%= i %>
			<% } %>
			</select>월 
			<select name="sdate">
				<% for( int i=1; i<32; i++ ){ %>
				<option value="<%= (i<10)?"0"+i:i %>" <% if(Integer.parseInt(sdate)==i)out.print("selected"); %> /><%= i %>
			<% } %>
			</select>일 ~ 
			<select name="eyear">
			<% for( int i=2008; i<2011; i++ ){ %>
				<option value="<%= i %>" <% if(Integer.parseInt(eyear)==i)out.print("selected"); %> /><%= i %>
			<% } %>
			</select>년 
			<select name="emonth">
			<% for( int i=1; i<13; i++ ){ %>
				<option value="<%= (i<10)?"0"+i:i %>" <% if(Integer.parseInt(emonth)==i)out.print("selected"); %> /><%= i %>
			<% } %>
			</select>월 
			<select name="edate">
				<% for( int i=1; i<32; i++ ){ %>
				<option value="<%= (i<10)?"0"+i:i %>" <% if(Integer.parseInt(edate)==i)out.print("selected"); %> /><%= i %>
			<% } %>
			</select>일
		</td>
	</tr>
	<tr>
		<td class="tableSubject2">검색기능</td>
		<td>
			<input type="checkbox" name="card" value="card" <% if(card.equals("card"))out.print("checked"); %> />카드 
			<input type="checkbox" name="bank" value="bank" <% if(bank.equals("bank"))out.print("checked"); %> />계좌이체 &nbsp;&nbsp;&nbsp;
			<input type="radio" name="banksub" value="y" <% if(banksub.equals("y"))out.print("checked"); %> />입금완료 
			<input type="radio" name="banksub" value="n" <% if(banksub.equals("n"))out.print("checked"); %> />입금예정 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="searcht">
				<option value="" <% if(searcht.equals(""))out.print("selected"); %> />::검색타이틀::
				<option value="rname" <% if(searcht.equals("rname"))out.print("selected"); %> />객실이름
				<option value="id" <% if(searcht.equals("id"))out.print("selected"); %> />예약자ID
				<option value="name" <% if(searcht.equals("name"))out.print("selected"); %> />예약자명
			</select>
			<input type="text" name="searchv" value="<%= searchv %>" size="15" /> 
			<input type="submit" value="검색" />
		</td>
	</tr>
</table>
</form>
<table border="1">
	<tr>
		<td class="tableSubject2">번호</td>
		<td class="tableSubject2">객실이름</td>
		<td class="tableSubject2">사용인원</td>
		<td class="tableSubject2">결제금액</td>
		<td class="tableSubject2">결제방법</td>
		<td class="tableSubject2">결제유무</td>
		<td class="tableSubject2">예약날짜</td>
		<td class="tableSubject2">숙박일수</td>
		<td class="tableSubject2">예약자ID</td>
		<td class="tableSubject2">예약자명</td>
		<td class="tableSubject2">신청날짜</td>
		<td class="tableSubject2">입금처리</td>
	</tr>
<%
	// 총 수
	Vector<ReservationBean> cvrb = CommonAction.getInstance().selectReservation(syear+smonth+sdate,eyear+emonth+edate,card,bank,banksub,searcht,searchv,0,0);
	int count = cvrb.get(0).getRsno();	// 검색된 리스트 총 수 반환

	if( currentPage < 1 )currentPage = 1;
	int pageSize = 12;								// 한 페이지에 보여질 리스트 수
	int startNum = ((currentPage-1) * pageSize)+1;	// 페이징을 위한 시작값
	int endNum = currentPage * pageSize;			// 페이징을 위한 끝값
	// 리스트
	Vector<ReservationBean> vrb = CommonAction.getInstance().selectReservation(syear+smonth+sdate,eyear+emonth+edate,card,bank,banksub,searcht,searchv,startNum,endNum);
/**
	count - 총개수
	currentPage - 현재 페이지 값
	targetPage - 현재 페이지명
	addPrameter - 페이지에 넘기는값
*/
	String addParmeter = "&syear="+syear+"&smonth="+smonth+"&sdate="+sdate+"&eyear="+eyear+"&emonth="+emonth+"&edate="+edate+"&card="+card+"&bank="+bank+"&banksub="+banksub+"&searcht="+searcht+"&searchv="+searchv;
	String targetPage = "reservationList.jsp";
	
	if( vrb == null ){
%>
	<tr>
		<td colspan="12" class="center1">[ 찾으시는 내용이 없습니다 ]</td>
	</tr>
<% 	}else{
		int listCount = count - (startNum-1);
		for( int i=0; i<vrb.size(); i++ ){
			ReservationBean rb = vrb.get(i);
%>
	<tr>
		<td><%= listCount-- %></td>
		<td><%= rb.getRoomname() %></td>
		<td><%= rb.getUsemen() %></td>
		<td><%= rb.getPrice() %></td>
		<td><%= rb.getPay_name() %></td>
		<td><%= rb.getPay_yn() %></td>
		<td><%= rb.getRes_date() %></td>
		<td><%= rb.getNight() %></td>
		<td><%= rb.getUserid() %></td>
		<td><%= rb.getUsername() %></td>
		<td><%= rb.getReg_date() %></td>
		<td>
			<% if( rb.getPay_yn().equals("N") ){ %>
				<input type="button" value="입금완료" onClick="javascript:if(confirm('증말? 입금된겨??'))payOk(<%= rb.getRsno() %>);" />
			<% } %>
		</td>
	</tr>
<% 		}
	} %>
	<tr>
		<td colspan="12" class="tableSubject2">
			<%@ include file="../common/paging.jsp" %>
		</td>
	</tr>
</table>
<jsp:include page="foot.html" />