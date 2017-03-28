<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*,clientmember.*,java.util.*"%>
<%
	request.setCharacterEncoding("euc-kr");
	String check = request.getParameter("check");
    String dong = request.getParameter("dong");
   
   LogonDBBean Zipcode = LogonDBBean.getInstance();
   Vector zipcodeList = Zipcode.zipcodeRead(dong);
   int totalList = zipcodeList.size(); 
%>
<html>
	<head><title>우편번호 찾기</title>
	<script language="javascript">
		<!--
			function dongCheck(){
				if(document.zipForm.dong.value==""){
					alert("동 이름을 입력하세요.");
					document.zipForm.dong.focus();
					return;
				}
				document.zipForm.submit();
			}

			function sendAddress(zipcode,sido,gugun,dong,ri){
				var address = sido+" "+gugun+" "+dong+" "+ri;
				//값을 분리해서 부모 창에 넣기
				opener.document.memberjoin.zip.value=zipcode;
				opener.document.memberjoin.addr1.value=address;
				self.close();
			}
		-->
	</script>
	<STYLE type="text/css" >
 <!--
    a:link {color:#282828; text-decoration:none;}
       a:hover {color:#1E821E; text-decoration:underline;}
 -->
  </STYLE>
	</head>
	<body>
		<center>
		<font size="5">우편번호찾기</font><p/>
		<form name="zipForm" method="post" action="zip.jsp">
			<center>찾고싶으신 주소의 동(읍/면) 이름을 입력하세요.<br>
						예) 청담1동, 한강로 3가, 수지읍</center><br>
			<center><input type="text" size="30" name="dong">&nbsp;<input type="button" value="검색" onclick= "dongCheck();"></center><br><br>
				
				검색 결과 중 해당 주소를 클릭하시면 자동 입력됩니다.<p/>
			 <input type="hidden" name="check" value="n">
			<table width="600" border="1" bgcolor="yellowgreen">
				<tr>
					<td width="100">우편번호</td>
					<td width="500">주소</td>
				</tr>
		</table>
		</form>
		<table>
		<%
			if(check.equals("n")){
		%>
		<%
				if(zipcodeList.isEmpty()){	
		%>
			
			<tr><td align="center"><br>검색된 결과가 없습니다.</td></tr>
		<%	 } else { %>
		<tr><td>
		<%
			for(int i=0; i<totalList;i++){
				ZipcodeBean zipBean = (ZipcodeBean)zipcodeList.elementAt(i);
				String tempZipcode = zipBean.getZipcode();
				String tempSido = zipBean.getSido();
				String tempGugun = zipBean.getGugun();
				String tempDong = zipBean.getDong();
				String tempRi = zipBean.getRi();
		%>
			<a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempSido%>','<%=tempGugun%>','<%=tempDong%>','<%=tempRi%>')">
				<%=tempZipcode%>&nbsp;<%=tempSido%><%=tempGugun%>&nbsp;<%=tempDong%>&nbsp;<%=tempRi%></a><br>
	<%
		}//for	
		}
	%>
	<%}%>
		</td></tr>
		<tr><td align="center"><br><a href="javascript:this.close();">닫기</a></td></tr>
			</table>
			</center>
	</body>
</html>