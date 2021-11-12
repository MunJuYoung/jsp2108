package password;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/passwordOk2")
public class PasswordOk2 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// 입력한 아이디와 비밀번호 받기
			String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
			String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd").toUpperCase();
			
			System.out.println("=====================");
			System.out.println("입력된 아이디 : " + mid);
			System.out.println("입력된 비밀번호 : " + pwd);
			
			//입력된 비밀번호 변환
			long intPwd;
			String strPwd = "";
			for(int i=0; i <pwd.length(); i++) {
				intPwd = pwd.charAt(i);
				strPwd += intPwd;
			}
			
			System.out.println("strPwd(아스키코드문자로 변환된 비번) : " + strPwd);
			
			intPwd = Long.parseLong(strPwd); //연산할 준비완료
			
			// 암호화를 위한 키(0x1234ABCD)
			long key = 0x1234ABCD;
			long encPwd, decPwd;
			
			encPwd = intPwd ^ key; // 원본 비번과 암호키값을 EOR(배타적OR)
			strPwd = String.valueOf(encPwd); //DB에 넣을떈 String으로
			
			System.out.println("인코딩된 비밀번호 : " + encPwd); //DB에 저장시킬 비번
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			
			
			
			// DB에 저장된 암호를 불러왔을때 복호화시키는 연습
			// String으로 되어있는걸 다시 정수형으로 바꿔줘야겠지만 생략
			decPwd = encPwd ^ key;
			System.out.println("디코딩된 비밀번호 : " + decPwd);
			
			// 복원된 비밀번호는 숫자로된 비밀번호이기에 문자로 변경후 2개씩(아스키코드니까) 분리후 다시 문자변환
			strPwd = String.valueOf(decPwd);
			
			String result = "";
			char ch;
			for(int i=0; i<strPwd.length(); i+=2) {
				ch =(char)Integer.parseInt(strPwd.substring(i,i+2));  // 2개 꺼내기(0,1  -- 2,3 ---...)
				result += ch; 
			}
			
			System.out.println("최종 변환된 비밀번호 : " + result);
			
			
			
			
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('콘솔창을 확인하세요');");
			//컨트롤러를 이용해야지 password.jsp로 갈 수 있으니 컨트롤러로
			out.println("location.href='"+request.getContextPath()+"/password';");
			out.println("</script>");
		
	}
}
