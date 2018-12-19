package project.vpet.infoBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sound.midi.MidiDevice.Info;

import project.vpet.board.ReviewBoard;

public class InfoBoardDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public InfoBoardDAO() {
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
		String sql = "select num from infoBoard order by num desc";
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
	
	
	public ArrayList<InfoBoard> getList(int pageNum,String keyword) {
		String sql = "select * from infoBoard where num < ? order by num desc limit 5";
		
		System.out.println("ArrayList");
		ArrayList<InfoBoard> list = new ArrayList<InfoBoard>();
		if(keyword.equals("none")) {
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext() - (pageNum - 1) * 5);
				System.out.println("set Int");
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					InfoBoard board = new InfoBoard();
					board.setNum(rs.getInt(1));
					board.setName(rs.getString(2));
					board.setAddress(rs.getString(3));
					board.setPhone(rs.getString(4));
					list.add(board);
					System.out.println("Query done");
					
				}
					
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
			
		} else {
			
			String searchSql = "select * from infoBoard where name like ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(searchSql);
				pstmt.setString(1, "%"+keyword+"%");
				System.out.println("set keyword");
				rs = pstmt.executeQuery();
				while(rs.next()) {
					InfoBoard board = new InfoBoard();
					board.setNum(rs.getInt(1));
					board.setName(rs.getString(2));
					board.setAddress(rs.getString(3));
					board.setPhone(rs.getString(4));
					list.add(board);
					System.out.println("Query done");
					
				}
					
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}	
	}
	
	public int totalCount() {
		String sql = "select count(*) from infoBoard";
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
