<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.livingRoom.LivingRoomPageDTO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>거실 가구</title>

<style>
	#livingRoomWrap {width:80%; margin:0 auto; overflow:hidden;}
	#livingRoomContent {width:75%; float: left;}
	#livingRoomContent h3 {margin-left:0px;}
	
	#livingRoomAside {width:25%; float: left; margin-top:4.5em; background-color: lightgray;}
	#livingRoomAside table {};
	#livingRoomAside table tr {};
	#livingRoomAside table tr td {};
	
	#livingRoomVisual {width: 100%; height: 500px; margin:0 auto;}
	
	.topSeller{width:100%; height:40px; border-bottom:1px solid; background-color: #555;
				text-align: center; font: bold; color: white; padding-top:5px;}
				
	.rankFont{width:100%; font: bold; font-size:18px; text-align: center; margin-top:10px;}
	.rankFont ul{overflow: hidden; margin: 0 auto;}
	.rankFont ul li{width: 33.3%; text-align: center; float: left; font-size: 2em; list-style: none;}
	
	#content_22 {width:100%; overflow:hidden; margin:0 auto;}
	.contents_22_product_images {width:100%; overflow:hidden; padding-left: 20px; margin-left:0px;}
	.contents_22_product_images li{width:33.3%; list-style:none; float:left; padding-left: 10px; padding-right: 55px;}
	.contents_33_product_images li{width:33.3%; list-style:none; float:left; padding-left: 10px; padding-right: 55px;}
	
	.categoryList{width:100%; border-top: 1px solid; border-bottom: 1px solid;}
	.categoryList ul {width:100%; list-style:none; overflow: hidden; margin:0 auto; margin-bottom:20px; padding-left: 0;}
	.categoryList ul li {width:16.6%; text-align:center; float:left; margin-top:20px; font-size: 1.0em;}
	.categoryList ul li a{font: bold;color:#13132f; text-decoration: none;}
	.categoryList ul li a:hover{color:#EDA900; text-decoration: underline;}
	
	.sortValueClass a{color:#13132f; text-decoration: none;}
	.sortValueClass a:hover{color:#EDA900; text-decoration: underline;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	
	.img {float: left;}
	.img:hover {border: 1px solid #13132f;}
	.img img {width: 100%; height: auto;}
	.img a{color:#13132f; text-decoration: none;}
	.img a:hover{color:#EDA900; text-decoration: none;}
	
	.desc {padding: 15px; text-align: center;}
	
</style>

</head>
<body>
	<c:set var="LivingRoomPageDTO" value="${LivingRoomPageDTO}" scope="request"/> <!-- 페이징 처리에 필요한 data가진 class -->
	<c:set var="livingRoomList" value="${LivingRoomPageDTO.livingRoomList}" scope="request"/> <!-- 페이지에 보여줄 리스트 -->
	<c:set var="bestLivingRoomList" value="${BestLivingRoomPageDTO.livingRoomList}" scope="request"/> <!-- 인기상품 세 개의 리스트 -->
	
	<c:set var="curPage" value="${LivingRoomPageDTO.curPage}" scope="request"/> <!-- 요청된 현재 페이지 -->
	<c:set var="perPage" value="${LivingRoomPageDTO.perPage}" scope="request"/> <!-- 페이지 당 보여줄 리스트 수(9) -->
	<c:set var="page" value="${LivingRoomPageDTO.page}" scope="request"/> <!-- 표시할 페이지 수 -->
	<c:set var="pageblock" value="${Math.ceil(curPage/page)}" scope="request"/> <!-- 표시할 페이지 블럭수 -->
	<c:set var="totalRecord" value="${LivingRoomPageDTO.totalRecord}" scope="request"/> <!-- 전체 게시물 수 -->
	
	<div id="wrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		<div id="livingRoomWrap">
			<h3>거실 가구</h3>
			<hr>
			<div id="livingRoomContent">
				<div id="livingRoomVisual">
					<div class="topSeller">
						TOP SELLER
					</div>	<!-- topSeller -->
					<div class="rankFont">
						<ul>
							<li>Best1</li>
							<li>Best2</li>
							<li>Best3</li>
						</ul>
					</div>
					<div id="content_22">
						<div class="contents_22_product">
							<ul class="contents_33_product_images">
							
								<c:forEach var="bestLivingRoomDTO" items="${bestLivingRoomList}" varStatus="status">
									<li>
						            	<div class="img">
											<a href="LivingRoomDetailServlet?lnum=${bestLivingRoomDTO.lnum}">
							    				<img src="images/livingRoom/${bestLivingRoomDTO.image1}.JPG" width="95%" height="275">
								  				<div class="desc"><b>
								  					${bestLivingRoomDTO.name}<br>
								  					<font color="#7777ca"><del><fmt:formatNumber value="${bestLivingRoomDTO.price}" type="currency" /></del></font><br>
								  					<c:set var="bestDiscountPrice" value="${bestLivingRoomDTO.price * (1.0 - (bestLivingRoomDTO.discount/100))}" />
								  					<span class="discountPrice"><fmt:formatNumber value="${bestDiscountPrice}" type="currency" /></span>
								  				</b></div>
							  				</a>
										</div>
					            	</li>  
								</c:forEach>
					
							</ul> <!-- contents_2_product_images -->
						</div> <!-- contents_2_product -->
					</div>	<!-- contents_22 -->
				</div>	<!-- livingRoomVisual -->
				<br><br><br>
				
				<div class="categoryList">
					<ul>
						<li><a href="LivingRoomListServlet?curPage=${curPage}&category=0&sortValue=${sortValue}">전체</a></li>
						<li><a href="LivingRoomListServlet?curPage=${curPage}&category=1&sortValue=${sortValue}">가죽소파</a></li>
						<li><a href="LivingRoomListServlet?curPage=${curPage}&category=2&sortValue=${sortValue}">패브릭소파</a></li>
						<li><a href="LivingRoomListServlet?curPage=${curPage}&category=3&sortValue=${sortValue}">리클라이너소파</a></li>
						<li><a href="LivingRoomListServlet?curPage=${curPage}&category=4&sortValue=${sortValue}">거실장</a></li>
						<li><a href="LivingRoomListServlet?curPage=${curPage}&category=5&sortValue=${sortValue}">거실테이블</a></li>
					</ul>
				</div>
				
				<h5 class="sortValueClass">
					<a href="LivingRoomListServlet?curPage=${curPage}&category=${category}&sortValue=lnum">[최신순]</a>  |  
					<a href="LivingRoomListServlet?curPage=${curPage}&category=${category}&sortValue=priceAsc">[가격 낮은 순]</a>  |  
					<a href="LivingRoomListServlet?curPage=${curPage}&category=${category}&sortValue=priceDesc">[가격 높은 순]</a>  |  
					<a href="LivingRoomListServlet?curPage=${curPage}&category=${category}&sortValue=buyCountDesc">[판매 인기 순]</a>
				</h5> 
				
				<div id="content_22">
					<div class="contents_22_product">
						<ul class="contents_22_product_images">
						
							<c:forEach var="livingRoomDTO" items="${livingRoomList}" varStatus="status">
								<li>
					            	<div class="img">
										<a href="LivingRoomDetailServlet?lnum=${livingRoomDTO.lnum}">
						    				<img src="images/livingRoom/${livingRoomDTO.image1}.JPG">
							  				<div class="desc"><b>
							  					${livingRoomDTO.name}<br>
							  					<font color="#7777ca"><del><fmt:formatNumber value="${livingRoomDTO.price}" type="currency" /></del></font><br>
							  					<c:set var="discountPrice" value="${livingRoomDTO.price * (1.0 - (livingRoomDTO.discount/100))}" />
							  					<span class="discountPrice"><fmt:formatNumber value="${discountPrice}" type="currency" /></span>
							  				</b></div>
						  				</a>
									</div>
				            	</li>  
								<c:if test="${status.count % 3 == 0}">
									</ul>
									</div>
									</div>
									<div id="content_22">
									<div class="contents_22_product">
									<ul class="contents_22_product_images">
								</c:if>
							</c:forEach>
				
						</ul> <!-- contents_2_product_images -->
					</div> <!-- contents_2_product -->
				</div>	<!-- contents_22 -->
			
				<!-- 페이징처리 -->
				<c:if test="${pageblock*page <= Math.ceil(totalRecord/perPage)}">
					<c:set var="endPage" value="${pageblock*page}" scope="request"/>
				</c:if>
				<c:if test="${pageblock*page > Math.ceil(totalRecord/perPage)}">
					<c:set var="endPage" value="${Math.ceil(totalRecord/perPage)}" scope="request"/>
				</c:if>
						
				<div class="paging">
					<c:if test="${curPage != 1}">
						<p><a href="LivingRoomListServlet?curPage=1&category=${category}&sortValue=${sortValue}">[처음]</a>
					</c:if>
					
					<c:if test="${pageblock > 1}">
						<a href="LivingRoomListServlet?curPage=${Math.round((pageblock*page)-19)}&category=${category}&sortValue=${sortValue}">
							[이전]
						</a>
					</c:if> &nbsp;
					
					<c:if test="${pageblock < 1}">
						<c:set var="pageblock" value="1" scope="request"/> <!-- 표시할 페이지 블럭수 -->
					</c:if>
					
					 <c:forEach var="i" begin="${(pageblock*page)-(page-1)}" end="${endPage}" >
						<c:choose>
							<c:when test="${curPage == i}">
								${i}
							</c:when>
							<c:otherwise>
								<a href="LivingRoomListServlet?curPage=${i}&category=${category}&sortValue=${sortValue}">
									${i}
								</a>
							</c:otherwise>
						</c:choose>
					</c:forEach> &nbsp;
					
					<c:if test="${pageblock != Math.ceil((totalRecord/perPage+1)/page)}">
						<a href="LivingRoomListServlet?curPage=${Math.round((pageblock*page)+1)}">
							[다음]
						</a>
					</c:if>
					
					<c:if test="${curPage != Math.ceil(totalRecord/perPage)}">
						<a href="LivingRoomListServlet?curPage=${Math.round((totalRecord/perPage ))}&category=${category}&sortValue=${sortValue}">
							[끝]
						</a></p>
					</c:if>
				</div> <!-- .paging -->
				
			</div> <!-- #livingRoomContent -->
			
			<div id="livingRoomAside">
				오늘 본 상품
			</div> <!-- #bedRoomAside -->
			
		</div> <!-- #livingRoomWrap -->
		<br>
		
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- wrap -->
</body>
</html>