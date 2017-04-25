<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판</title>

<style>
	#boardContent {width:80%; margin:0 auto; overflow:hidden;}
	#boardContent h3 {margin-left:0px;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.boardWriteBtn{width:100%; text-align: right;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	 if('${sessionScope.login}'==''){
   	  	alert("로그인 이용 할 수 있습니다.");
   	  	location.replace("../LoginUIServlet");
   	  }
	});
	
	function boardWrite(writeForm){
		
		var wordCheck;
		var content = $("#content").val();
		var title = $("#title").val();
		
		if(title == ''){
			alert("제목을 입력 해주세요.");
		}else if(content == ''){
			alert('내용을 입력 해주세요.')
		}else{
			$.ajax({
				type:"get",
				url:"admin/wordCheck.jsp",
				dataType:"text", // 받을 타입
				async: true, // 비동기
				data:{
					title:title,
					content:content
				},
				success:function(responseData,status,xhr){
					if(responseData.trim() == '성공'){
						writeForm.submit();
					}else{
						alert(responseData.trim());
					}
				},
				error:function(error){
					alert("error: "+error);
				}
			}); // $.ajax();
		}	
	}
	
</script>

</head>
<body>
	
	<c:set var="login" value="${sessionScope.login}" scope="request"/>

	<div id="boardWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form id="writeForm" name="writeForm" action="FreeBoardWriteServlet" method="post">
			<div id="boardContent">
				<h3>자유게시판</h3>
				<hr>
				<div>
					<p>
						&nbsp;<span style="width:24%;"><b>금지어</b></span>&nbsp;&nbsp;
						<c:forEach var="banWordDTO" items="${banWordList}" varStatus="i">
							<c:choose>
								<c:when test="${i.count != banWordListSize}">
									${banWordDTO.word},
								</c:when>
								<c:otherwise>
									${banWordDTO.word}
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%;"><b>작성자</b></span>&nbsp;&nbsp;
				    	<input type="text" name="author" id="author" style="width:20%; height:50px;" value="${login.name}" readonly>
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>제목</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name="title"  id="title" style="width:91.5%; height:50px;">
					</p>
				</div>
				<div>
				    	&nbsp;<span style="width:24%"><b>내용</b></span>&nbsp;&nbsp;&nbsp;
				    	&nbsp;<textarea name="content" id="content" rows="10" cols="111" ></textarea>
				</div>
				<br>
				<div class="boardWriteBtn">
 					<a href="javascript:boardWrite(writeForm);"> 
							<img src="images\freeBoard/writeBtn.jpg" height="30">
					</a>&nbsp;
				</div> <!-- boardWriteBtn -->
				
			</div> <!-- boardContent -->
			<br>
		</form>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- boardWrap -->
</body>
</html>