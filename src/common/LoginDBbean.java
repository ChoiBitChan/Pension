package common;

import java.sql.*;
import javax.sql.*; 
import javax.naming.*;

public class LoginDBbean {
   
   private static LoginDBbean instance = new LoginDBbean();
   
   public static LoginDBbean getInstance() {// static  �� ���� �ν��Ͻ� ����(����)
       return instance;
   }
   
   private LoginDBbean() {}
   
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

   // id�� passwd�� �޾� db�� ������ id�� passwd�� �ִ�
   // �ľ��ϰ� 1,0,-1�� ����
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
        String dbpasswd="";
		int x=-1;
       
		try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement("select passwd from MEMBER where mno=0 and id=?");
           pstmt.setString(1, id);
           rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd))
					x= 1; //���� ����
				else
					x= 0; //��й�ȣ Ʋ��
			}else
				x= -1;//�ش� ���̵� ����
			
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return x;
	}

}