<%@ page contentType="text/html;charset=euc-kr"%>
<!--회원가입 MemberJoin-->
<html><head>
<link href="style.css" rel="stylesheet" type="text/css"></link>
<script language="JavaScript" src="MemberJoin.js"></script>
</head>
<body onLoad="idfocus()">
<font size="5">회원가입 및 이용약관</font><p/>
회원가입을 위해서 회원님의 개인정보를 입력해주시기 바랍니다.<p/>
회원정보는 필수기재항목입니다<br><br><br>
<form method="post" action="inputPro.jsp" name="memberjoin" onSubmit="return validMember(this)" >
	<table cellspacing="0" cellpadding="3" border="1" align="center" width="" bordercolor="#FFC0CB">
		<tr>
			<td align="left" width="16%" class="f1">아이디</td><td width="84%"><input type="text" name="id" size="15" style="ime-mode:disabled;">&nbsp;&nbsp;<input type="button" name="btn_id" value="아이디 중복확인" onClick="openConfirmid(this.form)" class="f2">&nbsp;아이디를 입력해주세요.</td>
		</tr>
		<tr>
			<td align="left" class="f1">비밀번호</td><td><input type="password" name="passwd" size="15">&nbsp;비밀번호를 입력해주세요.</td>
		</tr>
		<tr>
			<td align="left" class="f1">비밀번호 확인</td><td><input type="password" name="passwd2" size="15">&nbsp;비밀번호를 입력해주세요.</td>
		</tr>
		<tr>
			<td align="left" class="f1">이름</td><td><input type="text" name="name" size="15">&nbsp;이름을 입력해주세요.</td>
		</tr>
		<tr>
			<td align="left" class="f1">주민등록번호</td><td><input type="text" name="jumin1" size="6" maxlength="6" onKeyUP="moveJumin(this.form)">&nbsp;-&nbsp;<input type="password" name="jumin2" size="7" maxlength="7">&nbsp;&nbsp;<input type="button" name="btn_jumin" value="중복확인" onClick="openConfirmJumin(this.form)" class="f2">&nbsp;주민등록번호를 입력해주세요.</td>
		</tr>
		<tr>
			<td align="left" class="f1">이메일</td><td><input type="text" name="email" size="40">&nbsp;&nbsp;<input type="button" name="btn_email" value="이메일 중복확인" onClick="openConfirmEmail(this.form)" class="f2">&nbsp;이메일을 입력해주세요.</td>
		</tr>
		<tr>
			<td align="left" class="f1">이메일 수신여부</td><td><input type="radio" name="recv_yn" value="y"checked>예&nbsp;&nbsp;<input type="radio" name="recv_yn" value="n">아니오</td>
		</tr>
		<tr>
			<td align="left" class="f1">전화번호</td><td><select name="phone1"><option selected class="f2" value="n">선택하세요
																	<option value="02">서울 (02)</option>
																	<option value="031">경기 (031)</option>
																	<option value="032">인천 (032)</option>
																	<option value="033">강원 (033)</option>
																	<option value="041">충남 (041)</option>
																	<option value="042">대전 (042)</option>
																	<option value="043">충북 (043)</option>
																	<option value="051">부산 (051)</option>
																	<option value="052">울산 (052)</option>
																	<option value="053">대구 (053)</option>
																	<option value="054">경북 (054)</option>
																	<option value="055">경남 (055)</option>
																	<option value="061">전남 (061)</option>
																	<option value="062">광주 (062)</option>
																	<option value="063">전북 (063)</option>
																	<option value="064">제주도 (064)</option>
																	<option value="0502">DACOM (0502)</option>
																	<option value="0505">KT (0505)</option>
															</select>&nbsp;-&nbsp;<input type="text" name="phone2" size="4">&nbsp;-&nbsp;<input type="text" name="phone3" size="4">&nbsp;자택전화번호를 입력해주세요.
													</td>
		</tr>
		<tr>
			<td align="left" class="f1">휴대전화번호</td><td><select name="cell1"><option selected class="f2" value="n">선택하세요
																	<option value="010">010</option>
																	<option value="011">011</option>
																	<option value="013">013</option>
																	<option value="016">016</option>
																	<option value="017">017</option>
																	<option value="018">018</option>
																	<option value="019">019</option>
																	<option value="0502">0502</option>
																	<option value="0505">0505</option>
																	<option value="0506">0506</option>
																</select>&nbsp;-&nbsp;<input type="text" name="cell2" size="4">&nbsp;-&nbsp;<input type="text" name="cell3" size="4">&nbsp;휴대전화번호를 입력해주세요.
															</td>
		</tr>
		<tr>
			<td align="left" class="f1">주소</td><td><input type="text" name="zip" size="7" maxlength="7" readonly>&nbsp;<input type="button" name="btnzip" value="우편번호찾기" onClick="findZip()" class="f2"><p/><input type="text" name="addr1" size="50"><p/><input type="text" name="addr2" size="50"></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="submit" name="btnsubmit" value="확인" class="f2">&nbsp;&nbsp;<input type="reset" name="btnreset" value="다시입력" class="f2"></td>
		</tr>
	</table>
		<input type="hidden" name="idCheck" value="no"> 
		<input type="hidden" name="juminCheck" value="no"> 
		<input type="hidden" name="emailCheck" value="no"> 
	</form>
</body>
</html>