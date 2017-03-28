package reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Vector;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

public class ActionBean {
	
	public ActionBean(){}
	
	// Connection Pool
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/iljunoracle");
		return ds.getConnection();
	}
	
	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	// 성수기기간,계좌정보
	public void getPensionData(HttpServletRequest request){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PUBLICPENSION";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				PensionData ps = new PensionData();
				ps.setSseason(rs.getString("sseason"));
				ps.setEseason(rs.getString("eseason"));
				ps.setBankname(rs.getString("bankname"));
				ps.setBanknumber(rs.getString("banknumber"));
				ps.setBankuser(rs.getString("bankuser"));
				request.setAttribute("pension", ps);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
	}
	
	// 방정보 검색
	public Vector<RoomBean> getRoom(){
		Vector<RoomBean> rooms = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM ROOM ORDER BY RNO ASC";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				rooms = new Vector<RoomBean>();
				do{
					RoomBean room = new RoomBean();
					room.setRno(rs.getInt("rno"));			// 고유번호 primary key
					room.setRname(rs.getString("rname"));	// 방이름
					room.setRsize(rs.getInt("rsize"));		// 방크기
					room.setMen(rs.getInt("men"));			// 최대인원수-기본:2명
					room.setAddman(rs.getInt("addman"));	// 추가인원당 금액
					room.setWeekday(rs.getInt("weekday"));	// 주중가격
					room.setWeekend(rs.getInt("weekend"));	// 주말가격
					room.setSweekday(rs.getInt("sweekday"));// 성수기주중가격
					room.setSweekend(rs.getInt("sweekend"));// 성수기
					rooms.add(room);
				}while(rs.next());	
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return rooms;
	}
	
	// 방정보 검색 (선택된 방 검색)
	public void getRoom(String cRno,HttpServletRequest request){
		int rNo = Integer.parseInt(cRno);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM ROOM WHERE RNO=?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rNo);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				RoomBean room = new RoomBean();
				room.setRno(rs.getInt("rno"));			// 고유번호 primary key
				room.setRname(rs.getString("rname"));	// 방이름
				room.setMen(rs.getInt("men"));			// 최대인원수-기본:2명
				room.setAddman(rs.getInt("addman"));	// 추가인원수
				room.setWeekday(rs.getInt("weekday"));	// 주중가격
				room.setWeekend(rs.getInt("weekend"));	// 주말가격
				room.setSweekday(rs.getInt("sweekday"));// 성수기주중가격
				room.setSweekend(rs.getInt("sweekend"));// 성수기
				request.setAttribute("room",room);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
	}
	
	// 예약정보 검색
	public Vector<ReservationBean> getReservation(String year,String month){
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(year),Integer.parseInt(month),1);
		cal.add(Calendar.MONTH, -1);
		String year2 = cal.get(Calendar.YEAR)+"";
		String month2 = (cal.get(Calendar.MONTH) < 10) ? "0"+cal.get(Calendar.MONTH): cal.get(Calendar.MONTH)+"";
		
		Vector<ReservationBean> reservations = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM RESERVATION r " +
					 "LEFT OUTER JOIN MEMBER m " +
					 "ON r.uno=m.mno " +
					 "WHERE TO_CHAR(RES_DATE,'YYYYMM') between ? and ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, year2+month2);
			pstmt.setString(2, year+month);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				reservations = new Vector<ReservationBean>();
				do{
					ReservationBean reservation = new ReservationBean();
					reservation.setRsno(rs.getInt("rsno"));
					reservation.setRno(rs.getInt("rno"));
					reservation.setUno(rs.getInt("uno"));
					reservation.setRes_date(rs.getDate("res_date"));
					reservation.setNight(rs.getInt("night"));
					reservation.setUsemen(rs.getInt("usemen"));
					reservation.setPrice(rs.getInt("price"));
					reservation.setPayment(rs.getString("payment"));
					reservation.setPay_name(rs.getString("pay_name"));
					reservation.setPay_number(rs.getString("pay_number"));
					reservation.setPay_yn(rs.getString("pay_yn"));
					reservation.setReg_date(rs.getDate("reg_date"));
					reservation.setUsername(rs.getString("name"));
					reservation.setUsercell(rs.getString("cell1")+"-****-"+rs.getString("cell3"));
					reservations.add(reservation);
				}while(rs.next());
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return reservations;
	}
	
	// 예약정보 검색
	public void getReservation(String cRno,String cDate,HttpServletRequest request){
		int maxRange = 1;
		String cDate2 = (Integer.parseInt(cDate) + 10000)+"";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT MIN(RES_DATE)-TO_DATE(?,'YYYYMMDD') FROM RESERVATION WHERE RNO=? AND TO_CHAR(RES_DATE,'YYYYMMDD') BETWEEN ? AND ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cDate);
			pstmt.setString(2, cRno);
			pstmt.setString(3, cDate);
			pstmt.setString(4, cDate2);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				if( rs.getString(1) == null ) maxRange = 30;
				else{
					maxRange = Integer.parseInt(rs.getString(1));
					if(maxRange > 30) maxRange = 30;
				}
			}
			request.setAttribute("maxRange", maxRange);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
	}
	
	/** 이하 데이타 가공 처리 메소드들 */
	
	// DB에서 넘어온 예약날짜와 기간를 처리하기 위한 선처리(날짜를 문자형데이터로 배열처리)
	public Vector<String> reservationDate(Vector<ReservationBean> reservation){
		Vector<String> regDate = new Vector<String>();
		for(int i=0;i<reservation.size();i++){
			Calendar rDateEnd = Calendar.getInstance();
			rDateEnd.setTime(reservation.get(i).getRes_date());
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			for( int j=0; j<reservation.get(i).getNight();j++ ){
				regDate.add(reservation.get(i).getRno()+"-"+sdf.format(rDateEnd.getTime()));
				regDate.add(reservation.get(i).getPay_yn());
				regDate.add(reservation.get(i).getUsername());
				regDate.add(reservation.get(i).getUsercell());
				rDateEnd.add(Calendar.DATE,1);
			}
		}
		return regDate;
	}
	
	// 선택한 방에 기간별 가격(성수기,주말등에 따른 변동 가격정리)
	public void pensionPrice(HttpServletRequest request){
		RoomBean room = (RoomBean)request.getAttribute("room");		// 방정보(비수기 성수기 주말 주중 가격)
//		RoomBean date1 = (RoomBean)request.getAttribute("date1");	// 선택가능 날짜수
		String chooseDate = (String)request.getParameter("chooseDate");		// 선택한 날짜
		PensionData pension = (PensionData)request.getAttribute("pension");	// 펜션에 공통데이타(계좌정보,성수기기간)
		String[] sSeason = pension.getSseason().split("-");
		String[] eSeason = pension.getEseason().split("-");
		for( int i=0; i<2 ; i++ )
			sSeason[0] = (Integer.parseInt(sSeason[0]) < 10) ? "0"+Integer.parseInt(sSeason[0]) : sSeason[0] ;
		for( int i=0; i<2 ; i++ )
			eSeason[0] = (Integer.parseInt(eSeason[0]) < 10) ? "0"+Integer.parseInt(eSeason[0]) : eSeason[0] ;
		int sSea = Integer.parseInt(chooseDate.substring(0,4)+sSeason[0]+sSeason[1]);
		int eSea = Integer.parseInt(chooseDate.substring(0,4)+eSeason[0]+eSeason[1]);
		
		int maxRange = (int)(Integer)request.getAttribute("maxRange");
//		System.out.print(chooseDate+" ");
		String[] da = {"일","월","화","수","목","금","토"};
		Calendar chooseCal = Calendar.getInstance();
		chooseCal.set(Integer.parseInt(chooseDate.substring(0,4)),Integer.parseInt(chooseDate.substring(4,6))-1,Integer.parseInt(chooseDate.substring(6,8)));
		int[] price = new int[maxRange];
		String[] days = new String[maxRange];
		for( int i=0; i<maxRange ; i++ ){

			int chkDate = Integer.parseInt(chooseCal.get(Calendar.YEAR)+""+((chooseCal.get(Calendar.MONTH)+1) < 10 ? "0"+(chooseCal.get(Calendar.MONTH)+1) : chooseCal.get(Calendar.MONTH)+1) +""+chooseCal.get(Calendar.DATE));
			int day = chooseCal.get(Calendar.DAY_OF_WEEK);	// 선택날에 해당하는 요일 [일요일=1 1~7]
//			System.out.print(day+" ");
			days[i] = da[day-1];
			
			chooseCal.add(Calendar.DAY_OF_MONTH, 1);
//			System.out.print(chooseCal.DAY_OF_MONTH+" ");
						
			if( chkDate >= sSea && chkDate <= eSea ){	// 성수기
				if( day == 1 || day == 7 ){	// 일요일 또는 토요일 (주말)
					price[i] = room.getSweekend();
				}else{ // 성수기 평일
					price[i] = room.getSweekday();
				}
			}else{	// 비수기
				if( day == 1 || day == 7 ){	// 일요일 또는 토요일 (주말)
					price[i] = room.getWeekend();
				}else{ // 비수기 평일
					price[i] = room.getWeekday();
				}
			}
			
		} // for 문끝
		request.setAttribute("roomPrice", price);
		request.setAttribute("days", days);
	}
	
	// ID 값으로 회원 번호 알아내기
	private int getMno(String id){
		int mno = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT MNO FROM MEMBER WHERE ID=?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				mno = rs.getInt("mno");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return mno;
	}
	
	// 예약 데이터 입력
	public synchronized void setReservation(HttpServletRequest request){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int night = Integer.parseInt((String)request.getAttribute("cNight"));
		String chooseDate = request.getAttribute("chooseDate").toString();
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(chooseDate.substring(0,4)),Integer.parseInt(chooseDate.substring(4,6))-1,Integer.parseInt(chooseDate.substring(6,8)));
		cal.add(Calendar.DATE,night-1);
		
		int rno = Integer.parseInt((String)request.getAttribute("roomnumber"));
		String sDate = chooseDate;
		String eDate = cal.get(Calendar.YEAR)+"";
		String a = ((cal.get(Calendar.MONTH)+1) < 10) ? "0"+(cal.get(Calendar.MONTH)+1) : (cal.get(Calendar.MONTH)+1)+"";
		String b = (cal.get(Calendar.DATE) < 10) ? "0"+cal.get(Calendar.DATE) : cal.get(Calendar.DATE)+"";
		eDate = eDate + a + b;
		
		// request 로 넘어온 아이디 값으로 primary key 값 알아오기
		int uno = getMno(request.getAttribute("id").toString());
		
		String res_date = chooseDate;
		
		int usemen = Integer.parseInt((String)request.getAttribute("men"));
		usemen += 2;
		int price = Integer.parseInt((String)request.getAttribute("payAll"));
		String payment = request.getAttribute("payment").toString();
		String pay_name = "",pay_number = "",pay_yn = "";
		if( payment.equals("C") ){
			pay_name = request.getAttribute("cardName").toString();
			pay_number = request.getAttribute("cardNumber").toString();
			pay_yn = "Y";
		}else if(payment.equals("V")){
			PensionData pension = (PensionData)request.getAttribute("pension");
			pay_name = pension.getBankname();
			pay_number = pension.getBanknumber();
			pay_yn = "N";
		}
				
		String SQL = "SELECT COUNT(*) FROM RESERVATION WHERE RNO=? AND TO_CHAR(RES_DATE,'YYYYMMDD') BETWEEN ? AND ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rno);
			pstmt.setString(2, sDate);
			pstmt.setString(3, eDate);
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				if( rs.getInt(1) == 0 ){
					SQL = "INSERT INTO RESERVATION VALUES(RESERVATION_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,SYSDATE)";
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, rno);
					pstmt.setInt(2, uno);
					pstmt.setString(3, res_date);
					pstmt.setInt(4, night);
					pstmt.setInt(5, usemen);
					pstmt.setInt(6, price);
					pstmt.setString(7, payment);
					pstmt.setString(8, pay_name);
					pstmt.setString(9, pay_number);
					pstmt.setString(10, pay_yn);
					int result = pstmt.executeUpdate();
					request.setAttribute("insertResult", result);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
	}
	
	// 예약 확인
	public Vector<ReservationBean> confirmBook(String id){
		Vector<ReservationBean> reservations = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT RM.RNAME,R.* FROM RESERVATION R " +
					 "LEFT OUTER JOIN MEMBER J " +
					 "ON R.UNO=J.MNO " +
					 "LEFT OUTER JOIN ROOM RM " + 
					 "ON R.RNO=RM.RNO " +
					 "WHERE ID=? " +
					 "ORDER BY RES_DATE DESC";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if( rs.next() ){
				reservations = new Vector<ReservationBean>();
				do{
					ReservationBean reservation = new ReservationBean();
					reservation.setRsno(rs.getInt("rsno"));
					reservation.setRno(rs.getInt("rno"));
					reservation.setUno(rs.getInt("uno"));
					reservation.setRes_date(rs.getDate("res_date"));
					reservation.setNight(rs.getInt("night"));
					reservation.setUsemen(rs.getInt("usemen"));
					reservation.setPrice(rs.getInt("price"));
					reservation.setPayment(rs.getString("payment"));
					reservation.setPay_name(rs.getString("pay_name"));
					reservation.setPay_number(rs.getString("pay_number"));
					reservation.setPay_yn(rs.getString("pay_yn"));
					reservation.setReg_date(rs.getDate("reg_date"));
					reservation.setRoomname(rs.getString("rname"));
					reservations.add(reservation);
				}while(rs.next());
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return reservations;
	}
	
	// 입금완료 처리
	public void setPayOk(int rsno){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE RESERVATION SET PAY_YN='Y' WHERE RSNO=?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rsno);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(null,pstmt,conn);
		}
	}
	
}