package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;

public class MemberDAO {
	//private이므로 new로 객체만들기가 안됨.
	// static으로 올렸으므로 클래스이름.메서드로 사용할수있다.
	// 이방식으로 하면 DB서버에 부담이 없다
	
	// GetConn 객체만들기
	GetConn getConn = GetConn.getInstance(); 
	// GetConn 객체가 갖고있는 connection 가져오기
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private String sql = "";
	MemberVO vo = null;
	
	// 아이디 중복체크
	public String idCheck(String mid) {
		String name = "";
		try {
			sql = "SELECT name FROM member WHERE mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return name;
	}
	
	// 닉네임 중복체크
	public String nickCheck(String nickName) {
		String name = "";
		try {
			sql = "SELECT name FROM member WHERE nickName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return name;
	}
}
