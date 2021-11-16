<%@page import="guest.GuestVO"%>
<%@page import="java.util.List"%>
<%@page import="guest.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String mid = session.getAttribute("sAdmin") == null ? "" : (String) session.getAttribute("sAdmin");

  GuestDAO dao = new GuestDAO();
  GuestVO vo = new GuestVO();
  
  /* 페이징처리 */
  /*
  	1.한 페이지 분량을 정한다. : pageSize = 10
  	2.총 레코드 건수를 구한다. : totRecCnt => SQL 함수중 count(*) 사용
  	3.총 페이지 수를 구한다. : totPage => 총 레코드수 / 페이지분량 , 나머지가 0이 아니면 몫+1
  	4.현재페이지의 시작 index번호 : startIndexNo = > (현재페이지-1) * 페이지분량
  	5.현재 화면에 보이는 방문소감 시작번호 : curScrStartNo => 총레코드수 - 현재페이지의 시작index번호	  커런트스크린
  */
  
  /*  이곳부터 페이징처리 변수 지정 시작 */
  int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag")); // 현재 페이지
  
  int pageSize = 5;     // 1
  int totRecCnt = dao.totRecCnt(); //2
  int totPage = totRecCnt % pageSize == 0 ? totRecCnt/pageSize : (totRecCnt/pageSize)+1; //3
  int startIndexNo = (pag - 1) * pageSize;        // 4
  int curScrStartNo = totRecCnt - startIndexNo;   // 5
  /*  이곳까지 페이징처리 변수 지정 끝 */
  
  
  List<GuestVO> vos = dao.gList(startIndexNo, pageSize);
  
  int no = vos.size();  // 총 방명록 건수
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gList.jsp(방명록리스트 _기본페이지(이전/다음처리))</title>
  <%@ include file="../include/bs4.jsp" %>
  <style>
  	th {
  		background-color: #ddd;
  		text-align: center;
  	}
  </style>
  <script>
  	function delCheck(idx) {
  		var ans = confirm("이 방문소감을 삭제하시겠습니까?");
  		if(ans) location.href = "<%=request.getContextPath()%>/GDelete?idx="+idx;
  		
  	}
  
  </script>
  
</head>
<body>
<%@ include file="../include/header_home.jsp" %>
<%@ include file="../include/nav.jsp" %>
<p><br></p>
<div class="container">
	<table class="table table-borderless">
		<tr>
			<th colspan="3" style="text-align: center"><h2>방 명 록 리 스 트</h2></th>
		</tr>
		<tr>
			<td>
<%
	if(mid.equals("admin")){
		out.println("<a href='"+request.getContextPath()+"/AdminLogOut' class='btn btn-secondary'>관리자 로그아웃</a>");
	}
	else{
		out.println("<a href='adminLogin.jsp' class='btn btn-secondary'>관리자</a>");
	}
%>
				
			</td>
			<td><a href="<%=request.getContextPath()%>/guest/gInput.jsp" class="btn btn-primary">방명록 남기기</a></td>
			<td  style=" text-align: right">
			<!-- 페이징 처리 시작 -->
<% if(pag != 1) {  %>
		<a href="gList.jsp?pag=1" class="btn btn-secondary btn-sm"> 첫 페이지로</a>	
<% } %>
<% if(pag > 1) {  %>
		<a href="gList.jsp?pag=<%=pag-1%>" class="btn btn-secondary btn-sm"> ◁◁</a>	
<% } %>
<%=pag %>Page / <%=totPage %>Pages
<% if(pag < totPage) {  %>
		<a href="gList.jsp?pag=<%=pag+1%>" class="btn btn-secondary btn-sm"> ▷▷</a>	
<% } %>
<% if(pag != totPage) {  %>
		<a href="gList.jsp?pag=<%=totPage%>" class="btn btn-secondary btn-sm"> 마지막 페이지로</a>	
<% } %>

<!-- 페이징 처리 끝 -->
			
			</td>
		</tr>
	</table>
<%
	for(int i=0; i<vos.size(); i++) {
		vo = vos.get(i);
			
		String email = vo.getEmail();
		if(email.equals("") || email == null) email = "-없음-";
		
		String homepage = vo.getHomepage();
		/* if(homepage.equals("http://") || homepage == null) homepage = "-없음-"; */
		
		/* 날짜에서 필요한 부분만 가져오기 */
		String vDate = vo.getvDate().substring(0, vo.getvDate().length()-2);
		
		/* 컨텐츠에 들어가는 엔터키 처리 */
		String content = vo.getContent().replace("\n","<br>");
%>
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        방문번호 : <%=curScrStartNo %> &nbsp;
<%
	if(mid.equals("admin")){
		out.println("<a href='javascript:delCheck("+vo.getIdx()+")' class='btn btn-secondary btn-sm'>삭제</a>");
	}
%>
	        
	      </td>
	      <td style="text-align:right;">
	        방문IP : <%=vo.getHostIp() %>
	      </td>
	    </tr>
	  </table>
	  <table class="table table-bordered">
	    <tr>
	    <!-- 맨 위에만 바꿔도 밑에 같이 바뀐다 table이니깐 -->
	      <th style="width:15%">성명</th>
	      <td style="width:35%"><%=vo.getName() %></td>
	      <th style="width:15%">방문일자</th>
	      <td style="width:35%"><%=vDate %></td>
	    </tr>
	    <tr>
	      <th>전자우편</th>
	      <td colspan="3"><%=email %></td>
	    </tr>
	    <tr>
	      <th>홈페이지</th> 
	      <td colspan="3">
<%
	if(homepage.length() <= 8 ){
		out.println("-없음-");
	}
	else{
		out.println("<a href='"+homepage+"' target='_blank'>"+homepage+"</a>");
	}
%>	      
	      
	      <%-- <a href="<%=homepage %>" target="_blank"><%=vo.getHomepage() %></a> --%>
	      </td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td colspan="3"><%=content %></td>
	    </tr>
	  </table>
	  <br/>
<%
	curScrStartNo--;
	}
%>
</div>
<br>

<!-- 페이징 처리 시작 -->
<div class="container" style="text-align: center;">
<% if(pag != 1) {  %>
		<a href="gList.jsp?pag=1" class="btn btn-secondary btn-sm"> 첫 페이지로</a>	
<% } %>
<% if(pag > 1) {  %>
		<a href="gList.jsp?pag=<%=pag-1%>" class="btn btn-secondary btn-sm"> ◁</a>	
<% } %>
<%=pag %>Page / <%=totPage %>Pages
<% if(pag < totPage) {  %>
		<a href="gList.jsp?pag=<%=pag+1%>" class="btn btn-secondary btn-sm"> ▷</a>	
<% } %>
<% if(pag != totPage) {  %>
		<a href="gList.jsp?pag=<%=totPage%>" class="btn btn-secondary btn-sm"> 마지막 페이지로</a>	
<% } %>

</div>	
<!-- 페이징 처리 끝 -->


<%@ include file="../include/footer.jsp" %>
</body>
</html>