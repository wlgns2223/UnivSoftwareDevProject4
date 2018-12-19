package project.vpet.comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class OthersCommentDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public OthersCommentDAO() {
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
	
	public String getDate() {
		String sql = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Error\n";
	}
	
	public int getNext() {
		String sql = "select commentNum from othersBoardComment order by commentNum desc";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;				
			}
			return 1; //첫번째 게시물
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(int num, String comment,String userID) {
		String sql = "insert into othersBoardComment values(?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext()); // num
			pstmt.setInt(2, num); // board num
			pstmt.setString(3, comment); // content
			pstmt.setString(4, getDate());
			pstmt.setString(5, userID); // userID			
			System.out.println("insert ok");
			return  pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Comment> getList(int num) {
		String sql = "select * from othersBoardComment where num = ? order by commentNum desc";
		
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setCommentNum(rs.getInt(1));
				comment.setNum(rs.getInt(2));
				comment.setComment(rs.getString(3));
				comment.setDate(rs.getString(4));
				comment.setUserID(rs.getString(5));
				list.add(comment);
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int commentCount(int num) {
		String sql = "select count(*) from othersBoardComment where num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);		
			}
			return 0; //게시물이 없는 경
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 에
	}
	
	

}
