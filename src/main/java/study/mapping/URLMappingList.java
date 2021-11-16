package study.mapping;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.mapping2.UserDAO;
import study.mapping2.UserVO;

@WebServlet("/URLMappingList")
public class URLMappingList extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		
		List<UserVO> vos = dao.getUserList();
		
		//request객체로 보내면 정보를 한번 보내고 끝이다. 다른데서 쓰려면 또 보내야함
		request.setAttribute("vos", vos);
		
		
		String uri = request.getRequestURI();
		String viewPage = "\\WEB-INF\\study\\mapping\\urlMappingList.jsp";

		//forward랄ㅇ dispatcher방식이 출동하므로 forward방식은 실행안댐 주석처리 안해도.
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
		
	}
}

