<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    import="java.util.Vector"
    import="reservation.ActionBean"
    import="reservation.ReservationBean"
%>
<%
	String id="";
	try{
		id = session.getAttribute("memId").toString();
	}catch(NullPointerException e){
%>
	<script language="javascript">
		alert("예약은 회원만 가능합니다!");
		location.href="../servlet/reservation.Reservation";
	</script>
<%
	}
	if( id.equals("") ){
%>
	<script language="javascript">
		alert("예약 확인은 로그인을 하여야 합니다.");
//		location.href="../index.jsp";
	</script>
<%
	}else{
%>
<h3>예약 목록 입니다.</h3>
<table border="1">
	<tr>
		<td class="tableSubject2">번호</td>
		<td class="tableSubject2">객실이름</td>
		<td class="tableSubject2">사용인원</td>
		<td class="tableSubject2">결제금액</td>
		<td class="tableSubject2">결제방법</td>
		<td class="tableSubject2">결제유무</td>
		<td class="tableSubject2">예약날짜</td>
		<td class="tableSubject2">숙발일수</td>
		<td class="tableSubject2">신청날짜</td>
	</tr>
<%
	Vector<ReservationBean> vrb = new ActionBean().confirmBook(id);
	
	if( vrb == null ){
%>
	<tr>
		<td colspan="11">[ 찾으시는 내용이 없습니다 ]</td>
	</tr>
<% 	}else{
		for( int i=0; i<vrb.size(); i++ ){
			ReservationBean rb = vrb.get(i);
%>
	<tr>
		<td><%= i+1 %></td>
		<td><%= rb.getRoomname() %></td>
		<td><%= rb.getUsemen() %></td>
		<td><%= rb.getPrice() %></td>
		<td><%= rb.getPay_name() %></td>
		<td><%= rb.getPay_yn() %></td>
		<td><%= rb.getRes_date() %></td>
		<td><%= rb.getNight() %></td>
		<td><%= rb.getReg_date() %></td>
	</tr>
<% 		}
	} %>
</table>
<% 	} %>