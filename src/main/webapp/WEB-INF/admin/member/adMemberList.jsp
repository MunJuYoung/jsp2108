<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMemberList.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
  	function levelCheck(){
  		alert("회원 등급을 정말 바꾸시겠습니까?");
  	}
  
  </script>
  
  
</head>
<body>
<p><br></p>
<div class="container">
  <h2>전체 회원 리스트</h2>
  <br/>
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>아이디</th>
      <th>별명</th>
      <th>성명</th>
      <th>성별</th>
      <th>방문횟수</th>
      <th>최종접속일</th>
      <th>등급</th>
      <th>정보공개</th>
      <th>탈퇴유무</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
    	<c:choose>
    		<c:when test="${vo.level == 2 }"><c:set var="level" value="정회원" /></c:when>
    		<c:when test="${vo.level == 3 }"><c:set var="level" value="우수회원" /></c:when>
    		<c:when test="${vo.level == 0 }"><c:set var="level" value="관리자" /></c:when>
    		<c:otherwise><c:set var="level" value="준회원"/></c:otherwise>
    	</c:choose>
    	<tr class="text-center">
    	  <td>${vo.idx}</td>
    	  <td>${vo.mid}</td>
    	  <td><a href="${ctp}/adMemberInfor.ad?idx=${vo.idx}">${vo.nickName}</a></td>
    	  <td>
    	    <%-- <c:if test="${vo.userInfor=='비공개'}">비공개</c:if>
    	    <c:if test="${vo.userInfor!='비공개'}">${vo.name}</c:if> --%>
    	  </td>
    	  <td>${vo.gender}</td>
    	  <td>${vo.visitCnt}</td>
    	  <td>${vo.lastDate}</td>
    	  <td>
    	  	<form name="levelForm" method="post" action="${ctp}/adMemberLevel.ad">
    	  		<select name="level" onchange="levelCheck()">
    	  			<option value="1" <c:if test="${vo.level == 1}">selected</c:if>>준회원</option>
    	  			<option value="2" <c:if test="${vo.level == 2}">selected</c:if>>정회원</option>
    	  			<option value="3" <c:if test="${vo.level == 3}">selected</c:if>>우수회원</option>
    	  			<option value="0" <c:if test="${vo.level == 0}">selected</c:if>>관리자</option>
    	  		</select> 
    	  		<input type="submit" value="등급변경" class="btn btn-secondary btn-sm" >
    	  		<input type="hidden" name="idx" value="${vo.idx}" >
    	  	</form>
    	  
    	  </td>
    	  <td>${vo.userInfor=='비공개'?'<font color=blue>비공개</font>':'공개'}</td>
    	  <td>${vo.userDel=='OK'?'<font color=red>탈퇴신청</font>':'활동중'}</td>
    	</tr>
    	<c:set var="curScrStrarNo" value="${curScrStrarNo-1}" />
    </c:forEach>
  </table>
  <br>
  <!-- 페이징처리 시작 -->
  <c:if test="${pag != 1 }">[<a href="${ctp}/adMemberList.ad?pag=1">◁◁</a>]</c:if>
	<c:if test="${pag > 1 }" >[<a href="${ctp}/adMemberList.ad?pag=${pag-1}">◀</a>]</c:if>
	${pag}Page / ${totPage} Pages
	<c:if test="${pag gt totPage }">[<a href="${ctp}/adMemberList.ad?pag=${page+1}">▶</a>]</c:if>
	<c:if test="${pag != totPage }">[<a href="${ctp}/adMemberList.ad?pag=${totPage}">▷▷</a>]</c:if>
	<!-- 페이징처리 끝 -->
</div>
<br/>
</body>
</html>