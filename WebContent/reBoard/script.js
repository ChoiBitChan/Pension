function writeSave(){
	
	if(document.writeform.writer.value==""){
	  alert("이름없냐?");
	  document.writeform.writer.focus();
	  return false;
	}
	if(document.writeform.subject.value==""){
	  alert("제목은??");
	  document.writeform.subject.focus();
	  return false;
	}
	
	if(document.writeform.content.value==""){
	  alert("냉무(無)사절");
	  document.writeform.content.focus();
	  return false;
	}
        
	if(document.writeform.passwd.value==""){
	  alert("좀하나라도 제대로해라~");
	  document.writeform.passwd.focus();
	  return false;
	}
 }    

