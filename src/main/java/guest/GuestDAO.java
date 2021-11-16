package guest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql = "";
	
	GuestVO vo = null;
	
	private String url = "jdbc:mysql://localhost:3306/javacourse";
	private String user = "root";
	private String password = "1234";
	
	// 객체 생성시 DB 연결
	public GuestDAO() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색에 실패하였습니다.");
		} catch (SQLException e) {
			System.out.println("DB연결에 실패하였습니다.");
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
	
	
	// 전체 자료 검색
	public List<GuestVO> gList(int startIndexNo, int pageSize) {
		// 사용할 타입 or 부모타입     =      사용할 타입
		// 실무에서는 List를 자주 쓰기때문에 List를 써보는것!
		List<GuestVO> vos = new ArrayList<GuestVO>();
		
		try {
			sql = "SELECT * FROM guest ORDER BY idx DESC LIMIT ?,?"; // 최근부터 : 내림차순, 오래된거부터 : 오름차순
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GuestVO vo = new GuestVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setvDate(rs.getString("vDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}
	
	// 전체 자료 검색 (오버로딩)
		public List<GuestVO> gList() {
			// 사용할 타입 or 부모타입     =      사용할 타입
			// 실무에서는 List를 자주 쓰기때문에 List를 써보는것!
			List<GuestVO> vos = new ArrayList<GuestVO>();
			
			try {
				sql = "SELECT * FROM guest ORDER BY idx DESC LIMIT ?,?"; // 최근부터 : 내림차순, 오래된거부터 : 오름차순
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					GuestVO vo = new GuestVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setName(rs.getString("name"));
					vo.setEmail(rs.getString("email"));
					vo.setHomepage(rs.getString("homepage"));
					vo.setvDate(rs.getString("vDate"));
					vo.setHostIp(rs.getString("hostIp"));
					vo.setContent(rs.getString("content"));
					
					vos.add(vo);
				}
				
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				rsClose();
			}
			
			return vos;
		}

	
	// 추가된 방명록을 DB에 추가
	public boolean gInputOk(GuestVO vo) {
		try {
			sql = "INSERT INTO guest VALUES(default,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getHomepage()); 
			pstmt.setString(4, vo.getHostIp());
			pstmt.setString(5, vo.getContent());
			
			pstmt.executeUpdate();
			return true;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		
		return false;
	}

	// 방명록 지우기
	public boolean gDelete(int idx) {
		boolean res = false;
		try {
			sql = "DELETE FROM guest WHERE idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = true;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		
		return res;
	}
	
	// 전체 레코드 건수
	public int totRecCnt() {
		int totRecCnt = 0;
		
		try {
			sql = "SELECT COUNT(*) FROM guest";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) totRecCnt = rs.getInt(1);
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
		return totRecCnt;
	}

	//사용자가 방명록에 올린 글의 수를 구해온다.
	public int getWriteCnt(String mid, String nickName, String name) {
		int guestCnt = 0;
		try {
			sql = "SELECT count(*) FROM guest WHERE name like ? or name like ? or name like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+mid+"%");
			pstmt.setString(2, "%"+nickName+"%");
			pstmt.setString(3, "%"+name+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				guestCnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
		
		return guestCnt;
	}
	
}
