package project.vpet.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewBoardOthersDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ReviewBoardOthersDAO() {
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
		String sql = "select num from review_others order by num desc";
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
	
	public int write(String title, String content,String userID) {
		String sql = "insert into review_others values(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext()); // num
			pstmt.setString(2, title); // title
			pstmt.setString(3, content); // content
			pstmt.setInt(4, 1); // view
			pstmt.setString(5, userID); // userID
			pstmt.setInt(6, 1); // available
			pstmt.setString(7, getDate());
			System.out.println("insert ok");
			return  pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<ReviewBoard> getList(int pageNum, String keyword) {
		String sql = "select * from review_others where num < ? and available = 1 order by num desc limit 10";
		System.out.println("ArrayList");
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
		if(keyword.equals("none")) {
			
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext() - (pageNum - 1) * 10);
				System.out.println("set Int");
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReviewBoard board = new ReviewBoard();
					board.setNum(rs.getInt(1));
					board.setTitle(rs.getString(2));
					board.setContent(rs.getString(3));
					board.setView(rs.getInt(4));
					board.setUserID(rs.getString(5));
					board.setAvailable(rs.getInt(6));
					board.setDate(rs.getString(7));
					list.add(board);
					System.out.println("Query done");
					
				}
					
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
			
		} else {
			String searchSql = "select * from review_others where title like ? or content like ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(searchSql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setString(2, "%"+keyword+"%");
				System.out.println("set String");
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReviewBoard board = new ReviewBoard();
					board.setNum(rs.getInt(1));
					board.setTitle(rs.getString(2));
					board.setContent(rs.getString(3));
					board.setView(rs.getInt(4));
					board.setUserID(rs.getString(5));
					board.setAvailable(rs.getInt(6));
					board.setDate(rs.getString(7));
					list.add(board);
					System.out.println("Query done");
					
				}
					
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
			
		}
		
	}
	
	public boolean nextPage(int pageNum) {
		String sql = "select * from review_others where num < ? and available = 1 order by num desc limit 10";
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
	
	public ReviewBoard getBoard(int num) {
		String sql = "select * from review_others where num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ReviewBoard board = new ReviewBoard();
				board.setNum(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setContent(rs.getString(3));
				board.setView(rs.getInt(4));
				board.setUserID(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				board.setDate(rs.getString(7));
				System.out.println("Get Board Query Done");
				return board;
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int increaseView(int num, int currentView) {
		String sql = "update review_others set view = ? where num = ?";
		System.out.println("num: "+num);
		System.out.println("current view: "+currentView);
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,currentView+1);
			pstmt.setInt(2,num);
			int result = pstmt.executeUpdate();
			System.out.println("결과: "+result);
			return 1;
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	
	
	public int update(int num, String title, String content) {
		String sql = "update review_others set title = ?, content = ? where num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			System.out.println("insert ok");
			return  pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public void deleteReply(int num) {
		String sql = "delete from othersBoardComment where num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			System.out.println("insert ok");
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int delete(int num) {
		String sql = "delete from review_others where num = ?";
		deleteReply(num);
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			System.out.println("insert ok");
			return  pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int totalCount() {
		String sql = "select count(*) from review_others";
		try {
			pstmt = conn.prepareStatement(sql);
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
