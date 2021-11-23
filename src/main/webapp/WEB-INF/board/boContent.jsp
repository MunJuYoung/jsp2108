<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boContent.jsp</title>
<%@ include file="/include/bs4.jsp"%>
<script>
	function delCheck(){
		var ans = confirm("정말 삭제하시겠습니까?");
		if(ans){
			location.href="${ctp}/boDelete.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
		}
	}

</script>
</head>
<body>
	<%@ include file="/include/header_home.jsp"%>
	<%@ include file="/include/nav.jsp"%>
	<p><br></p>
	<div class="container">
		<h2>글 내 용 보 기</h2>
		<table class="table table-bordered">
			<tr>
				<th>글쓴이</th>
				<td>${vo.nickName} &nbsp; &nbsp;<a href="${ctp}/boGood.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">👍</a><td>
				<th>글쓴 날짜</th>
				<td>${fn:substring(vo.wDate,0,19)}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${vo.email}</td>
				<th>조회수</th>
				<td>${vo.readNum}</td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td>
					<c:if test="${fn:length(vo.homePage) > 10}">
						<a href="${vo.homePage}" target="_blank">${vo.homePage}</a>
					</c:if>
					<c:if test="${fn:length(vo.homePage) <= 10}">없음</c:if>
				</td>
				<th>접속IP</th>
				<td>${vo.hostIp}</td>
			</tr>
			<tr>
				<th>좋아요</th>
				<td colspan="3"><a href="${ctp}/boGood.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">❤</a>(${vo.good})
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${vo.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" style="height:200px">${fn:replace(vo.content,newLine,'<br/>')}</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center">
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/boList.bo?pag=${pag}';">
					<c:if test="${sMid == vo.mid}">
						<input type="button" value="수정하기" onclick="location.href='${ctp}'" >
						<input type="button" value="삭제하기" onclick="delCheck()" >
					</c:if>
				</td>
			</tr>
		</table>
		
	</div>
	<br> 
	<%@ include file="/include/footer.jsp"%>
</body>
</html>