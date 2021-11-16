package study.mapping2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class URLMappingInputOkCommand implements URLInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") == null ? "" : (String)request.getParameter("name"); 
		int age = request.getParameter("age") == null? 20 :Integer.parseInt(request.getParameter("age"));
		
		UserVO vo = new UserVO();
		UserDAO dao = new UserDAO();
		
		vo.setName(name);
		vo.setAge(age);
		
		int res = dao.setUserInputOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "userInputOk");
			request.setAttribute("url", request.getContextPath()+"/urlMappingList.um");
		}
		else {
			request.setAttribute("msg", "userInputNo");
			request.setAttribute("url", request.getContextPath()+"/urlMappingList.um");
		}
	}

}
