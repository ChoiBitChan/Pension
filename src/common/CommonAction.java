package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;

import reservation.ReservationBean;

public class CommonAction {
	
	private static CommonAction instance = new CommonAction();
	
	public CommonAction(){}
	
	// 객체 리턴
	public static CommonAction getInstance(){
		return instance;
	}
	
	// Connection Pool
	private static Connection getConnection() throws Exception {
		Connection connection = null;
			
			try {
				String driver = "oracle.jdbc.driver.OracleDriver";
		   	 	String url = "jdbc:oracle:thin:@localhost:1521:xe";
		    	String uid = "testdb";
		    	String upw = "1234";
				
		    	Class.forName(driver);
				connection = DriverManager.getConnection(url, uid, upw);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			return connection;
	}
	
	// DB Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null;}
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	// commonPro.jsp 처리 수정
	public void updateCommon(CommonBean common){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE PUBLICPENSION SET SSEASON=?,ESEASON=?,BANKNAME=?,BANKNUMBER=?,BANKUSER=?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, common.getSseason());
			pstmt.setString(2, common.getEseason());
			pstmt.setString(3, common.getBankname());
			pstmt.setString(4, common.getBanknumber());
			pstmt.setString(5, common.getBankuser());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(null,pstmt,conn);
		}
	}
	
	// commonPro.jsp 처리 보기
	public CommonBean selectCommon(){
		CommonBean cb = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PUBLICPENSION";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				cb = new CommonBean();
				cb.setSseason(rs.getString("SSEASON"));
				cb.setEseason(rs.getString("ESEASON"));
				cb.setBankname(rs.getString("BANKNAME"));
				cb.setBanknumber(rs.getString("BANKNUMBER"));
				cb.setBankuser(rs.getString("BANKUSER"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return cb;
	}
	
	// room.jsp 방추가
	public void insertRoom(reservation.RoomBean room){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL,?,?,?,?,?,?,?,?)";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, room.getRname());
			pstmt.setInt(2, room.getRsize());
			pstmt.setInt(3, room.getMen());
			pstmt.setInt(4, room.getAddman());
			pstmt.setInt(5, room.getWeekday());
			pstmt.setInt(6, room.getWeekend());
			pstmt.setInt(7, room.getSweekday());
			pstmt.setInt(8, room.getSweekend());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(null,pstmt,conn);
		}
	}

	// room.jsp 방수정
	public void updateRoom(reservation.RoomBean room){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE ROOM SET RNAME=?,RSIZE=?,MEN=?,ADDMAN=?,WEEKDAY=?,WEEKEND=?,SWEEKDAY=?,SWEEKEND=? WHERE RNO=?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, room.getRname());
			pstmt.setInt(2, room.getRsize());
			pstmt.setInt(3, room.getMen());
			pstmt.setInt(4, room.getAddman());
			pstmt.setInt(5, room.getWeekday());
			pstmt.setInt(6, room.getWeekend());
			pstmt.setInt(7, room.getSweekday());
			pstmt.setInt(8, room.getSweekend());
			pstmt.setInt(9, room.getRno());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(null,pstmt,conn);
		}
	}
	
	// room.jsp 제거
	public void deleteRoom(reservation.RoomBean room){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM ROOM WHERE RNO=?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, room.getRno());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(null,pstmt,conn);
		}
	}

	// reservationList.jsp 리스트출력 예약정보 검색 (시작년월일~완료년월일)
	public Vector<ReservationBean> selectReservation(String sdate,String edate,String card,String bank,String banksub,String searcht,String searchv,int startNum,int endNum){
		Vector<ReservationBean> reservations = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String whereCard = "";
		String whereBank = "";
		String whereBanksub = "";
		String whereSearch = "";
		
		if( card.equals("card") ){
			whereCard = " AND payment='C' ";
		}else if( bank.equals("bank") ){
			whereBank = " AND payment='V' ";
			if( banksub.equals("y") ){
				whereBanksub = " AND pay_yn='Y' ";
			}else if( banksub.equals("n") ){
				whereBanksub = " AND pay_yn='N' ";
			}
		}
		if( card.equals("card") && bank.equals("bank") ){
			whereCard = "";
			whereBank = "";
		}
		if( searcht.length() > 0 && searchv.length() > 0 ){
			whereSearch = " AND "+searcht+" LIKE '%"+searchv+"%' ";
		}

		String SQL = "SELECT * FROM (" +
					 "SELECT ROWNUM AS RNUM,RMR.* FROM (" +
					 "SELECT rsno,rno,uno,res_date,night,usemen,price,payment,pay_name,pay_number,pay_yn,r.reg_date,name,rname,id,cell1,cell2,cell3 FROM RESERVATION r " +
					 "LEFT OUTER JOIN MEMBER m " +
					 "ON r.uno=m.mno " +
					 "LEFT OUTER JOIN ROOM rm " +
					 "ON r.rno=rm.rno " +
					 "WHERE TO_CHAR(RES_DATE,'YYYYMMDD') BETWEEN ? AND ? " +
					 whereCard + whereBank + whereBanksub + whereSearch +
					 " ORDER BY RES_DATE DESC" +
					 ") RMR " +
					 ") WHERE RNUM BETWEEN ? AND ?";
//		System.out.print(SQL+"\n\n");
		String CSQL= "SELECT COUNT(*) FROM RESERVATION r " +
					 "LEFT OUTER JOIN MEMBER m " +
					 "ON r.uno=m.mno " +
					 "LEFT OUTER JOIN ROOM rm " +
					 "ON r.rno=rm.rno " +
					 "WHERE TO_CHAR(RES_DATE,'YYYYMMDD') BETWEEN ? AND ? " +
					 whereCard + whereBank + whereBanksub + whereSearch +
					 " ORDER BY RES_DATE DESC";
		try{
			conn = getConnection();
			if( startNum == 0 && endNum == 0 ){
				pstmt = conn.prepareStatement(CSQL);
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
			}else{
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
				pstmt.setInt(3, startNum);
				pstmt.setInt(4, endNum);
			}

			rs = pstmt.executeQuery();

			if( startNum == 0 && endNum == 0 ){
				if( rs.next() ){
					reservations = new Vector<ReservationBean>();
					ReservationBean reservation = new ReservationBean();
					reservation.setRsno(rs.getInt(1));
					reservations.add(reservation);
				}
			}else{
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
						reservation.setRoomname(rs.getString("rname"));
						reservation.setUserid(rs.getString("id"));
						reservation.setUsercell(rs.getString("cell1")+"-"+rs.getString("cell2")+"-"+rs.getString("cell3"));
						reservations.add(reservation);
					}while(rs.next());
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return reservations;
	}
	
	// member.jsp 회원리스트
	public Vector<MemberBean> selectMember(String searcht,String searchv,int startNum,int endNum){
		Vector<MemberBean> vmb = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String whereSearch = "";
		if( searcht.length() > 0 && searchv.length() > 0 ){
			whereSearch = " WHERE "+searcht+" LIKE '%"+searchv+"%' ";
		}

		String CSQL = "SELECT COUNT(*) FROM MEMBER "+whereSearch;

		String SQL = "SELECT * FROM (SELECT ROWNUM AS RNUM,MEM.* FROM " + 
					 "(SELECT * FROM MEMBER "+whereSearch+" ORDER BY MNO DESC) " + 
					 "MEM) WHERE RNUM BETWEEN ? AND ?";
		try{
			conn = getConnection();
			if( startNum == 0 && endNum == 0 ){
				pstmt = conn.prepareStatement(CSQL);
			}else{
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,startNum);
				pstmt.setInt(2,endNum);
			}
			rs = pstmt.executeQuery();
			if( startNum == 0 && endNum == 0 ){
				if( rs.next() ){
					vmb = new Vector<MemberBean>();
					MemberBean mb = new MemberBean();
					mb.setMno(rs.getInt(1));
					vmb.add(mb);
				}
			}else{
				if( rs.next() ){
					vmb = new Vector<MemberBean>();
					do{
						MemberBean mb = new MemberBean();
						mb.setMno(rs.getInt("mno"));
						mb.setId(rs.getString("id"));
						mb.setName(rs.getString("name"));
						mb.setJumin1(rs.getString("jumin1"));
						mb.setJumin2(rs.getString("jumin2"));
						mb.setEmail(rs.getString("email"));
						mb.setRecv_yn(rs.getString("recv_yn"));
						mb.setPhone1(rs.getString("phone1"));
						mb.setPhone2(rs.getString("phone2"));
						mb.setPhone3(rs.getString("phone3"));
						mb.setCell1(rs.getString("cell1"));
						mb.setCell2(rs.getString("cell2"));
						mb.setCell3(rs.getString("cell3"));
						mb.setReg_date(rs.getDate("reg_date"));
						vmb.add(mb);
					}while( rs.next() );
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return vmb;
	}
	
}