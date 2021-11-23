package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoInputOkCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String nickName = session.getAttribute("sNickName") == null ? "" : (String)session.getAttribute("sNickName");
		String title = request.getParameter("title") == null ? ""	 : request.getParameter("title");
		String email = request.getParameter("email") == null ? ""	 : request.getParameter("email");
		String homePage = request.getParameter("homePage") == null ? ""	 : request.getParameter("homePage");
		String content = request.getParameter("content") == null ? ""	 : request.getParameter("content");
		String hostIp = request.getParameter("hostIp") == null ? ""	 : request.getParameter("hostIp");
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		
		// title필드에는 태그사용 금지로 만들것 (< , --->, &lt  ,  &gt 등)
		
		BoardVO vo = new BoardVO();
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		vo.setMid(mid);
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.setBoInput(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "boInputOk");
			request.setAttribute("url", request.getContextPath()+"/boList.bo");
		}
		else {
			request.setAttribute("msg", "boInputNo");
			request.setAttribute("url", request.getContextPath()+"/boList.bo");
		}
	}

}
