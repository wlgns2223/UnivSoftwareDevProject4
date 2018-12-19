package project.vpet.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CounselBoardDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public CounselBoardDAO() {
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
	
	public int getNext() {
		String sql = "select num from counsel order by num desc";
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
	
	public int write(String title, String content,String userID, String category) {
		String sql = "insert into counsel values(?,?,?,?,?,?,?,?)";
		System.out.println("counsel Write enter");
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext()); // num
			pstmt.setString(2, category);
			pstmt.setString(3, title); // title
			pstmt.setString(4, content); // content
			pstmt.setInt(5, 1); // view
			pstmt.setString(6, userID); // userID
			pstmt.setInt(7, 1); // available
			pstmt.setString(8, getDate());
			System.out.println("insert ok");
			return  pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Counsel> getList(int pageNum) {
		String sql = "select * from counsel where num < ? and available = 1 order by num desc limit 10";
		System.out.println("ArrayList");
		
		ArrayList<Counsel> list = new ArrayList<Counsel>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNum - 1) * 10);
			System.out.println("set Int");
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Counsel board = new Counsel();
				board.setNum(rs.getInt(1));
				board.setCategory(rs.getString(2));
				board.setTitle(rs.getString(3));
				board.setContent(rs.getString(4));
				board.setView(rs.getInt(5));
				board.setUserID(rs.getString(6));
				board.setAvailable(rs.getInt(7));
				board.setDate(rs.getString(8));
				list.add(board);
				
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNum) {
		String sql = "select * from counsel where num < ? and available = 1 order by num desc limit 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNum - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next())
				return true;
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}


}
