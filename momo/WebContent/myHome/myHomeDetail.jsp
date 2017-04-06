<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>모모</title>

<style>
	#myHomeDetailWrap{width: 80%; height: 350em; margin: 0 auto;}
	#myHomeDetailWrap h3{margin-bottom:0;}
	#myHomeDetailWrap h3 + a{margin-left:69%;}
	#myHomeDetailWrap h3 ~ a img{ width:5em; margin:0.56% auto;}
	
	#headline{margin-top: 0;} 
	
	#myHomeDetailVisual{width: 100%; height: 20em;}
	
	#myHomeDetailVisualleft{width: 100%; height: 100%; float: left;}
	
	#myHomeDetailVisual img{width:80%; height:400px;}
	#myHomeDetailContent img{width:100%; height:400px;}
	
	#myHomeDetailContent{width: 80%; height: 90%; margin: 0 auto;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		if(${loginFail != null}){
			alert('${loginFail}');
		}
	}); // end $(document).ready(function()
			
	function myHomeDelete(hnum,curPage){
		var conf = confirm('정말 삭제 하시겠습니까?');
		if(conf){
			location.replace("MyHomeDeleteServlet?hnum="+hnum+"&curPage="+curPage);
		}
	} // end function myHomeDelete(hnum,curPage)
</script>

</head>
<body>

<jsp:include page="../include/header.jsp" flush="true"></jsp:include>

<div id="myHomeDetailWrap">
	<c:set var="imgList" value="${fn:split(MyHomeDTO.img,',')}" scope="page"></c:set>
	<c:forTokens var="img" items="${MyHomeDTO.img}" delims="," varStatus="status">
		<c:if test="${status.index == 0}">
			<c:set var="mainImg" value="${img}"/>
		</c:if>
	</c:forTokens>
	<h3>마이홈자랑</h3>
		<c:if test="${sessionScope.login.id == MyHomeDTO.id || sessionScope.login.id == 'admin' }">
			<a href="MyHomeWriteUIServlet?curPage=${curPage}&hnum=${MyHomeDTO.hnum}&title=${MyHomeDTO.title}&content=${MyHomeDTO.content}"><img src="images\freeBoard/updateBtn.jpg"></a>
			<a href="javascript:myHomeDelete(${MyHomeDTO.hnum},${curPage});"><img src="images\freeBoard/deleteBtn.jpg"></a>
		</c:if>
	<a href="MyHomeListServlet?curPage=${curPage}"><img src="images\freeBoard/listBtn.jpg"></a>
	
	<hr id="headline">
	
	<div id="myHomeDetailVisual">
		<div id="myHomeDetailVisualleft">
			<center>
				<img src="images/${mainImg}" >
			</center>
		</div>
		
	</div> <!-- myHomeDetailVisual -->
	
	<hr>
	
	<div id="myHomeDetailContent">
		<c:forEach var="img" items="${imgList}" varStatus="status">
			<img src="images/${img}">
		</c:forEach>
		${MyHomeDTO.content}
	</div>
		
	<hr>
	
</div><!-- myHomeDetailWrap -->

<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>

</body>

</html>