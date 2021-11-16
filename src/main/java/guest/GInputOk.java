package guest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GInputOk")
public class GInputOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		GuestVO vo = new GuestVO();
		GuestDAO dao = new GuestDAO(); 
		
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String homepage = request.getParameter("homepage") == null ? "" : request.getParameter("homepage");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		
		// name에 태그가 안먹히게 하려면 막아줘야지 꺽쇠를
		name = name.replace("<", "&lt;");
		name = name.replace(">", "&gt;");
		
		
		vo.setName(name);
		vo.setEmail(email);
		vo.setHomepage(homepage);
		vo.setContent(content);
		vo.setHostIp(request.getParameter("hostIp"));
		
		boolean res = dao.gInputOk(vo);
		PrintWriter out = response.getWriter();
		
		if(res == true) {
			out.println("<script>");
			out.println("alert('방명록이 정상적으로 등록되었습니다.');");
			out.println("location.href='"+request.getContextPath()+"/guest/gList.jsp';");
			out.println("</script>");
			
		}
		else {
			out.println("<script>");
			out.println("alert('방명록 등록에 실패하였습니다.');");
			out.println("location.href='"+request.getContextPath()+"/guest/gInput.jsp';");
			out.println("</script>");
		}
		
	}
	
}
