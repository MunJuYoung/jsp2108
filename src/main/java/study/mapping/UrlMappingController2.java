package study.mapping;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.url2")
public class UrlMappingController2 extends HttpServlet {
	
	// 확장자로 url이 들어오면 다 이 서블릿을 오고 그 전송방식이 get이든 post든 action do 실행
	
	//doGet -> get형식만 받음.    
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	//doPost -> post로 온것만 받음
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글처리 (하지만 필터에서 끝냄) , 세션처리
		
		String viewPage = "";
		
		StringBuffer url = request.getRequestURL();
		System.out.println("url : " + url);
		
		String uri = request.getRequestURI();
		System.out.println("uri : " + uri);
		
		String com = uri.substring(uri.lastIndexOf("/"),uri.length()-4);
		com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		System.out.println("com : " + com);
		
		
		/*
		 * PrintWriter out = response.getWriter(); out.println("<script>");
		 * out.println("alert('콘솔창을 확인하세ㅐ요')"); // 이렇게 가면 갈 순 있는데 2번에 걸쳐서 가는 방법임. 공부용이래
		 * out.println("location.href='"+request.getContextPath()+"/URLMapping';");
		 * out.println("</script>");
		 */
		
		if(com.equals("/URLMapping")) {
			viewPage = "\\WEB-INF\\study\\mapping\\urlMapping.jsp";
		}
		
		//forward랄ㅇ dispatcher방식이 출동하므로 forward방식은 실행안댐 주석처리 안해도.
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
		
	}
	
	
	
	
}
