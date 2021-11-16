<%@page import="study.mapping2.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	UserVO vo = (UserVO)request.getAttribute("vo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>urlMappingUpdate.jsp</title>
<%@ include file="../../../include/bs4.jsp"%>
</head>
<body>
	<%@ include file="../../../include/header_guest.jsp"%>
	<%@ include file="../../../include/nav.jsp"%>
	<p><br></p>
	
	<div class="container">
		<h2>사용자 정보 수정창</h2>
		<hr>
		<form name="myform" method="post" action="<%=request.getContextPath()%>/urlMappingUpdatetOk.um">
			<table class="table table-bordered">
				<tr>
					<td>
						<p> 성명 : <input type="text" name="name" value="<%=vo.getName() %>" autofocus class="form-control"></p>
						<p> 나이 : <input type="number" name="age" value="<%=vo.getAge() %>" class="form-control"></p>
						<p class="row">
							<span class="col"></span>
							<button type="sumbit" class="btn btn-secondary col-5 mr-2">수정하기</button>
							<a href="<%=request.getContextPath()%>/urlMappingList.um;" class="btn btn-info col-5 mr-2" >돌아가기</a>
							<span class="col"></span>
						</p>
					</td>
				</tr>
			</table>
			<input type="hidden" name="idx" value="<%=vo.getIdx()%>" >   <!-- idx 히든으로 보내기 -->
		</form>
		<p>
		</p>
	</div>
	<br>
	<%@ include file="../../../include/footer.jsp"%>
</body>
</html>