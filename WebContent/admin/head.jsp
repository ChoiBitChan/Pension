<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>
<%
	String checkAdmin = "";
	try{
		checkAdmin = session.getAttribute("ultraId").toString();
	}catch(NullPointerException e){
		checkAdmin = "";
	}finally{
		if( !checkAdmin.equals("admin") ){
%>
		<script language='javascript'>
			location.href='/pension/servlet/reservation.Reservation';
		</script>
<%
		}
	}
%>
<html>
	<head>
		<title>펜션 관리자 모드</title>
		<link rel="stylesheet" type="text/css" href="./css/admin.css" />
	</head>
	<body>
		<table border="1">
			<tr>
				<th class="tableSubject1">펜션 관리자 입니다.</th>
			</tr>
			<tr>
				<td class="tableSubject2">&nbsp;&nbsp;
					<a href="logout.jsp">로그 아웃</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="common.jsp">펜션관리</a> &nbsp;&nbsp;|&nbsp;&nbsp;
					<a href="member.jsp">회원관리</a> &nbsp;&nbsp;|&nbsp;&nbsp;
					<a href="room.jsp">객실관리</a> &nbsp;&nbsp;|&nbsp;&nbsp;
					<a href="reservationList.jsp">예약확인</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="../index.jsp">사용자 화면으로..</a>
				</td>
			</tr>
		</table>
		<hr />