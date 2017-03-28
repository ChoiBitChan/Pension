<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="reservation.RoomBean" %>
<%@ page import="reservation.PensionData" %>
<%@ page import="java.text.NumberFormat" %>
<%
	String id = null;
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
	
	request.setCharacterEncoding("euc-kr");
	
	NumberFormat nf = NumberFormat.getInstance();

	PensionData pension = (PensionData)request.getAttribute("pension");
	RoomBean room = (RoomBean)request.getAttribute("room");
	RoomBean date1 = (RoomBean)request.getAttribute("date1");
	int maxMen = room.getMen();
	int maxRange = (int)(Integer)request.getAttribute("maxRange");
	int[] price = (int[])request.getAttribute("roomPrice");
	String[] days = (String[])request.getAttribute("days");
	
	String chooseDate = request.getParameter("chooseDate").toString();
%>
<html>
	<head>
		<title>펜션예약 스탭 투</title>
		<script language="javascript">
			function number_format(numstr) {
				var numstr = String(numstr);
				var re0 = /(\d+)(\d{3})($|\..*)/;
				if (re0.test(numstr)) 
					return numstr.replace( 
					  re0, 
					  function(str,p1,p2,p3) { return number_format(p1) + "," + p2 + p3; } 
					); 
				else 
					return numstr; 
			}

			function calculateMoney(){
				var payMoney = 0;
				var price = new Array(<% for(int i=0; i<price.length; i++){ out.print(price[i]+","); } out.print("0"); %>);
				var addManPrice = <%= room.getAddman() %>;
				var cNight = document.resForm.cNight.value;
				var addMan = document.resForm.men.value;
				for( var i=0; i<cNight; i++ ){
					payMoney += price[i];
				};
				for( var i=0; i<addMan; i++ ){
					payMoney += addManPrice;
				}
				document.resForm.payAll.value = payMoney;
				document.getElementById("allMondy").innerHTML=number_format(payMoney)+"원";
			}

			function viewCard(){
				document.getElementById('bank').style.display="none";
				document.getElementById('card').style.display="block";
			}
			function viewBank(){
				document.getElementById('card').style.display="none";
				document.getElementById('bank').style.display="block";
			}

			// 경고창과포커스처리
			function alertAndFocus(v,str){
				alert(str);
				v.focus();
			}

			function payCard(form){
				form.payment.value="card";
				if( form.payAll.value == "" ){
					alert("결제부분에 문제가 발생하였습니다!\n\n다시 신청하세요!");
					history.back(-1);
					return;
				}
				if( form.cardName.value == "" ){
					alertAndFocus(form.cardName,"카드이름을 적으세요!");
					return;
				}
				if( form.cardNumber.value == "" ){
					alertAndFocus(form.cardNumber,"카드번호를 적으세요!");
					return;
				}
				if( form.cardPasswd.value == "" ){
					alertAndFocus(form.cardPasswd,"카드비밀번호를 적으세요!");
					return;
				}
				if( confirm("참말로 카드 결제를 하시겠습니까?") ){
					form.submit();
				}
			}

			function payBank(form){
				form.payment.value="bank";
				if( confirm("참말로 계좌이체(가상계좌)로 신청하시겠습니까?") ){
					form.submit();
				}
			}
		</script>
	</head>
	<body onLoad="calculateMoney()">
		<form name="resForm" method="post" action="reservation.Reservation" onSubmit="return chkReservation(this)">
			<input type="hidden" name="step" value="three" />
			<input type="hidden" name="chooseDate" value="<%= chooseDate %>" />
			<input type="hidden" name="payment" value="" />
			<input type="hidden" name="roomnumber" value="<%= room.getRno() %>" />
			<input type="hidden" name="roomname" value="<%= room.getRname() %>" />
			<input type="hidden" name="payAll" value="" />
			<input type="hidden" name="id" value="<%= id %>" />
			<table border="1" width="500"> 
				<tr>
					<td colspan="2">선택 객실 예약하기</td>
				</tr>
				<tr>
					<td width="100">객실</td>
					<td><%= room.getRname() %></td>
				</tr>
				<tr>
					<td>선택일자</td>
					<td><%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일 "+days[0]+"요일" %></td>
				</tr>
				<tr>
					<td>숙박일수</td>
					<td>
						<select name="cNight" onChange="calculateMoney()">
						<% for(int i=1; i<maxRange+1 ; i++){ %>
							<option value="<%= i %>" /><% out.print(i+"박 "+(i+1)+"일 "); out.print(days[i-1]+"요일 +"); out.print(nf.format(price[i-1])+"원"); %>
						<% } %>
						</select>
						<br />
						비수기평일 <%= nf.format(room.getWeekday()) %>원 추가<br />
						비수기주말 <%= nf.format(room.getWeekend()) %>원 추가<br />
						성수기평일 <%= nf.format(room.getSweekday()) %>원 추가<br />
						성수기주말 <%= nf.format(room.getSweekend()) %>원 추가
					</td>
				</tr>
				<tr>
					<td>인원추가</td>
					<td>
						<select name="men" onChange="calculateMoney()">
							<option value="0" />기본2명
						<% for(int i=1; i<maxMen-1 ; i++){ %>
							<option value="<%= i %>" /><%= i %>명
						<% } %>
						</select>추가 (한명 추가당 <%= nf.format(room.getAddman()) %>원 추가)
					</td>
				</tr>
				<tr>
					<td>총 결제금액</td>
					<td><b id="allMondy"></b></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="카드결제" onClick="viewCard()" />
						<input type="button" value="계좌이체" onClick="viewBank()" />
					</td>
				</tr>
			</table>
			<!-- 카드결제 -->
			<table id="card" border="1" width="500" style="display:none">
				<tr>
					<td colspan="2">카드 안심 결제</td>
				</tr>
				<tr>
					<td width="100">카드이름</td>
					<td><input type="text" size="30" name="cardName" /></td>
				</tr>
				<tr>
					<td>카드번호</td>
					<td><input type="text" size="30" name="cardNumber" /></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" size="30" name="cardPasswd" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="결제하기" onClick="payCard(this.form)" /></td>
				</tr>
			</table>
			<!-- 계좌이체 -->
			<table id="bank" border="1" width="500" style="display:none">
				<tr>
					<td colspan="2">계좌이체(가상계좌)</td>
				</tr>
				<tr>
					<td width="100">은행명</td>
					<td width="400"><%= pension.getBankname() %></td>
				</tr>
				<tr>
					<td>계좌번호</td>
					<td><%= pension.getBanknumber() %></td>
				</tr>
				<tr>
					<td>예금주</td>
					<td><%= pension.getBankuser() %></td>
				</tr>
				<tr>
					<td colspan="2">입금신청 후 24시간동안 입금이 확인되지 않을시에는 <br />자동으로 취소됩니다.</td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="입금신청" onClick="payBank(this.form)" /></td>
				</tr>
			</table>
		</form>
	</body>
</html>
