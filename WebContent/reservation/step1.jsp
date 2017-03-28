<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.PensionData" %>
<%@ page import="reservation.RoomBean" %>
<%@ page import="reservation.ReservationBean" %>
<% 
	request.setCharacterEncoding("euc-kr");
	
	Vector<RoomBean> room = (Vector<RoomBean>)request.getAttribute("room");
	Vector<ReservationBean> reservation = (Vector<ReservationBean>)request.getAttribute("reservation");
	Vector<String> resDate = (Vector<String>)request.getAttribute("resDate");
	PensionData pension = (PensionData)request.getAttribute("pension");
	
	String[] sSeason = pension.getSseason().split("-");
	String[] eSeason = pension.getEseason().split("-");
	for( int i=0; i<2 ; i++ )
		sSeason[0] = (Integer.parseInt(sSeason[0]) < 10) ? "0"+Integer.parseInt(sSeason[0]) : sSeason[0] ;
	for( int i=0; i<2 ; i++ )
		eSeason[0] = (Integer.parseInt(eSeason[0]) < 10) ? "0"+Integer.parseInt(eSeason[0]) : eSeason[0] ;
		
	int sSea = Integer.parseInt(sSeason[0]+sSeason[1]);
	int eSea = Integer.parseInt(eSeason[0]+eSeason[1]);
/*
	if( room != null ){
		for(int i=0; i<room.size();i++){
			out.print(room.get(i).getRno()+" ");
			out.print(room.get(i).getRname()+" ");
			out.print(room.get(i).getRsize()+" ");
			out.print(room.get(i).getMen()+" ");
			out.print(room.get(i).getAddman()+" ");
			out.print(room.get(i).getWeekday()+" ");
			out.print(room.get(i).getWeekend()+" ");
			out.print(room.get(i).getSweekday()+" ");
			out.print(room.get(i).getSweekend()+"<br />");
		}
	}
	out.print("<hr />");
	if(reservation != null){
		for(int i=0; i<reservation.size();i++){
			out.print(reservation.get(i).getRsno()+" ");
			out.print(reservation.get(i).getRno()+" ");
			out.print(reservation.get(i).getUno()+" ");
			out.print(reservation.get(i).getRes_date()+" ");
			out.print(reservation.get(i).getNight()+" ");
			out.print(reservation.get(i).getUsemen()+" ");
			out.print(reservation.get(i).getPrice()+" ");
			out.print(reservation.get(i).getPayment()+" ");
			out.print(reservation.get(i).getPay_number()+" ");
			out.print(reservation.get(i).getPay_yn()+" ");
			out.print(reservation.get(i).getReg_date()+"<br />");
		}
	}
	*/
	// DB에서 넘어온 예약날짜와 기간를 처리하기 위한 선처리(날짜형 데이터로 배열처리)
//	if( resDate != null )
//	for(int i=0; i < resDate.size(); i+=4){
//		out.print(resDate.get(i)+" "+resDate.get(i+1)+" "+resDate.get(i+2)+" "+resDate.get(i+3)+"<br />");
//	}
	
	// 현재 날짜 출력
	Calendar now = Calendar.getInstance();
	int nowYear = now.get(Calendar.YEAR);			// 현재 년
	int nowMonth = now.get(Calendar.MONTH)+1;		// 현재 월
	int nowDate = now.get(Calendar.DATE);			// 현재 일
//	out.print(nowYear+"년 "+nowMonth+"월 "+nowDate+"일");
	
//	out.print("<hr />");
//	out.print("<br />");
//	out.print(request.getAttribute("year")+"/"+request.getAttribute("month"));
	
	String[] day = {"일","월","화","수","목","금","토"};
	int year = Integer.parseInt(request.getAttribute("year").toString());
	int month = Integer.parseInt(request.getAttribute("month").toString());
//	out.print(year+"/"+month);

	// 선택한 월에 이전달
	now.set(year,month-1,1);
	now.add(Calendar.MONTH,-1);
	int laterYear = now.get(Calendar.YEAR);
	int laterMonth = now.get(Calendar.MONTH)+1;
	
	// 선택한 월에 다음달
	now.set(year,month-1,1);
	now.add(Calendar.MONTH,1);
	int nextYear = now.get(Calendar.YEAR);
	int nextMonth = now.get(Calendar.MONTH)+1;
	
	// 달력을 보여주기 위한 선처리 작업
	Calendar cal = Calendar.getInstance();
	cal.set(year, month-1, 1);
	int firstWeekday = cal.get(Calendar.DAY_OF_WEEK);	// 선택월의 1일에 해당하는 요일
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);	// 현재 월의 마지막 날짜
//	out.print("이번달 : "+toYear+" "+(toMonth+1)+" "+firstWeekday+" "+lastDay);	// 확인  년/월/첫날요일값 1~7
	int chkNowDate = month == nowMonth ? nowDate : 0 ;
	if( (year*100)+month == (nowYear*100)+nowMonth ) chkNowDate = nowDate;
	else if( (year*100)+month < (nowYear*100)+nowMonth ) chkNowDate = 32;
	else chkNowDate = 0;
	int count = 1;
	String usedRoom = null;
	String cLinkF = "";
	String cLinkB = "";
	
