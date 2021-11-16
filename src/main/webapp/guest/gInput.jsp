<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gInput.jsp(글쓰기폼)</title>
<%@ include file="../include/bs4.jsp"%>
</head>
<body>
	<%@ include file="../include/header_guest.jsp"%>
	<%@ include file="../include/nav.jsp"%>
	<p><br></p>
	<div class="container"> 
		<form name="myform" method="post" action="<%=request.getContextPath()%>/GInputOk" class="was-validated">
			<h2>방명록 글쓰기</h2>
			
			성명 : <input type="text" name="name" autofocus required class="form-control"/>
			<div class="valid-feedback">통과!!</div>
      <div class="invalid-feedback">성명은 필수 입력입니다.</div>
			
			<p>이메일 : <input type="text" name="email" class="form-control"/></p>
			<p>홈페이지 : <input type="text" name="homepage" value="http://" class="form-control"/></p>
			<p>방문 소감 : <textarea rows="5" cols="60" name="content" required class="form-control"/></textarea></p>
			<p>
				<button type="submit" class="btn btn-primary" >방명록 등록</button>
				<button type="reset" class="btn btn-primary" >모두 초기화</button>
				<button type="button" class="btn btn-primary" onclick="location.href='gList.jsp';">돌아가기</button>
			</p>
			<input type="hidden" name="hostIp" value="<%=request.getRemoteAddr()%>" />
		</form>
	</div>
	<br>
	<%@ include file="../include/footer.jsp"%>
</body>
</html>