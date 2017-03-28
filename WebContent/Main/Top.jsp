<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
<meta http-equiv=content-type content="text/html; charset=euc-kr"> 
<link rel="stylesheet" type="text/css" href="../css/client.css" />
	<style>
	<!--
	.clsMenuTitle { 
	         cursor:hand; 
	}
	.clsMenu { 
	        border:solid 1; border-color:#cccccc white white #cccccc; background-color:#ADAEAD; 
	        position:absolute; visibility:hidden; padding:1px; width:90px; z-index:2; padding-left:7px; 
	        font-family:verdana; font-size:8pt;line-height:17px; 
	}
	.clsMenu A { 
	        text-decoration:none; color:#ffffff; 
	        }
	.clsMenu A:hover { 
	        color:#99ff66; 
	}
	
	.TBottom {
	        BORDER-BOTTOM: #99ccff 2px groove;
	        BORDER-TOP: #003366 1px solid; 
	        COLOR: #ffffff; 
	        FONT-SIZE: 8pt; 
	        MARGIN-TOP: 1px;}
	
	-->
	</style>
<!-- -->
        <script>
       <!--
        var sOpenMenuID = "";
        var iChunk = 0;
        var iChunkStep = 15;
        var iChunkDelay = 10;
        var sMenuPos = "below";   
        var sMenuStyle = "down";       
        function DoMenu() 
        {
                window.event.cancelBubble = true;
                var eSrc = window.event.srcElement;
                var subMwnuWidth;
     
                switch (eSrc.id){
                case        "imgMenuTitle1" :
                        subMwnuWidth = 13;
                        break;
                case        "imgMenuTitle2" :
                        subMwnuWidth = 132;
                        break;
                case        "imgMenuTitle3" :
                        subMwnuWidth = 255;
                        break;
                case        "imgMenuTitle4" :
                        subMwnuWidth = 375;
                        break;
                case        "imgMenuTitle5" :
                        subMwnuWidth = 495;
                        break;
                }
                                
           

                if ("object" == typeof(document.all[sOpenMenuID])) 
                {
                        document.all[sOpenMenuID].style.visibility = "hidden";

                       

                        if (sOpenMenuID == eSrc.id.replace("imgMenuTitle","divMenu"))
                        {
                                sOpenMenuID = "";
                                return false;
                        }
                        else 
                        {
                                sOpenMenuID = "";
                        }
                }

               
                if ("clsMenuTitle" == eSrc.className) 
                {


                        window.event.returnValue = false;

                        sOpenMenuID = eSrc.id.replace("imgMenuTitle","divMenu")
                        if ("object" == typeof(document.all[sOpenMenuID])) 
                        {
                                var eMenu = document.all[sOpenMenuID];
                                iChunk = iChunkStep;


                                var eTD = eSrc.parentElement.parentElement.parentElement
                                var eTABLE = eTD.parentElement.parentElement;

                                if ("below" == sMenuPos) 
                                {
                                        eMenu.style.left = subMwnuWidth;
                                        eMenu.style.top = 35;
                                }
                                

                              
                                eMenu.style.clip = "rect(0 0 0 0)";
                                eMenu.style.visibility = "visible";
                                return window.setTimeout("ShowMenu(" + eMenu.id + ")", iChunkDelay);
                        }
                }
        }

      

        function GetShowStyle() {
                if ("down" == sMenuStyle) return "rect(0 100% " + iChunk + "% 0)";
                if ("across" == sMenuStyle) return "rect(0 " + iChunk + "% 100% 0)";
                if ("diagonal" == sMenuStyle) return "rect(0 " + iChunk + "% " + iChunk + "% 0)";
                else return "rect(0 100% " + iChunk + "% 0)";
        }


        function ShowMenu(eMenu) {
                eMenu.style.clip = GetShowStyle();
                if (100 >= iChunk) {
                        window.setTimeout("ShowMenu(" + eMenu.id + ")", iChunkDelay);
                }
                iChunk += iChunkStep;
        }

        document.onclick = DoMenu;

        function tagin(frame1,page1,frame2,page2) {
            eval("parent."+frame1+".location='"+page1+"'");
            eval("parent."+frame2+".location='"+page2+"'");
        }
-->
</script>

</head>

<!-- -->
        
        <body bgcolor="white" topmargin="0" leftmargin="0"><div ID="divMenu1" CLASS="clsMenu">
        <a HREF="./Prologue.jsp" target="center">프롤로그</a><br>
        </div>

        <div ID="divMenu2" CLASS="clsMenu">
        <a HREF="javascript:tagin('center','../ImageBoard/Room1.jsp','left','../ImageBoard/RoomMenu.html')">객실보기</a><br>
        <a HREF="javascript:tagin('center','../ImageBoard/Outside.jsp','left','../ImageBoard/OutsideMenu.html')">외부전경</a><br>
        </div>

        <div ID="divMenu3" CLASS="clsMenu">
        <a HREF="../reservation/info.jsp" target="center">예약안내</a><br>
        <a HREF="../servlet/reservation.Reservation" target="center">실시간예약</a><br>
        <a HREF="../reservation/confirmBook.jsp" target="center">예약확인</a><br>
        </div>

        <div ID="divMenu4" CLASS="clsMenu">
        <a HREF="javascript:tagin('center','../ImageBoard/Around.jsp','left','../ImageBoard/AroundMenu.jsp')">주변여행지</a><br>

        </div>
        
        <div ID="divMenu5" CLASS="clsMenu">
        <a HREF="../usedBoard/a.jsp" target="center">공지사항</a><br>
        <a HREF="../reBoard/list.jsp" target="center">예약문의</a><br>
        <a HREF="../usedBoard/list.jsp" target="center">사용후기</a><br>
        <a HREF="../PhotoGallery/PhotoGalleryMain.jsp" target="center">포토갤러리</a><br>
        </div>

<table ID="tblMenu" CELLPADDING="0" CELLSPACING="0" BORDER="0" width="100%" style="height:20px;">
  <tr> 
    <td ALIGN="left"><img ID="imgMenuTitle1" CLASS="clsMenuTitle" src="../project_img/img/prologue.jpg"></td>
    <td ALIGN="left"><img ID="imgMenuTitle2" CLASS="clsMenuTitle" src="../project_img/img/pensionview.jpg"></td>
    <td ALIGN="left"><img ID="imgMenuTitle3" CLASS="clsMenuTitle" src="../project_img/img/reservation.jpg"></td>
    <td ALIGN="left"><img ID="imgMenuTitle4" CLASS="clsMenuTitle" src="../project_img/img/travel.jpg"></td>
    <td ALIGN="left"><img ID="imgMenuTitle5" CLASS="clsMenuTitle" src="../project_img/img/community.jpg"></td>
    <td align="left" width="100%" valign="top" ></td>
    <!-- td align="right"><a href="../clientmember/MemberJoin.jsp" target="center"><img src="../project_img/img/joining.gif" style="border:0;"></a></td>
    <td align="right"><a href="../clientmember/login.jsp" target="left"><img src="../project_img/img/login.gif" style="border:0;"></a></td-->
    <td></td>
    <td></td>
  </tr>
</table>
</body>
</html> 