%>
<html>
	<head>
		<title>펜션예약</title>
		<style type="text/css" lang="stylesheet">
		<!--
			td.center {width:110px;height:30px; text-align:center;}
			td.topLeft {width:110px;height:100px; vertical-align:top; padding:5px 5px 5px 5px;}
			
			#calTitle {font-size:20px;font-weight:bold;}
			#link {font-weight:normal;cursor:hand;}
			#noLink {font-weight:normal;}
			#days {font-weight:bold;}
			#state1 {font-size:11px;}
			#state2 {font-size:11px;}
			#heart {font-size:12px;color:limegreen;padding-right:2px;}
		-->
		</style>
		<script language="javascript">
			// 날짜와 방을 선택
			function chooseRoom(cDate,rno){
			//	document.getElementById("aa").innerHTML=cDate;
				var month = <%= month %>;
				month = (month < 10) ? "0"+month : month;
				var date = (cDate < 10) ? "0"+cDate : cDate;
				document.step2Form.chooseDate.value = <%= year %>+month+date;
				document.step2Form.chooseRno.value = rno;
				document.step2Form.submit();
			}
			// 경고창과포커스처리
			function alertAndFocus(v,str){
				alert(str);
				v.focus();
			}
			// 예약폼이 전달 되기전 체크
			function chkReservation(form){
				if(form.roomNo.value == ""){
					alertAndFocus(form.roomNo,"객실을 선택하세요!");
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body>
		<form name="step2Form" method="post" action="reservation.Reservation">
			<input type="hidden" name="step" value="two" />
			<input type="hidden" name="chooseDate" />
			<input type="hidden" name="chooseRno" />
		</form>
		<table border="1" width="770">
			<tr>
				<td colspan="7">
					<%= "오늘은 - "+nowYear+"년 "+nowMonth+"월 "+nowDate+"일" %>
					<center id="calTitle">
						<a href="reservation.Reservation?y=<%= laterYear %>&m=<%= laterMonth %>">◀</a>
						 <%= year+"년 "+month+"월" %> 
						<a href="reservation.Reservation?y=<%= nextYear %>&m=<%= nextMonth %>">▶</a>
					</center>
				</td>
			</tr>
			<tr>
			<%	for( int i=0; i<day.length ; i++ ){ // 일월화수목금토 출력 for문	%>
				<td class="center" <% if( i == 0 ){out.print("bgcolor='tomato'");}else if( i == 6 ){out.print("bgcolor='skyblue'");}else{out.print("bgcolor='tan'");} %>>
					<%= day[i] %>
				</td>
			<%	}	%>
			</tr>
			<%	while( true ){	%>
				<tr>
				<%	for( int i=0; i<7 ; i++ ){		// 날짜 출력
						if( i<firstWeekday-1 && count == 1 ){ out.print("<td>&nbsp;</td>"); continue; } 
						if( count > lastDay ){out.print("<td>&nbsp;</td>");}else{ %>
							<td class="topLeft" <% if( i == 0 ){out.print("bgcolor='tomato'");}else if( i == 6 ){out.print("bgcolor='skyblue'");} %>>
								<div id="days"><%= count++ %></div>
								<div id="state1">
									<%
										int sChkDate = Integer.parseInt(month+""+(((count-1) < 10) ? "0"+(count-1) : (count-1)));
										if( sChkDate >= sSea && sChkDate <= eSea ) out.print("<b>성수기</b>");
										else out.print("비수기");
									%>
								</div>
								<br />
								<div id="state2">
								<%if( count > chkNowDate )
									if( room != null )
										for( int j=0; j<room.size();j++ ){	// 방갯수 만큼 루프
											String thisDate = (room.get(j).getRno()+"-"+year+"-"+(month < 10 ? "0"+month : month)+"-"+((count-1) < 10 ? "0"+(count-1) : (count-1))).toString();
											if( resDate != null ){
												for( int k=0; k < resDate.size(); k+=4 ){	// 예약날짜 만큼 루프
													if( resDate.get(k).equals(thisDate) ){
														cLinkF = "<b id='noLink' title='예약자\n"+resDate.get(k+2)+"\n"+resDate.get(k+3)+"'>";
														cLinkB = "</b>";
														if( resDate.get(k+1).equals("Y") ){
															usedRoom = "<font color='red'>(완료)</font>"; break;
														}else{
															usedRoom = "<font color='green'>(대기)</font>"; break;
														}
													}else{
														usedRoom = "<font color='blue'>(신청)</font>";
														cLinkF = "<b id='link' onClick='javascript:chooseRoom("+(count-1)+","+room.get(j).getRno()+")'>";
														cLinkB = "</b>";
													}
													//out.print(resDate.get(k)+"/"+thisDate);
												}
											}else{
												usedRoom = "<font color='blue'>(신청)</font>";
												cLinkF = "<b id='link' onClick='javascript:chooseRoom("+(count-1)+","+room.get(j).getRno()+")'>";
												cLinkB = "</b>";
											}
									%>
											<font id="heart">♣</font><%= cLinkF+room.get(j).getRname()+usedRoom+cLinkB %>
											<br />
									<%
										}
									%>
								</div>
							</td>
				<% 		
						}
					}
				%>
				</tr>
			<%	
				if( count > lastDay ) break;	// while 문 종료
			}
			%>
		</table>
	</body>
</html>