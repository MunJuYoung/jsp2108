package study.mapping2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.mapping.URLMappingList;

// 확장자 패턴 컨트톨러

@WebServlet("*.um")
public class URLController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		URLInterface command= null;
		String viewPage = "";
		
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if(com.equals("/urlMappingList")) {   // 리스트 불러오기
			command = new URLMappingListCommand();
			command.execute(request, response);
			viewPage = "\\WEB-INF\\study\\mapping\\urlMappingList.jsp";
		}
		else if(com.equals("/urlMappingDelete")){ // 정보삭제(이대로 리스트로 바로보내면 에러뜨므로 메시지 거쳐서 리스트불러오기로 들어가게한다)
			command = new URLMappingDeleteCommand();
			command.execute(request, response);
			viewPage = "\\WEB-INF\\study\\mapping\\message.jsp";
		}
		else if(com.equals("/urlMappingInputOk")){ // 정보 입력(이대로 리스트로 바로보내면 에러뜨므로 메시지 거쳐서 리스트불러오기로 들어가게한다)
			command = new URLMappingInputOkCommand();
			command.execute(request, response);
			viewPage = "\\WEB-INF\\study\\mapping\\message.jsp";
		}
		else if(com.equals("/urlMappingUpdate")){   // DB에서 값 받아와서 Update창으로  
			command = new URLMappingUpdateCommand();
			command.execute(request, response);
			viewPage = "\\WEB-INF\\study\\mapping\\urlMappingUpdate.jsp";
		}
		else if(com.equals("/urlMappingUpdatetOk")){   // DB에서 값 받아와서 Update창으로  
			command = new URLMappingUpdateOkCommand();
			command.execute(request, response);
			viewPage = "\\WEB-INF\\study\\mapping\\message.jsp";
		}
		else if(com.equals("/urlMappingInput")){
			viewPage = "\\WEB-INF\\study\\mapping\\urlMappingInput.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
