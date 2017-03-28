<%@ page contentType="text/html; charset=euc-kr" %>
<%
	String str = "";
	if( request.getAttribute("insertResult") == null ){
		str = "이미 예약된 객실입니다. 다시 확인하시고 신청하세요!";
	}else{
		int result = (Integer)request.getAttribute("insertResult");
		if( result == 1 ){
			str = "성공적으로 입력이 완료 되었습니다.";
		}else{
			str = "예약 실패-서버에 사용자가 많습니다. 잠시후 다시 시도하세요!";
		}
	}
%>
<center>
<%= str %>
</center>