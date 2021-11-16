<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<%@ include file="../../../include/bs4.jsp"%>
</head>
<body>
	<%@ include file="../../../include/header_guest.jsp"%>
	<%@ include file="../../../include/nav.jsp"%>
	<p><br></p>
	
	<div class="container">
		<h2>사용자 정보 등록창</h2>
		<hr>
		<form name="myform" method="post" action="<%=request.getContextPath()%>/urlMappingInputOk.um">
			<table class="table table-bordered">
				<tr>
					<td>
						<p> 성명 : <input type="text" name="name" autofocus class="form-control"></p>
						<p> 나이 : <input type="number" name="age" value="20" class="form-control"></p>
						<p class="row">
							<span class="col"></span>
							<button type="sumbit" class="btn btn-secondary col-5 mr-2">등록하기</button>
							<a href="<%=request.getContextPath()%>/URLMapping;" class="btn btn-info col-5 mr-2" >돌아가기</a>
							<span class="col"></span>
						</p>
					</td>
				</tr>
			</table>
		</form>
		<p>
		</p>
	</div>
	<br>
	<%@ include file="../../../include/footer.jsp"%>
</body>
</html>