<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<%@ include file="/include/bs4.jsp"%>
<script>

	//아이디로 이름찾기
	function idCheck(){
		var mid = searchForm.mid.value;
		
		if(mid == ""){
			alert("아이디를 입력하세요.");
			searchForm.mid.focus();
			return false;
		}
		else{
			//alert("입력된 아이디 : " + mid);
			//$.ajax({변수1:값1,변수2:값2});
			
			var query = {     //객체를 전송할 때 안의 들어갈 내용이 많으면 변수로 만들어서 보낸다
					mid : mid,    // 객체안의 변수명 : 자바스크립트 변수 or 값
					age : 23
			}
			
			$.ajax({      // ajax의 송신방법
				type: "get",
				url : "${ctp}/ajax1Ok",
				data : query,
				success : function(data){    // 콜 백 함수
					// 성공적으로 ajax(비동기식) 처리 끝내고 돌아왔을 경우 수행하는 곳
					// return으로 받아와야한다
					
					if(data == ""){     // 검색된 자료가 없을때 프론트에서 확인할지 백단에서 확인할지는 취향차이
						alert("검색된 이름이 없습니다.");
					}
					else{
						alert("검색된 이름은 " + data);
					}
				},
				error : function(data){
					// 실패하고 돌아왔을 경우 수행하는 곳
					alert("검색시 오류발생 ");
				}
			});
		}
	}
	
	// AJax로 User 등록시키기
	function inputCheck(){
		var name = $("#name").val();
		var age = $("#age").val();
		
		if(name == ""){
			alert('이름을 입력하세오');
			$("#name").focus();
			return false;
		}
		
		var query = {
				name : name,
				age : age
		};
		
		$.ajax({
			type : "post",
			url : "${ctp}/userInput",
			data : query,
			success : function(data){
				if(data == "1"){
					alert("등록 성공");
				}
			},
		});
	}

	// 리스트 불러오기
	function listCheck(){
		$.ajax({
			type : "post",
			url : "${ctp}/userList",
			success : function(data){
				location.reload();
			},
		});
	}
	
	function delCheck(idx){
		var ans = confirm("자료를 삭제하시겠습니까?");
		/* if(ans) location.href = "${ctp}/userDelete?idx="+idx; */
		
		if(ans){
			var query = {
					idx : idx
			};
			
			$.ajax({
				type : "get",
				url : "${ctp}/userDelete",
				data : query,
				success : function(result){
					if(result == "1"){
						alert("데이터가 삭제되었습니다.");
						location.reload();
					}
					else{
						alert("데이터 삭제 실패");
					}
				},	
				error : function(){
					alert("삭제 오류");
				}
			});
			
		}
	}
		
	function updateInfo(idx){
		var query = {
				idx : idx
		};
		
		$.ajax({
			type : "get",
			url : "${ctp}/userUpdate1",
			data : query,
			success : function(data){
				/* location.reload(); */
				/* updateForm.name2.value = ${vo.name};  */
				updateForm.name2.focus(); 
				/* updateForm.age2.value = ${vo.age}; */

			},
			error : function(){
				alert("이름 불러오기 오류");
			}
		});
		/*
		updateForm.name2.value = ${vo1.name};
		updateForm.age2.value = ${vo1.age};
		*/
	}
	
	function ageCheck(){
		var name = $('#name2').val(); 
		
		var query = {
				name : name
		};
		
		$.ajax({
			type : "get",
			url : "${ctp}/userUpdate2",
			data : query,
			success : function(data){
				/* location.reload(); */
				alert("나이가져오기 :" + data);
				updateForm.age2.value = data;
				updateForm.age2.focus();
			},
			error : function(){
				alert("나이 불러오기 오류");
			}
		});
	}
	
	function updateCheck(){
		var name = $('#name2').val();
		
		var query = {
				name : name
		}
		
		$.ajax({
			type : "get",
			url : "${ctp}/userUpdateOk",
			data : query,
			success : function(data){
				if(data == "1") alert("정보수정 완료");
				else alert("정보수정 실패");
					
			},
			error : function(){
				alert("정보수정 오류");
			}
		});
		
	}
	
	
</script>
<style type="text/css">
	th, td {
		text-align: center;
		border : 1px solid #ccc;
	}
	th {
		background-color: #ddd;
	}
	
</style>

</head>
<body>
	<%@ include file="/include/header_guest.jsp"%>
	<%@ include file="/include/nav.jsp"%>
	<p><br></p>
	
	<div class="container">
		<h2>Ajax연습</h2>
		<form name="searchForm">
			아이디 : <input type="text" name="mid" >
			<input type="button" value="아이디검색" onclick="idCheck()">		
		</form>
		<br>
		<form name="inputForm">
			<table class="table table-bordered">
				<tr style="text-align: center;">
					<td colspan="2"><h3>User 가입</h3></td>
				</tr>			
				<tr>
					<th>성명:</th>
					<td><input type="text" name="name" id="name" class="form-control" autofocus required></td>
				</tr>
				<tr>
					<th>나이:</th>
					<td><input type="number" name="age" id="age" value="20" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="button" value="등록" onclick="inputCheck()" class="btn btn-secondary"> 
						<input type="reset" value="다시입력" class="btn btn-secondary" > 
						<input type="button" value="User조회" onclick="listCheck()" class="btn btn-secondary" > 
					</td>
				</tr>			
			</table>
		</form>
		<hr>
		<!-- 출력창 -->
		<h2>User 전체 리스트</h2>
		<table class="table">
			<tr>
				<th>번호</th>
				<th>성명</th>
				<th>나이</th>
				<th>처리</th>
			</tr>
			<c:forEach var="vo" items="${vos }" >
				<tr>
					<td>${vo.idx }</td>
					<td>${vo.name }</td>
					<td>${vo.age }</td>
					<td>
						<a href="javascript:updateInfo(${vo.idx})" class="btn btn-info btn-sm">수정</a>
						<a href="${ctp}/userUpdate?idx=${vo.idx}" class="btn btn-info btn-sm">수정2(선생님)</a>
						<a href="${ctp}/userUpdate1?idx=${vo.idx}" class="btn btn-info btn-sm">수정3(다시내거)</a>
						<a href="javascript:delCheck(${vo.idx})" class="btn btn-info btn-sm">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<form name="updateForm">
			<table class="table table-bordered">
				<tr style="text-align: center;">
					<td colspan="2"><h3>User 수정</h3></td>
				</tr>			
				<tr>
					<th>성명:</th>
					<td><input type="text" name="name2" id="name2" value="${vo1.name }" class="form-control" ></td>
				</tr>
				<tr>
					<th>나이:</th>
					<td><input type="number" name="age2" id="age2" value="${vo1.age }" class="form-control"></td>
					<!-- <td><input type="text" name="age2" id="age2" value="20" class="form-control"></td> -->
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="button" value="나이 가져오기" onclick="ageCheck()" class="btn btn-secondary"> 
						<a href="javascript:updateCheck()" class="btn btn-info btn-sm">이름 수정</a> 
						<input type="reset" value="다시입력" class="btn btn-secondary" > 
					</td>
				</tr>			
			</table>
		</form>
	</div>
	<br>
	<%@ include file="/include/footer.jsp"%>
</body>
</html>