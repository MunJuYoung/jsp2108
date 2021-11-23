package study.mapping2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private String sql = "";
	private UserVO vo = null;
	
	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/javacourse";
	private String user = "root";
	private String password = "1234";
	
	
	public UserDAO() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색에 실패하였습니다");
		} catch (SQLException e) {
			System.out.println("DB연동에 실패하였습니다.");
		}
	}
	
	
	public void pstmtClose() {
		try {
			if(pstmt != null) pstmt.close();
		} catch (Exception e) {}
	}
	
	public void rsClose() {
		try {
			if(rs != null) {
				rs.close();
				pstmtClose();
			}
		} catch (Exception e) {}
	}

	
	// 사용자 정보 모두 가져오기
	public List<UserVO> getUserList() {
		List<UserVO> vos = new ArrayList<UserVO>();
		
		try {
			sql = "SELECT * FROM user ORDER BY idx DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new UserVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}

	
	// 유저 정보 삭제
	public int setUserDel(int idx) {
		int res = 0;
		try {
			sql = "DELETE FROM user WHERE idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	
	// 사용자 정보 입력
	public int setUserInputOk(UserVO vo) {
		int res = 0;
		
		try {
			sql = "INSERT INTO user VALUES (default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getAge());
			pstmt.executeUpdate();
			res = 1;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		
		return res;
	}

	// 유저 정보 수정
	public UserVO getSearch(int idx) {
		vo = new UserVO();
		try {
			sql = "SELECT * FROM user WHERE idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}
	
	//이름으로 찾기
	public UserVO getSearchName(String name) {
		vo = new UserVO();
		try {
			sql = "SELECT * FROM user WHERE name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 정보 수정하기
	public int setUserUpdateOk(UserVO vo) {
		int res = 0;
		try {
			sql = "UPDATE user SET name = ?, age = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getAge());
			pstmt.setInt(3, vo.getIdx());
			
			pstmt.executeUpdate();
			
			res = 1;
		} catch (SQLException e) {
		} finally {
			pstmtClose();
		}
		return res;
	}
	
}
