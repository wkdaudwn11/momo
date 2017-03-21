<%@page import="com.entity.member.MemberDTO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판</title>

<style>
	#boardContent {width:70%; margin:0 auto; overflow:hidden;}
	#boardContent h3 {margin-left:0px;}
	
	.boardList {font-size:12px;}
	.boardList th, .boardList td {border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.boardList th {background:#f8f8f8;text-align:center;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.boardWriteBtn{width:100%; text-align: right;}
</style>
<script type="text/javascript">
	function loginCheck(curPage){
   	  	alert("Access Wrong !!");
   	  	location.href="http://localhost:8090/momo/FreeBoardListServlet";
	}
</script>

</head>
<body>
	<c:set var="login" value="${sessionScope.login}" scope="request"/>
	<c:set var="freeBoardDTO" value="${FreeBoardDTO}" scope="request"/>
	
	<c:if test="${empty login}">
		<script>loginCheck('${curPage}');</script>
	</c:if>
	
	<%-- <c:if test="${login.id != freeBoardDTO.author}">
		<script>loginCheck('${curPage}');</script>
	</c:if>
	 --%>
	
	<div id="boardWrap">
	
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form name="modifyForm" action="http://localhost:8090/momo/FreeBoardUpdateServlet" method="post">
			<input type="hidden" name="fnum" value="${freeBoardDTO.fnum}">
			<div id="boardContent">
				<h3>자유게시판</h3>
				<hr>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>작성자</b></span>&nbsp;&nbsp;
				    	<input type="text" name="author"  id="author" value="${freeBoardDTO.author}" style="width:45%; height:50px;" disabled="disabled">
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>제목</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" id="title" name="title" value="${freeBoardDTO.title}" style="width:90%; height:50px;">
					</p>
				</div>
				<div>
				    	&nbsp;
				    	<span style="width:24%"><b>내용</b></span>
				    	&nbsp;
				    	<textarea name="content" id="content" rows="10" cols="142">${freeBoardDTO.content}</textarea>
				</div>
				<br>
				<div class="boardWriteBtn">
 					<input type="image" 
 					src="http://localhost:8090/momo/images\freeBoard/updateBtn.jpg" 
 						height="30px" >
<!--  					<img src="http://localhost:8090/momo/images/freeBoard/writeBtn.jpg" height="30px"></button>
 -->				</div> <!-- boardWriteBtn -->
				
			</div> <!-- boardContent -->
			<br>
		</form>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- boardWrap -->
</body>
</html>