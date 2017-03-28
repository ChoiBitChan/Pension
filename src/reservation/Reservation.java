package reservation;

import java.io.IOException;
import java.util.Calendar;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import reservation.ActionBean;

public class Reservation extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		requestPro(request,response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		requestPro(request,response);
	}

	private void requestPro(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("euc-kr");
		String step = request.getParameter("step");
		String path = null;
		if(step == null || step.equals("one")){
			path = "/reservation/step1.jsp";
			Calendar rightNow = Calendar.getInstance();
			String nowYear = Integer.toString(rightNow.get(Calendar.YEAR));
			String nowMonth = (rightNow.MONTH+1) < 10 ? "0"+(rightNow.MONTH+1) : (rightNow.MONTH+1)+"";
			
			String year = (request.getParameter("y") == null ? nowYear : request.getParameter("y"));
			String month = (request.getParameter("m") == null ? nowMonth : request.getParameter("m"));
			month = Integer.parseInt(month) < 10 ? "0"+month : month;
			
			if( Integer.parseInt(year) < 1981 || year.length() > 4 ){
				year = nowYear;
			}
			if( Integer.parseInt(month) < 1 || Integer.parseInt(month) > 12 || month.length() > 2 ){
				month = nowMonth;
			}
			
			request.setAttribute("year",year);
			request.setAttribute("month",month);
			
			ActionBean action = new ActionBean();
			action.getPensionData(request); // <- 펜션(성수기,계좌정보)
			Vector<RoomBean> room = action.getRoom();
			// 객실(방)정보가 없으면 페이지를 다른곳으로 보냄
			if( room == null ) {
				path = "/reservation/step0.jsp";
			}
			request.setAttribute("room",room);
			Vector<ReservationBean> reservation = action.getReservation(year,month);
			request.setAttribute("reservation",reservation);
			
			if( reservation != null ){
				Vector<String> resDate = action.reservationDate(reservation);
				request.setAttribute("resDate", resDate);
			}else{
			//	request.setAttribute("resDate", "0");
			}
			
		}else if(step.equals("two")){
			path = "/reservation/step2.jsp";
			String cDate = request.getParameter("chooseDate");
			String cRno = request.getParameter("chooseRno");
			ActionBean action = new ActionBean();
			action.getPensionData(request); // <- 펜션(성수기,계좌정보)
			action.getRoom(cRno,request);
			action.getReservation(cRno,cDate,request);
			action.pensionPrice(request);
			
		}else if(step.equals("three")){
			path = "/reservation/step3.jsp";
			request.setAttribute("chooseDate", request.getParameter("chooseDate"));
			request.setAttribute("roomname", request.getParameter("roomname"));
			request.setAttribute("roomnumber", request.getParameter("roomnumber"));
			request.setAttribute("payAll", request.getParameter("payAll"));
			request.setAttribute("cNight", request.getParameter("cNight"));
			request.setAttribute("men", request.getParameter("men"));
			request.setAttribute("id", request.getParameter("id"));
			if( request.getParameter("payment").equals("card") ){
				request.setAttribute("payment", "C");
				request.setAttribute("cardName", request.getParameter("cardName"));
				request.setAttribute("cardNumber", request.getParameter("cardNumber"));
			}else if( request.getParameter("payment").equals("bank") ){
				request.setAttribute("payment", "V");
			}
			
			ActionBean action = new ActionBean();
			action.getPensionData(request); // <- 펜션(성수기,계좌정보)
			action.setReservation(request);
			
		}else{
			path = "/reservation/step1.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request,	response);
	}

}