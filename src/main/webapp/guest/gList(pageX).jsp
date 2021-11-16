<%@page import="guest.GuestVO"%>
<%@page import="java.util.List"%>
<%@page import="guest.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String mid = session.getAttribute("sAdmin") == null ? "" : (String) session.getAttribute("sAdmin");

  GuestDAO dao = new GuestDAO();
  List<GuestVO> vos = dao.gList();
  GuestVO vo = new GuestVO();
  
  int no = vos.size();  // 총 방명록 건수
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gList.jsp(방명록리스트)</title>
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
			<th colspan="2" style="text-align: center"><h2>방 명 록 리 스 트</h2></th>
		</tr>
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
			<td style=" text-align: right"><a href="<%=request.getContextPath()%>/guest/gInput.jsp" class="btn btn-primary">방명록 남기기</a></td>
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
	        방문번호 : <%=no %> &nbsp;
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
	no--;
	}
%>
</div>
<br>
<%@ include file="../include/footer.jsp" %>
</body>
</html>