<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>문의 게시판</title>

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
			location.replace("http://localhost:8090/momo/LoginUIServlet");
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
		console.log(writeForm);
		writeForm.submit();
	}
</script>

</head>
<body>
	
	<c:set var="login" value="${sessionScope.login}" scope="request"/>

	<div id="questionWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form id="writeForm" action="../QuestionWriteServlet" name="writeForm" method="post">
			<div id="questionContent">
				<h3>문의 게시판</h3>
				<hr>
				<div>
				    	<span style="width:24%"><b>작성자</b></span>&nbsp;&nbsp;
				    	<input type="text" name="author" id="author" style="width:45%; height:50px;" value="${login.id}" readonly>
				</div>
				<div>
						<select id="category" name="category">
							<option/>
							<option value="A/S문의">A/S문의</option>
							<option value="제품문의">제품문의</option>
							<option value="배송문의">배송문의</option>
							<option value="기타">기타</option>
						</select>
				    	&nbsp;<span style="width:24%"><b>제목</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name="title"  id="title" style="width:80%; height:2em;">
				</div>
				<div>
				    	&nbsp;<b><span style="width:30%;">내용</span><span style="margin-left: 15%;"/>
				    	<img src="http://localhost:8090/momo/images/question/lock.gif">비밀번호</b><input id="password" type="password" name="password" style="width:10em; height:1em;">
				    	<input type="checkbox" name="check" > 체크하시면 비밀번호가 보입니다. 
				    	<textarea name="content" id="content" rows="10" cols="125" placeholder="*카테고리를 반드시 설정해주세요*"></textarea>
				</div>
				<br>
				<div class="questionWriteBtn">
					aa<img src="http://localhost:8090/momo/images\freeBoard/writeBtn.jpg" style="cursor:pointer;" onclick="questionWrite(writeForm)">
				</div> <!-- questionWriteBtn -->
				
			</div> <!-- questionContent -->
			<br>
		</form>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- questionWrap -->
</body>
</html>