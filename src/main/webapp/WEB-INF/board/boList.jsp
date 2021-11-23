<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boList.jsp</title>
<%@ include file="/include/bs4.jsp"%>
<script>
	function pageCheck(){
		var pageSize = document.getElement('pageSize').value;
		location.href="boList.bo?page=${pag}&pageSize="+pageSize;
	}
</script>
</head>
<body>
	<%@ include file="/include/header_home.jsp"%>
	<%@ include file="/include/nav.jsp"%>
	<p><br></p>
	
	<div class="container">
		<table class="table table-borderess">
			<tr>
				<td><h2>게 시 판 리 스 트</h2></td>
			</tr>
			<tr>
				<td class="text-leftt">
					<a href="${ctp}/boInput.bo" class="btn btn-info">글쓰기</a>
				</td>
				<td class="text-right p-0">
	        <select name="pageSize" id="pageSize" onchange="pageCheck()" class="p-0 m-0">
	          <option value="5"  ${pageSize==5 ? 'selected' : ''}>5건</option>
	          <option value="10" ${pageSize==10 ? 'selected' : ''}>10건</option>
	          <option value="15" ${pageSize==15 ? 'selected' : ''}>15건</option>
	          <option value="20" ${pageSize==20 ? 'selected' : ''}>20건</option>
	        </select>
      	</td>
			</tr>
			
		</table>
		<table class="table table-hover text-dark">
			<tr class="text-dark">
				<th>글 번호</th>
				<th>글 제목</th>
				<th>글쓴이 </th>
				<th>글쓴날짜 </th>
				<th>조회수</th>
				<th>좋아요</th>
			</tr>
			<c:forEach var="vo" items="${vos}">
				<tr>
					<td>${curScrStrarNo}</td>
					<td>
						<a href="${ctp}/boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
						<c:if test="${vo.wNdate <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
					</td>
					<td>${vo.nickName}</td>
					<td>
						<c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if>
	        	<c:if test="${vo.wNdate >  24}">${fn:substring(vo.wDate,0,10)}</c:if>
					</td>
					<td>${vo.readNum }</td>
					<td>${vo.good }</td>
				</tr>
				<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
			</c:forEach>
		</table>
			
		<!-- 블록 페이징 처리 시작(BS4 스타일적용) -->
		
		<div class="container" style="text-align: center;">
		<ul class="pagination justify-content-center">
			<c:set var="pageSW" value="0" />
			<c:if test="${totPage == 0}">
				자료가 없습니다.
			</c:if>
			<c:if test="${pag != 1}">
				<a href="boList.bo?pag=1" class="btn btn-secondary btn-sm"> 첫 페이지</a>
			</c:if> &nbsp;&nbsp;
			<c:if test="${curBlock > 0}">
				<a href="boList.bo?pag=${(curBlock-1)*blockSize+1}" class="btn btn-secondary btn-sm">이전 블록</a>
			</c:if>	
			
			<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" step="1" >
				<c:if test="${i == pag && i <= totPage}">
					<li class="page-item active"><a class="page-link" href="boList.bo?pag=${i}"><font color="purple">${i}</font></a></li>
				</c:if>
				<c:if test="${i != pag && i <= totPage}">
					<li class="page-item"><a class="page-link" href="boList.bo?pag=${i}">${i}</a></li>
				</c:if>
			</c:forEach>
			
			<c:if test="${curBlock < lastBlock}" ><a href="boList.bo?pag=${(curBlock+1)*blockSize + 1}" class="btn btn-secondary btn-sm">다음블록</a>	</c:if>
			<c:if test="${pag != totPage}"><a href="boList.bo?pag=${totPage}" class="btn btn-secondary btn-sm"> 마지막 페이지</a>	</c:if>
				
		<%
			/* 이전 블록과 다음 블록의 페이지번호를 넣으려면 반복문이 돌아야한다 
			블록이 0일때 페이지는 1~3이므로 +1을 해주야한다		그냥 들여다보면 이해는되는데 막상 내가 쓰려면 어려울듯																						*/
		%>
		</ul>
		</div>
		
		
		<%--  	
<!-- 블록 페이징 처리 끝 -->
		<!-- 블록 페이징 처리 시작 -->
		<div class="container" style="text-align: center;">
			<c:set var="pageSW" value="0" />
			<c:if test="${totPage == 0}">자료가 없습니다.</c:if>
			<c:if test="${pag != 1}"><a href="boList.bo?pag=1" class="btn btn-secondary btn-sm"> 첫 페이지</a></c:if> &nbsp;&nbsp;
			<c:if test="${curBlock > 0}"><a href="boList.bo?pag=${(curBlock-1)*blockSize+1}" class="btn btn-secondary btn-sm"> 이전블록</a></c:if>	
			<c:if test="${curBlock > 0}"></c:if>
			
			<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" step="1" >
				<c:if test="${pageSW != 1}">
					<c:if test="${i == pag && i <= totPage}"><a href="boList.bo?pag=${i}"><font color="purple">${i}</font></a></c:if>
					<c:if test="${i != pag && i <= totPage}"><a href="boList.bo?pag=${i}">${i}</a></c:if>
				</c:if>
			</c:forEach>
			
			<c:if test="${curBlock < lastBlock}" ><a href="boList.bo?pag=${(curBlock+1)*blockSize + 1}" class="btn btn-secondary btn-sm"> 다음블록</a>	</c:if>
			<c:if test="${pag != totPage}"><a href="boList.bo?pag=${totPage}" class="btn btn-secondary btn-sm"> 마지막 페이지</a>	</c:if>
				
		<%
			/* 이전 블록과 다음 블록의 페이지번호를 넣으려면 반복문이 돌아야한다 
			블록이 0일때 페이지는 1~3이므로 +1을 해주야한다		그냥 들여다보면 이해는되는데 막상 내가 쓰려면 어려울듯																						*/
		%>
		</div>	
<!-- 블록 페이징 처리 끝 -->
			--%>
	</div>
	<br>
	<%@ include file="/include/footer.jsp"%>
</body>
</html>