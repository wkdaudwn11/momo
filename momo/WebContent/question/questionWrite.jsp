<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객문의 게시판</title>

<style>
	#questionContent {width:70%; margin:0 auto; overflow:hidden;}
	#questionContent h3 {margin-left:0px;}
	
	.questionList {font-size:12px;}
	.questionList th, .questionList td {border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.questionList th {background:#f8f8f8;text-align:center;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.questionWriteBtn{width:100%; text-align: right;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if(${empty login}){
			alert("로그인 후 가능합니다.");
			location.replace("LoginUIServlet");
		}
    
		if(${password != null}){
			$("#password").val(${password});
		}
		
		$("#content").on("focus",function(){
			var category = $("#category").val();
			if(category == ''){
				alert("카테고리를 선택 해주세요");
				$("#content").trigger("blur");
			}
		});// end $("#content").on("focus");
		
		$(":checkbox").on("click",function(){
			if($(":checkbox").get(0).checked){
				$("#password").attr("type","text");
			}else{
				$("#password").attr("type","password");
			}
		});// end $("input").attr("passwordByText").on("click");
	}); //end $.ready()
	
	function questionWrite(writeForm){
		writeForm.submit();
	}
</script>

</head>
<body>
	
	<c:set var="login" value="${sessionScope.login}" scope="request"/>
	
	<div id="questionWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form id="writeForm" action="QuestionWriteServlet" name="writeForm" method="post">

			<input type="hidden" name="curPage" value="${curPage}">

			<input type="hidden" name="id" value="${sessionScope.login.id}">
			<input type="hidden" name="qnum" value="${requestScope.qnum}">
			<div id="questionContent">
				<h3>고객문의 게시판</h3>
				<hr>
				<div>
				    	<span style="width:24%"><b>작성자</b></span>&nbsp;&nbsp;
				    	<input type="text" name="author" id="author" style="width:45%; height:50px;" value="${login.name}" readonly>
				</div>
				<div>
						<select id="category" name="category" >
							<option/>
							<option value="A/S문의" <c:if test="${requestScope.category == 'A/S문의'}">selected</c:if>>A/S문의</option>
							<option value="제품문의" <c:if test="${requestScope.category == '제품문의'}">selected</c:if>>제품문의</option>
							<option value="배송문의" <c:if test="${requestScope.category == '배송문의'}">selected</c:if>>배송문의</option>
							<option value="기타" <c:if test="${requestScope.category == '기타'}">selected</c:if>>기타</option>
						</select>
				    	&nbsp;<span style="width:24%"><b>제목</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name="title"  id="title" style="width:80%; height:2em;">
				</div>
				<div>
				    	&nbsp;<b><span style="width:30%;">내용</span><span style="margin-left: 15%;"/>

				    	<img src="images/question/lock.gif">비밀번호</b><input id="password" type="password" name="password" style="width:25em; height:1em;" placeholder="비밀글을 원하면 입력해주세요(공백제외)">

				    	<input type="checkbox" name="check" > 비밀번호 보이게 
				    	<textarea name="content" id="content" rows="10" cols="125" placeholder="*카테고리를 반드시 설정해주세요*"></textarea>
				</div>
				<br>
				<div class="questionWriteBtn">
					<img src="images\freeBoard/writeBtn.jpg" style="cursor:pointer;" onclick="questionWrite(writeForm)">
				</div> <!-- questionWriteBtn -->
				
			</div> <!-- questionContent -->
			<br>
		</form>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- questionWrap -->
</body>
</html>