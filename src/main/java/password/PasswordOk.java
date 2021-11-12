package password;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/passwordOk")
public class PasswordOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 입력한 아이디와 비밀번호 받기
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		int pwd = request.getParameter("pwd") == null ? 0 : Integer.parseInt(request.getParameter("pwd"));
		
		System.out.println("=====================");
		System.out.println("입력된 아이디 : " + mid);
		System.out.println("입력된 비밀번호 : " + pwd);
		
		// 암호화를 위한 키(0x1234ABCD)
		int key = 0x1234ABCD;
		int encPwd, decPwd;
		
		encPwd = pwd ^ key; // 원본 비번과 암호키값을 EOR(배타적OR)
		System.out.println("인코딩된 비밀번호 : " + encPwd); //DB에 저장시킬 비번
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		
		// DB에 저장된 암호를 불러왔을때 복호화시키는 연습
		decPwd = encPwd ^ key;
		System.out.println("디코딩된 비밀번호 : " + decPwd);
		
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('콘솔창을 확인하세요');");
		//컨트롤러를 이용해야지 password.jsp로 갈 수 있으니 컨트롤러로
		out.println("location.href='"+request.getContextPath()+"/password';");
		out.println("</script>");
	}
}
