<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.bedRoom.BedRoomPageDTO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>침실 가구</title>

<style>
	#bedRoomWrap {width:80%; margin:0 auto; overflow:hidden;}
	#bedRoomContent {width:75%; float: left;}
	#bedRoomContent h3 {margin-left:0px;}
	
	#bedRoomAside {width:23%; float: left; margin-top:4.5em; margin-left: 2%;}
	#bedRoomAside table {font-size: 0.7em;}
	#bedRoomAside tr:{border-right: 1px solid #ddd;}
	#bedRoomAside tr:nth-child(odd){border-top: 1px solid #ddd;}
	#bedRoomAside tr:nth-child(even){border-bottom: 1px solid #ddd;}
	#bedRoomAside td{text-align: center;}
	#bedRoomAside img{width:100px; height:100px;}
	
	#bedRoomVisual {width: 100%; height: 500px; margin:0 auto;}
	
	.topSeller{width:100%; height:40px; border-bottom:1px solid; background-color: #555;
				text-align: center; font: bold; color: white; padding-top:5px;}
				
	.rankFont{width:100%; font: bold; font-size: 2em; text-align: center; margin-top:10px; margin: 0 auto;}
	
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
	.img img {width: 100%; height: 200px;}
	.img a{color:#13132f; text-decoration: none;}
	.img a:hover{color:#EDA900; text-decoration: none;}
	
	.desc {padding: 15px; text-align: center;}
	
	#productRegister {text-align: right; padding-right: 55px;}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script>
	var showList;
	
	$(document).ready(function(){
		
		if($.cookie("showList") != null){
			showList = $.cookie("showList").split(',');
			$.each(showList,function(idx,obj){
				var showDTO = obj.split('&');
				var bnum = showDTO[0];
				var image1 = showDTO[1];
				var name = showDTO[2];
				var price = showDTO[3];
				var discount = showDTO[4];
				var imagePath = "ProductRegisterImg/"+bnum+"_"+name+"/"+image1;
					$("#bedRoomAside").children("table").append("<tr><td rowspan='2'><a href='BedRoomDetailServlet?bnum="+bnum+"'><img src='"+imagePath+"'></a></td><td><a href='BedRoomDetailServlet?bnum="+bnum+"'>"+name+"</a></td></tr><tr><td><img style='width:1em; height:1em;' src='images/bedRoom/won_16.png'>"+price*(1.0 - discount/100)+" <a href='javascript:deleteShowList("+bnum+");'><img style='width:1em; height:1em;' src='images/bedRoom/cancel.png'></a></td></tr>");
			}); // end $.each(showList,function(idx,obj)
		}// end if($.cookie("showList") != null)
			
		$("#productRegisterUIBtn").on("click",function(){
			location.replace("ProductRegisterUIServlet");
		});
			
	}); // end &(document).ready();
	
	function bedRoomDetail(bnum,image1,name,price,discount){
		var addList = true;
		
		$.each(showList,function(idx,obj){
			if(obj == bnum+"&"+image1+"&"+name+"&"+price+"&"+discount){
				addList = false;
				return false;  // break
			}
		});
		
		if($.cookie("showList") == null){
			$.cookie("showList",bnum+"&"+image1+"&"+name+"&"+price+"&"+discount,{ expires : (1/24/60)*5 }); 
		}else if(addList == true){
			$.cookie("showList",$.cookie("showList")+","+bnum+"&"+image1+"&"+name+"&"+price+"&"+discount,{ expires : (1/24/60)*5 });
		}
		location.replace("BedRoomDetailServlet?bnum="+bnum);
		
	}// bedRoomDetail(bnum,image1,name,price,discount)
	
	function deleteShowList(bnum){
		var filter = $.grep(showList,function(obj,idx){
			var ampersand = obj.indexOf('&');
			return obj.slice(0,ampersand) == bnum;
		},true);
		
		if(filter.length == 0){ $.removeCookie("showList"); }
		else{ $.cookie("showList",filter); }
		
		location.reload();
	}// function deleteShowList(bnum)
	
	//상품을 삭제하는 함수
	function productDelete(bnum){
		$.ajax({
			type:"get",
			url:"admin/productDelete.jsp",
			dataType:"text", // 받을 타입
			async: true, // 비동기
			data:{
				bnum:bnum
			},
			success:function(responseData,status,xhr){
				alert(responseData.trim());
				location.reload();
			},
			error:function(error){
				alert(error);
			}
		}); // $.ajax();
	}//productDelete(bnum)
</script>

</head>
<body>
	<c:set var="bedRoomPageDTO" value="${bedRoomPageDTO}" scope="request"/> <!-- 페이징 처리에 필요한 data가진 class -->
	<c:set var="bedRoomList" value="${bedRoomPageDTO.bedRoomList}" scope="request"/> <!-- 페이지에 보여줄 리스트 -->
	<c:set var="bestBedRoomList" value="${bestBedRoomPageDTO.bedRoomList}" scope="request"/> <!-- 인기상품 세 개의 리스트 -->
	
	<c:set var="curPage" value="${bedRoomPageDTO.curPage}" scope="request"/> <!-- 요청된 현재 페이지 -->
	<c:set var="perPage" value="${bedRoomPageDTO.perPage}" scope="request"/> <!-- 페이지 당 보여줄 리스트 수(9) -->
	<c:set var="page" value="${bedRoomPageDTO.page}" scope="request"/> <!-- 표시할 페이지 수 -->
	<c:set var="pageblock" value="${Math.ceil(curPage/page)}" scope="request"/> <!-- 표시할 페이지 블럭수 -->
	<c:set var="totalRecord" value="${bedRoomPageDTO.totalRecord}" scope="request"/> <!-- 전체 게시물 수 -->
	
	<div id="wrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		<div id="bedRoomWrap">
			<h3>침실 가구</h3>
			<hr>
			<div id="bedRoomContent">
				<div id="bedRoomVisual">
					<div class="topSeller">
						TOP SELLER
					</div>	<!-- topSeller -->
					<br>
					<div id="content_22">
						<div class="contents_22_product">
							<ul class="contents_33_product_images">
								<c:forEach var="bestBedRoomDTO" items="${bestBedRoomList}" varStatus="status">
									<li>
										<center><p class="rankFont">BEST ${status.count}</p></center><br>
						            	<div class="img">
						            		<a href="javascript:bedRoomDetail(${bestBedRoomDTO.bnum},'${bestBedRoomDTO.image1}','${bestBedRoomDTO.name }',${bestBedRoomDTO.price},${bestBedRoomDTO.discount});">
						            		
						    					<img src="ProductRegisterImg/${bestBedRoomDTO.bnum}_${bestBedRoomDTO.name}/${bestBedRoomDTO.image1}" width="100%" height="275">
								  				
								  				<div class="desc"><b>
								  					${bestBedRoomDTO.name}<br>
								  					<font color="#7777ca"><del><fmt:formatNumber value="${bestBedRoomDTO.price}" type="currency" /></del></font><br>
								  					<c:set var="bestDiscountPrice" value="${bestBedRoomDTO.price * (1.0 - (bestBedRoomDTO.discount/100))}" />
								  					<span class="discountPrice"><fmt:formatNumber value="${bestDiscountPrice}" type="currency" /></span>
								  				</b></div>
							  				</a>
										</div>
					            	</li>  
								</c:forEach>
					
							</ul> <!-- contents_2_product_images -->
						</div> <!-- contents_2_product -->
					</div>	<!-- contents_22 -->
					
				</div>	<!-- bedRoomVisual -->
				<br><br><br>
				<div class="categoryList">
					<ul>
						<li><a href="BedRoomListServlet?curPage=${curPage}&category=0&sortValue=${sortValue}">전체</a></li>
						<li><a href="BedRoomListServlet?curPage=${curPage}&category=1&sortValue=${sortValue}">서랍</a></li>
						<li><a href="BedRoomListServlet?curPage=${curPage}&category=2&sortValue=${sortValue}">화장대</a></li>
						<li><a href="BedRoomListServlet?curPage=${curPage}&category=3&sortValue=${sortValue}">매트리스</a></li>
						<li><a href="BedRoomListServlet?curPage=${curPage}&category=4&sortValue=${sortValue}">침대</a></li>
						<li><a href="BedRoomListServlet?curPage=${curPage}&category=5&sortValue=${sortValue}">옷장</a></li>
					</ul>
				</div>
				
				<h5 class="sortValueClass">
					<a href="BedRoomListServlet?curPage=${curPage}&category=${category}&sortValue=bnum">[최신순]</a>  |  
					<a href="BedRoomListServlet?curPage=${curPage}&category=${category}&sortValue=priceAsc">[가격 낮은 순]</a>  |  
					<a href="BedRoomListServlet?curPage=${curPage}&category=${category}&sortValue=priceDesc">[가격 높은 순]</a>  |  
					<a href="BedRoomListServlet?curPage=${curPage}&category=${category}&sortValue=buyCountDesc">[판매 인기 순]</a>
				</h5> 
				
				<div id="content_22">
					<div class="contents_22_product">
						<ul class="contents_22_product_images">
						
							<c:forEach var="bedRoomDTO" items="${bedRoomList}" varStatus="status">
								<li>
					            	<div class="img">
					            	
										<a href="javascript:bedRoomDetail(${bedRoomDTO.bnum},'${bedRoomDTO.image1}','${bedRoomDTO.name }',${bedRoomDTO.price},${bedRoomDTO.discount});">
						    				
						    				<img src="ProductRegisterImg/${bedRoomDTO.bnum}_${bedRoomDTO.name}/${bedRoomDTO.image1}" width="100%" height="275">
						    				
							  				<div class="desc"><b>
							  					${bedRoomDTO.name}<br>
							  					<font color="#7777ca"><del><fmt:formatNumber value="${bedRoomDTO.price}" type="currency" /></del></font><br>
							  					<c:set var="discountPrice" value="${bedRoomDTO.price * (1.0 - (bedRoomDTO.discount/100))}" />
							  					<span class="discountPrice"><fmt:formatNumber value="${discountPrice}" type="currency" /></span>
							  				</b></div>
						  				</a>
						  				<c:if test="${sessionScope.login.id == 'admin'}">
											<center><button onclick="productDelete('${bedRoomDTO.bnum}')">상품 삭제</button></center>
										</c:if>
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
				
				<c:if test="${sessionScope.login.id == 'admin'}">
					<div id="productRegister">
						<button id="productRegisterUIBtn">상품 등록</button>
					</div>
				</c:if>
			
				<!-- 페이징처리 -->
				<c:if test="${pageblock*page <= Math.ceil(totalRecord/perPage)}">
					<c:set var="endPage" value="${pageblock*page}" scope="request"/>
				</c:if>
				<c:if test="${pageblock*page > Math.ceil(totalRecord/perPage)}">
					<c:set var="endPage" value="${Math.ceil(totalRecord/perPage)}" scope="request"/>
				</c:if>
						
				<div class="paging">
					<c:if test="${curPage != 1}">
						<p><a href="BedRoomListServlet?curPage=1&category=${category}&sortValue=${sortValue}">[처음]</a>
					</c:if>
					
					<c:if test="${pageblock > 1}">
						<a href="BedRoomListServlet?curPage=${Math.round((pageblock*page)-19)}&category=${category}&sortValue=${sortValue}">
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
								<a href="BedRoomListServlet?curPage=${i}&category=${category}&sortValue=${sortValue}">
									${i}
								</a>
							</c:otherwise>
						</c:choose>
					</c:forEach> &nbsp;
					
					<c:if test="${pageblock != Math.ceil((totalRecord/perPage+1)/page)}">
						<a href="BedRoomListServlet?curPage=${Math.round((pageblock*page)+1)}">
							[다음]
						</a>
					</c:if>
					
					<c:if test="${curPage != Math.ceil(totalRecord/perPage)}">
						<a href="BedRoomListServlet?curPage=${Math.round((totalRecord/perPage ))}&category=${category}&sortValue=${sortValue}">
							[끝]
						</a></p>
					</c:if>
				</div>
			</div> <!-- #bedRoomContent -->
			
			<div id="bedRoomAside">
				오늘 본 상품
				<table></table>
			</div> <!-- #bedRoomAside -->
		</div> <!-- #bedRoomWrap -->
		<br>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- wrap -->
</body>
</html>
