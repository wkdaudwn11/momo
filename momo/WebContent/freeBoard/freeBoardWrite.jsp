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
	window.onload = function onload(){
	 if('${sessionScope.login}'==''){
   	  	alert("로그인 이용 할 수 있습니다.");
   	  	location.replace("LoginUIServlet");
   	  }
	}
	
	function boardWrite(myForm){
		myForm.action="FreeBoardWriteServlet";
		myForm.submit();
	}
	
	function contentEmpty(){
		document.getElementById('content').value = "";
	}
</script>

</head>
<body>
	
	<c:set var="login" value="${sessionScope.login}" scope="request"/>

	<div id="boardWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form id="writeForm" name="writeForm" method="post">
			<div id="boardContent">
				<h3>자유게시판</h3>
				<hr>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>작성자</b></span>&nbsp;&nbsp;
				    	<input type="text" name="author" id="author" style="width:45%; height:50px;" value="${login.name}" readonly>
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>제목</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name="title"  id="title" style="width:90%; height:50px;">
					</p>
				</div>
				<div>
				    	&nbsp;<span style="width:24%"><b>내용</b></span>
				    	&nbsp;<textarea name="content" id="content" rows="10" cols="106" onfocus="contentEmpty()">디자인을 사랑하는 고객님의 멋진 러브하우스 사진을 남겨주세요 !!

* 포토후기를 작성해주신 모든 분들께 신세계 백화점 상품권(3만원권)을 드립니다.

* 포토후기를 카페, BLOG, SNS 등 에 리신 고객 중 베스트후기 5분께 영화관람권 1인2매(추가증정)

* 매월 추첨을 통해 베스트후기에 선정 되신 분께 고가의 침구세트 증정(상품 랜덤 발송)

* 리빙 소품 구매후기는 적립금 1만원이 지급됩니다.

* 500KB 넘는사진으로 등록이 안되시는 분들은 
wkdaudwn11@naver.com으로 남겨주세요 *

* A/S관련글은 A/S상담게시판에 남겨주시기 바랍니다 *
				    	</textarea>
				</div>
				<br>
				<div class="boardWriteBtn">
 					<!-- <input type="image" src="images/freeBoard/writeBtn.jpg" height="30px"> -->
 					<a href="javascript:boardWrite(writeForm);"> 
							<img src="images\freeBoard/writeBtn.jpg" height="30">
					</a>&nbsp;<!-- 수정 -->
				</div> <!-- boardWriteBtn -->
				
			</div> <!-- boardContent -->
			<br>
		</form>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- boardWrap -->
</body>
</html>