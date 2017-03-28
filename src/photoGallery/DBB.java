 package photoGallery;
 
 import java.sql.*;

 import javax.sql.*; 
import javax.naming.*;
 
 public class DBB {
    
 	private static DBB instance = new DBB();
    
    public static DBB getInstance() {
        return instance;
    }
    
    private DBB() {
    }
    
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
 
  // 삽입
    public void insertMember(DB member) 
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
       
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement("insert into gboard values (?,?,?,?,?,?,?,sysdate)");
            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getPasswd());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getHomepage());
            pstmt.setString(5, member.getTitle());
            pstmt.setString(6, member.getContent());
            pstmt.setString(7, member.getUploadfile());
            pstmt.executeUpdate();
          
            
        } catch(SQLException ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    // 수정
    // 삭제
    public int deleteMember(String a,String b){
    	int i=1;
    	return i;
    }
}
