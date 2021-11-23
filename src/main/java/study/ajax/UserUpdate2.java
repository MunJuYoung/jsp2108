package study.ajax;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.mapping2.UserDAO;
import study.mapping2.UserVO;

@WebServlet("/userUpdate2")
public class UserUpdate2 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		
		UserDAO dao = new UserDAO();
		UserVO vo = dao.getSearchName(name);
		
//		response.getWriter().write(vo.getName());
		response.getWriter().write(vo.getAge());
		
//		request.setAttribute("vo2", vo);
//		response.getWriter().write("1");
	}
}
