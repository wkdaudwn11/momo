<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.myhome.MyHomePage"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이홈자랑</title>

<style>
	#myHomeContent {width:80%; margin:0 auto; overflow:hidden;}
	#myHomeContent h3{margin-bottom:0;}
	#myHomeContent h3+a{display: block; margin:0.3% auto; text-align: right; padding-right: 2%;}
	
	#myHomeVisual {width: 100%; height: 500px; margin:0 auto;}
	
	.topSeller{width:100%; height:40px; border-bottom:1px solid; background-color: #555;
				text-align: center; font: bold; color: white; padding-top:5px;}
				
	.rankFont{width:100%; font: bold; font-size:18px; text-align: center; margin-top:10px;}
	.rankFont ul{overflow: hidden; margin: 0 auto;}
	.rankFont ul li{width: 33.3%; text-align: center; float: left; font-size: 2em; list-style: none;}
	
	#content_22 {width:100%; overflow:hidden; margin:0 auto;}
	.contents_22_product_images {width:100%; overflow:hidden; padding-left: 20px; margin-left:0px;}
	.contents_22_product_images li{width:33.3%; list-style:none; float:left; padding-left: 10px; padding-right: 55px;}
	.contents_33_product_images li{width:33.3%; list-style:none; float:left; padding-left: 10px; padding-right: 55px;}
	
	.sortValueClass a{color:#13132f; text-decoration: none;}
	.sortValueClass a:hover{color:#EDA900; text-decoration: underline;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	
	.img {float: left;}
	.img:hover {border: 1px solid #13132f;}
	.img img {width: 100%; height: 12.500em;}
	.img a{color:#13132f; text-decoration: none;}
	.img a:hover{color:#EDA900; text-decoration: none;}
	
	.desc {padding: 0.938em; text-align: center;}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if(${DeleteSuccess != null}){
			alert('${DeleteSuccess}');
		}
	}); // end $(document).ready(function()
</script>


</head>
<body>
	<c:set var="myHomePage" value="${MyHomePage}" scope="request"/> <!-- 페이징 처리에 필요한 data가진 class -->
	<c:set var="myHomeList" value="${MyHomePage.myHomeList}" scope="request"/> <!-- 페이지에 보여줄 리스트 -->
	<c:set var="bestMyHomeList" value="${bestMyHomePageDTO.myHomeList}" scope="request"/> <!-- 인기상품 세 개의 리스트 -->
	
	<c:set var="curPage" value="${MyHomePage.curPage}" scope="request"/> <!-- 요청된 현재 페이지 -->
	<c:set var="perPage" value="${MyHomePage.perPage}" scope="request"/> <!-- 페이지 당 보여줄 리스트 수(9) -->
	<c:set var="page" value="${MyHomePage.page}" scope="request"/> <!-- 표시할 페이지 수 -->
	<c:set var="pageblock" value="${Math.ceil(curPage/page)}" scope="request"/> <!-- 표시할 페이지 블럭수 -->
	<c:set var="totalRecord" value="${MyHomePage.totalRecord}" scope="request"/> <!-- 전체 게시물 수 -->
	
	
	<div id="wrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<div id="myHomeContent">
			<h3>마이홈자랑</h3>
			<%-- <c:if test="${sessionScope.login != null}"> --%>
				<a id="writebtn" href="MyHomeWriteUIServlet">자랑하기</a>
			<%-- </c:if> --%>
			<hr style="margin-top:0;">
			
			<div id="myHomeVisual">
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
						
							<c:forEach var="bestMyHomeDTO" items="${bestMyHomeList}" varStatus="status">
								<li>
					            	<div class="img">
										<a href="MyHomeDetailServlet?hnum=${bestMyHomeDTO.hnum}">
						    				<img src="images/myHome/${bestMyHomeDTO.image1}.JPG" width="95%" height="275">
							  				<div class="desc"><b>
							  					${bestMyHomeDTO.name}<br>
							  					<font color="#7777ca"><del><fmt:formatNumber value="${bestMyHomeDTO.price}" type="currency" /></del></font><br>
							  					<c:set var="bestDiscountPrice" value="${bestMyHomeDTO.price * (1.0 - (bestMyHomeDTO.discount/100))}" />
							  					<span class="discountPrice"><fmt:formatNumber value="${bestDiscountPrice}" type="currency" /></span>
							  				</b></div>
						  				</a>
									</div>
				            	</li>  
							</c:forEach>
				
						</ul> <!-- contents_2_product_images -->
					</div> <!-- contents_2_product -->
				</div>	<!-- contents_22 -->
				
			</div>	<!-- myHomeVisual -->
			
			<h5 class="sortValueClass">
				<a href="MyHomeListServlet?curPage=${curPage}&category=${category}&sortValue=hnum">[최신순]</a>  |  
				<a href="MyHomeListServlet?curPage=${curPage}&category=${category}&sortValue=priceAsc">[가격 낮은 순]</a>  |  
				<a href="MyHomeListServlet?curPage=${curPage}&category=${category}&sortValue=priceDesc">[가격 높은 순]</a>  |  
				<a href="MyHomeListServlet?curPage=${curPage}&category=${category}&sortValue=buyCountDesc">[판매 인기 순]</a>
			</h5> 
			
			<div id="content_22">
				<div class="contents_22_product">
					<ul class="contents_22_product_images">
					
						<c:forEach var="myHomeDTO" items="${myHomeList}" varStatus="status">
							<c:if test="${myHomeDTO.img == null}">
								<c:set var="mainImg" value=""/>
							</c:if>
							<c:forTokens var="img" items="${myHomeDTO.img}" delims="," varStatus="imgSts">
								<c:if test="${imgSts.index == 0}">
									<c:set var="mainImg" value="${img}"/>
								</c:if>
							</c:forTokens>
							
							<li>
				            	<div class="img">
									<a href="MyHomeDetailServlet?hnum=${myHomeDTO.hnum}&curPage=${curPage}">
					    				<c:if test="${myHomeDTO.img != null}">	
					    					<img src="images/${mainImg}" />
					    				</c:if>
					    				<c:if test="${myHomeDTO.img == null }">
					    					<img src="images/ImgNotFound.png"/>
					    				</c:if>
						  				<div class="desc"><b>
						  					${myHomeDTO.title}<br>
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
					<p><a href="MyHomeListServlet?curPage=1">[처음]</a>
				</c:if>
				
				<c:if test="${pageblock > 1}">
					<a href="MyHomeListServlet?curPage=${Math.round((pageblock*page)-19)}">
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
							<a href="MyHomeListServlet?curPage=${i}">
								${i}
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach> &nbsp;
				
				<c:if test="${pageblock != Math.ceil((totalRecord/perPage+1)/page)}">
					<a href="MyHomeListServlet?curPage=${Math.round((pageblock*page)+1)}">
						[다음]
					</a>
				</c:if>
				
				<c:if test="${curPage != Math.ceil(totalRecord/perPage)}">
					<a href="MyHomeListServlet?curPage=${Math.round((totalRecord/perPage ))}">
						[끝]
					</a></p>
				</c:if>
			</div>
		
		</div>
		<br>
		
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- wrap -->
</body>
</html>