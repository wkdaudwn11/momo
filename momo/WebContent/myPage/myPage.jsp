<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<style>
	#myPageVisual {width:70%; margin: 0 auto;}
	
	#myPageContent { width: 70%; margin: 0 auto;}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script>

	$(document).ready(function(){
		if(${message != null }){
			alert('${message}');
		}
	});// end $(document).ready()

	$(document).ready(function(){
		$(".a1").hover(
			function(){
				$(this).attr("src", "images/myPage/myPageList1_over.jpg");
			}, function(){
				$(this).attr("src", "images/myPage/myPageList1.jpg");
			}
		);
		
		$(".a2").hover(
			function(){
				$(this).attr("src", "images/myPage/myPageList2_over.jpg");
			}, function(){
				$(this).attr("src", "images/myPage/myPageList2.jpg");
			}
		);
		
		$(".a3").hover(
			function(){
				$(this).attr("src", "images/myPage/myPageList3_over.jpg");
			}, function(){
				$(this).attr("src", "images/myPage/myPageList3.jpg");
			}
		);
		
		$(".a4").hover(
			function(){
				$(this).attr("src", "images/myPage/myPageList4_over.jpg");
			}, function(){
				$(this).attr("src", "images/myPage/myPageList4.jpg");
			}
		);
		
		$(".a5").hover(
			function(){
				$(this).attr("src", "images/myPage/myPageList5_over.jpg");
			}, function(){
				$(this).attr("src", "images/myPage/myPageList5.jpg");
			}
		);
		
		$(".a6").hover(
			function(){
				$(this).attr("src", "images/myPage/myPageList6_over.jpg");
			}, function(){
				$(this).attr("src", "images/myPage/myPageList6.jpg");
			}
		);
	});
</script>

</head>
<body>
<div id="wrap">
	<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
	
	<div id="myPageVisual">
		<img src="images/myPage/myPageVisual.jpg"><br><br>
	</div>
	
	<div id="myPageContent">
		<table style="width: 60%;">
			<tr>
				<td> <!-- 주문내역 -->
					<a href="#">
						<img src="images/myPage/myPageList1.jpg" class="a1">
					</a>
				</td>
				
				<td> <!-- 오늘 본 상품	 -->
					<a href="#">
						<img src="images/myPage/myPageList2.jpg" class="a2">
					</a>
				</td>
				
				<td> <!-- 고객문의 게시판 -->
					<a href="#">
						<img src="images/myPage/myPageList3.jpg" class="a3">
					</a>
				</td>
				
				<td> <!-- 내 게시글 보기 -->
					<a href="#">
						<img src="images/myPage/myPageList4.jpg" class="a4">
					</a>
				</td>
				
				<td> <!-- 회원 정보 변경 -->
					<a href="PwdCheckUIServlet?prevPage=${prevPage}">
						<img src="images/myPage/myPageList5.jpg" class="a5">
					</a>
				</td>
				
				<td> <!-- 탈퇴신청 -->
					<a href="#">
						<img src="images/myPage/myPageList6.jpg" class="a6">
					</a>
				</td>
			</tr>
		</table><br>
		
		<p>
			<img src="images/order/zzz.jpg">
			<font color="#7777ca"><b>[장명주]</b></font> 님의 Mypage 간단 정보입니다.
		</p>
		
		<table style="width: 60%;">
			<tr style="border-top:1px solid black; border-bottom:1px dotted #ddd;">
				<c:if test="${sessionScope.login.sns == null}">
					<td width="250"><img src="images/myPage/yyy.jpg">&nbsp;회원 가입일</td>
				</c:if>
				<c:if test="${sessionScope.login.sns != null}">
					<td width="250"><img src="images/myPage/yyy.jpg">&nbsp;최초 로그인</td>
				</c:if>
				<td>${sessionScope.login.joindate}</td>
			</tr>
			<tr style="border-bottom:1px dotted #ddd;">
				<td><img src="images/myPage/yyy.jpg">&nbsp;로그인 한 시간</td>
				<td>${sessionScope.login.logindate}</td>
			</tr>
			<tr style="border-bottom:1px dotted #ddd;">
				<td><img src="images/myPage/yyy.jpg">&nbsp;총 주문금액</td>
				<td>0</td>
			</tr>
			<tr style="border-bottom:1px solid black;">
				<td><img src="images/myPage/yyy.jpg">&nbsp;진행중 주문</td>
				<td>0개</td>
			</tr>
		</table>
		
	</div><br><br>
	
	<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
</div>
</body>
</html>