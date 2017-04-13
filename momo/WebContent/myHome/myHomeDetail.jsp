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
	#myHomeDetailWrap{width: 80%; margin: 0 auto;}
	#myHomeDetailWrap h3{margin-bottom:0;}
	#menuBtn{margin-bottom:0.3em;}
	#menuBtn img{width:5em;}
	
	#headline{margin-top: 0;}
	
	#myHomeDetailVisual{width: 100%; height: 20em;}
	
	#myHomeDetailVisualleft{width: 100%; height: 100%; float: left;}
	
	#myHomeDetailVisual img{width:80%; height:400px;}
	#myHomeDetailContent img{width:100%; height:400px;}
	
	#myHomeDetailContent{width: 80%; height: 90%; margin: 0 auto;}
	
	table{width:100%;}
	table th{width: 10%;}
	#title{height: 3em;}
	#writeday{width:30%;}
	#author{width:20%;}
	.ramain{width:5%;}
	
	#titleArea_top{margin-bottom: 0;}
	#titleArea_bottom{margin-top: 0;}
	
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		if(${loginFail != null}){
			alert('${loginFail}');
		}
	}); // end $(document).ready(function()
			
	function myHomeDelete(hnum,curPage,img){
		var conf = confirm('정말 삭제 하시겠습니까?');
		if(conf){
			location.replace("MyHomeDeleteServlet?hnum="+hnum+"&curPage="+curPage+"&img="+img);
		}
	} // end function myHomeDelete(hnum,curPage)
	
	function goodCntPlus(){
		if(${empty sessionScope.login.id}){
			alert("추천은 로그인 후 가능합니다.");
		}else{
			$.ajax({
				type:"get",
				url:"myHome/goodCnt.jsp",
				dataType:"text",
				data:{
					"hnum":${MyHomeDTO.hnum},
				},
				success:function(responseData,status,xhr){
					if(responseData.trim() == "false"){
						alert("게시물 당 한번만 추천 할 수 있습니다.");
					}else{
						alert("추천~~!");
						$("#goodCnt").text(responseData.trim());
					}
				},
				error:function(error){}
			}); // end $.ajax()
		}
	}
</script>

</head>
<body>

<jsp:include page="../include/header.jsp" flush="true"></jsp:include>

<div id="myHomeDetailWrap">
	<c:set var="imgList" value="${fn:split(MyHomeDTO.img,',')}" scope="page"></c:set>
	<c:if test="${MyHomeDTO.img == null}">
		<c:set var="mainImg" value="ImgNotFound.png"/>
	</c:if>
	<c:forTokens var="img" items="${MyHomeDTO.img}" delims="," varStatus="status">
		<c:if test="${status.index == 0}">
			<c:set var="mainImg" value="${img}"/>
		</c:if>
	</c:forTokens>
	<h3>마이홈자랑</h3>
	<div id="menuBtn" align="right">	
		<c:if test="${sessionScope.login.id == MyHomeDTO.id || sessionScope.login.id == 'admin' }">
			<a href="MyHomeWriteUIServlet?curPage=${curPage}&hnum=${MyHomeDTO.hnum}&title=${MyHomeDTO.title}&content=${MyHomeDTO.content}"><img src="images\freeBoard/updateBtn.jpg" ></a>
			<a href="javascript:myHomeDelete(${MyHomeDTO.hnum},${curPage}<c:if test='${MyHomeDTO.img != null}'>,'${MyHomeDTO.img}'</c:if>);"><img src="images\freeBoard/deleteBtn.jpg" ></a>
		</c:if>
	<a href="MyHomeListServlet?curPage=${curPage}"><img src="images\freeBoard/listBtn.jpg"></a>
	</div>
	
	<hr id="headline">
	
	<div id="myHomeDetailVisual">
		<div id="myHomeDetailVisualleft">
			<center>
				<img src="images/${mainImg}" >
			</center>
		</div>
		
	</div> <!-- myHomeDetailVisual -->
	
	<hr id="titleArea_top"/>
		<table>
			<tr>
				<th>작성일</th><td id="writeday">${MyHomeDTO.writeday}</td>
				<th>작성자</th><td id="author">${MyHomeDTO.author}</td>
				<th>조회</th><td class="remain">${MyHomeDTO.readCnt}</td>
				<th>추천</th>
				<td class="remain"><span id="goodCnt">${MyHomeDTO.goodCnt}</span>&nbsp;
					<a href="javascript:goodCntPlus();"><img src="images\freeBoard/recommend.png" width="30px" height="30px"></a>
				</td>
			</tr>
			<tr id="title">
				<th>제목</th><td colspan="7">${MyHomeDTO.title}</td>
			</tr>
		</table>
	<hr id="titleArea_bottom"/>
	<div id="myHomeDetailContent">
		<c:if test="${MyHomeDTO.img != null}">
			<c:forEach var="img" items="${imgList}" varStatus="status">
				<img src="images/${img}"><p/>
			</c:forEach>
		</c:if>
		${MyHomeDTO.content}
	</div>
		
	<hr>
	
</div><!-- myHomeDetailWrap -->

<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>

</body>

</html>