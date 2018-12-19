package project.vpet.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class UserDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	
	
	public UserDAO() {
		try {
			String url = "jdbc:mysql://localhost/study?useSSL=false&serverTimezone=UTC";
			String id = "study";
			String password = "1104789jh";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, password);
			System.out.println("드라이버 연결");
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public int signin(String id, String password,String name, String email) {
		String sql = "insert into user values(?, ?, ?,?)";
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			pstmt.executeUpdate();
			return 1;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int login(String userID, String pwd) {
		String sql = "select pwd from user where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(pwd))
					return 1; // 로그인 성공
				else
					return 0; //비밀번호 불일치
			}
			return -1; //아이디가 없음
			
		} catch( Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터 베이스 ;
	}

}
