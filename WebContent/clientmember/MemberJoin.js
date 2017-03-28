function memberReg(){
	document.location="MemberJoin.jsp";
}

//페이지를 열었을 때 커서가 id칸에 위치하도록
function idfocus(){
	window.document.memberjoin.id.focus();
}

// 아이디 중복 확인
function openConfirmid(mfrm){
		if(mfrm.id.value==""){
		alert("id는 필수입력사항입니돠.");
		mfrm.id.focus();
		return false;
	}
	url="confirmId.jsp?id=" + mfrm.id.value;
	
	open(url,"confirm","toolbar=no, location=no,status=no,menubar=no, scrollbars=no,resizable=no,width=300,height=200");

}

// 주민번호 앞자리 다 쳤을 때 다음 칸으로 이동
function moveJumin(mfrm){
	if(mfrm.jumin1.value.length==6){
		mfrm.jumin2.focus();
	}
}

// 주민번호 중복 확인
function openConfirmJumin(mfrm){
	if(mfrm.jumin1.value=="" && mfrm.jumin2.value==""){
		alert("주민등록번호는 필수입력사항이라규!");
		mfrm.jumin1.focus();
		return false;
	}
	
	url="confirmJumin.jsp?jumin1=" + mfrm.jumin1.value + "&jumin2=" + mfrm.jumin2.value;
	open(url,"confirm","toolbar=no, location=no,status=no,menubar=no, scrollbars=no,resizable=no,width=300,height=200");

}

// 이메일 중복 확인
function openConfirmEmail(mfrm){
	if(mfrm.email.value==""){
		alert("이메일은 필수입력사항임");
		mfrm.email.focus();
		return false;
	}
	url="confirmEmail.jsp?email=" + mfrm.email.value;
	open(url,"confirm","toolbar=no, location=no,status=no,menubar=no, scrollbars=no,resizable=no,width=300,height=200");

}

// 우편번호 찾기
function findZip(){
	url="zip.jsp?check=y";
	window.open(url,"zip","toolbar=no, width=700, height=500, directories=no, status=yes, scrollbars=yes, menubar=no");
}

function validMember(mfrm){
	if(mfrm.id.value==""){
		alert("아이디는 필수입력사항입니돠.");
		mfrm.id.focus();
		return false;
	}
	

	/*var ptn = new RegExp('[^a-zA-Z0-9]'); //정규식을 이용한 숫자, 영문만을 허용하는 패턴

	if( ptn.test(mfrm.id.value) ) {
	  alert("숫자, 영문만 입력이 가능하다.. 다시 입력해라.");
	  mfrm.id.value = "";
	  mfrm.id.value();
	  return;
	}*/

	

	if(mfrm.id.value.length<4 || mfrm.id.value.length>12){
		alert("id는 4~12자입니당.");
		mfrm.id.focus();
		return false;
	}

	if(mfrm.passwd.value=="" || mfrm.passwd2.value==""){
		alert("비밀번호는 필수입력사항임돠.");
		mfrm.passwd.focus();
		return false;
	}


	 /*var str = mfrm.member_name.value;
	 r0=/[A-z]/gi;
	 r1=/[0-9]/gi;
	 t0=str.search(r0);
	 t1=str.search(r1);
	 if(t0!=-1&&t1!=-1){
	  alert('혼용');
	 } else {
	  alert('안 혼용');
	 }*/

	if(mfrm.passwd.value != mfrm.passwd2.value){
		alert("비밀번호는 같아야함!");
		mfrm.passwd.value="";
		mfrm.passwd2.value="";
		mfrm.passwd.focus();
		return false;
	}
	
	if(mfrm.name.value==""){
		alert("이름은 필수입력사항입니돠.");
		mfrm.name.focus();
		return false;
	}

	
	/*var jumin1=mfrm.jumin1.value;
	var jumin2=mfrm.jumin2.value;
	var jumin=jumin1+jumin2;
	var index="234567892345";
	var total=0;
	for(var i=0;i<12;i++)
		total+=parseInt(jumin.charAt(i)*index.charAt(i));

	total=11-total%11;
	if(total==10)
		total=0;
	else if(total==11)
		total=1;

	if(total!=jumin.charAt(13))
	{
		alert("주민번호를 다시 확인하세요.");
		mfrm.jumin1.value="";
		mfrm.jumin2.value="";
		mfrm.jumin1.focus();
		return false;
	}*/
	
	if (mfrm.jumin1.value=="" || mfrm.jumin2.value==""){
		  alert("주민번호는 필수입력사항이오.");
		  mfrm.jumin1.focus();
		  return false;
	}
	
	var result = isNaN(mfrm.jumin1.value);
	if( result || isNaN(mfrm.jumin2.value) ){
		alert("주민번호는 숫자로 입력하세요");
		mfrm.jumin1.value="";
		mfrm.jumin2.value="";
		mfrm.jumin1.focus();
		return false;
	}
	
	var str=mfrm.email.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	      mfrm.email.focus();
		  return false;
    }

	if(mfrm.cell1.value=="" || mfrm.cell2.value=="" || mfrm.cell3.value==""){
		alert("휴대전화번호는 필수입력사항입니돠.");
		mfrm.cell1.focus();
		return false;
	}
	
	if(mfrm.zip.value==""){
		alert("주소는 필수입력사항입니돠.");
		mfrm.btnzip.focus();
		return false;
	}

	//아이디 중복검사를 안 했을 경우
	if(mfrm.idCheck.value != "yes"){
		alert("아이디 중복검사 버튼을 눌러주셩.");
		mfrm.btn_id.focus();
		return false;
	}


	// 주민등록번호 중복확인을 안 했을 경우 
	
	if(mfrm.juminCheck.value != "yes"){
		alert("주민번호 중복검사 버튼을 눌러주셩.");
		mfrm.btn_jumin.focus();
		return false;
	}

	// 이메일 중복확인을 안 했을 경우 
	if(mfrm.emailCheck.value != "yes"){
		alert("이메일 중복검사 버튼을 눌러주셩.");
		mfrm.btn_email.focus();
		return false;
	}

	alert("회원 가입이 완료되었습니다.\n확인을 누르시면 넘어갑니다."); 
    return true; // 최종적으로 false 가 없을 때 값을 true 하여 넘겨줌

}