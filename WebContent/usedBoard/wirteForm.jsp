<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
    <title>게시판</title>
        <link href="style.css" rel="stylesheet" type="text/css">
        <script language="JavaScript" src="script.js"></script>
</head>

<%
  int num=0,readcount=0,ref=1,re_step=0,re_level=0; // readcount()추가
  try{ 
    if(request.getParameter("num")!=null){
    num=Integer.parseInt(request.getParameter("num"));
    ref=Integer.parseInt(request.getParameter("ref"));
    re_step=Integer.parseInt(request.getParameter("re_step"));
    re_level=Integer.parseInt(request.getParameter("re_level"));
    }
%>
  
<body> 
    <img src=".\img\head02.gif"><br>
       <center><img src=".\img\img02.gif"></center>
    <br>
    <form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
        <input type="hidden" name="num" value="<%=num%>">
        <input type="hidden" name="readcount" value="<%=readcount%>">
        <input type="hidden" name="ref" value="<%=ref%>">
        <input type="hidden" name="re_step" value="<%=re_step%>">
        <input type="hidden" name="re_level" value="<%=re_level%>">

    <table cellspacing="3" align="center" >
      <tr>
        <td><img src="./img/01.gif"></td>		
         <td><input type="text" size="15" maxlength="10" name="writer"></td>	
      </tr>
    
      <tr>
        <td><img src=".\img\05.gif"></td> 
        <td  width="330">
<%    if(request.getParameter("num")==null){%>
        <input type="text" size="40" maxlength="50" name="subject"></td>
<%    }else{    %>
        <input type="text" size="40" maxlength="50" name="subject" value="[답변]"></td>
<%    }    %>
      </tr>
      <tr>
        <td><img src=".\img\03.gif"></td>
        <td  width="330">
           <input type="text" size="30" maxlength="30" name="email" ></td>
      </tr>
      <tr>
        <td><img src=".\img\06.gif"></td>
        <td  width="330" >
         <textarea name="content" rows="13" cols="40"></textarea> </td>
      </tr>
      <tr>
        <td><img src=".\img\02.gif"></td>
        <td  width="330" >
         <input type="password" size="10" maxlength="12" name="passwd">
         </td>
      </tr>
    <tr>     
     <td colspan=2  align="center">
      <input type="image" src="./img/btn_save.gif">
      <a href="javascript:document.writeform.reset();"><img src="./img/btn_return.gif" border="0"></a>
      <input type="image" src="./img/btn_read.gif" 
      OnClick="window.location='list.jsp'" >
    </td></tr></table>   
<%
      }catch(Exception e){}
%>    
    </form>     
</body>
</html>

