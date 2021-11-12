package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.mem")
public class MemberController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		String viewPage = "/WEB-INF/member"; // 계속 중복되니까 밖에다놓기
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if(com.equals("/memLogin")) {
			viewPage += "/memLogin.jsp";
		}
		else if(com.equals("/memJoin")) {
			viewPage += "/memJoin.jsp";
		}
		else if(com.equals("/idCheck")) {
			command = new IdCheckCommand();
			command.execute(request, response); //res,mid를 싣고 간다
			viewPage += "/idCheck.jsp";
		}
		else if(com.equals("/nickCheck")) {
			command = new NickCheckCommand();
			command.execute(request, response); //res,nickName를 싣고 간다
			viewPage += "/nickCheck.jsp";
		}
		else if(com.equals("/memJoinOk")) {
			command = new MemJoinOkCommand();
			command.execute(request, response); //가입정보를 DB에 옮긴다
			viewPage = "/WEB-INF/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);  //현재 상황 유지해서 가져간다
	}
} 
