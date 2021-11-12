// 싱글톤 사용하는 개념

package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetConn {
	private Connection conn ;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private String driver = "com.mysql.jdbc.Driver"; // url 거꾸로 한거
	private String url = "jdbc:mysql://localhost:3306/javacourse"; // 프로토콜
	private String user = "root";
	private String password = "1234";
	
	private GetConn() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			
		} catch (ClassNotFoundException e) {
			System.out.println("DRIVER 검색에 실패하였습니다.");
		} catch (SQLException e) {
			System.out.println("DB연동에 실패하였습니다.");
		}
	}
	
	private static GetConn instance = new GetConn();
	
	public static GetConn getInstance() {
		return instance;
	}
	
	public Connection getConn() {
		return conn;
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
			rs.close();
			pstmtClose();
			
			} catch (SQLException e) {
				System.out.println("SQL에러 : " + e.getMessage());
			}
		}
	}
	public void pstmtClose() {
		try {
			if(pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			System.out.println("SQL에러 : " + e.getMessage());
		}
	}
}
