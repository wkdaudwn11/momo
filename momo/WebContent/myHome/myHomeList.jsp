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
	#headline{margin-top:0;}
	
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
	
	var curPage = ${curPage};		
			
	$(document).scroll(function(){
		var wholeArea = $(document).height();
		var viewArea = $(window).height();
		var invisibleArea = wholeArea - viewArea;
		if($(document).scrollTop() >= invisibleArea -100){
			$.ajax({
				type:"get",
				url:"myHome/appendList.jsp",
				dataType:"html",
				async: false,
				data:{
					"curPage":curPage+1
				},
				success:function(responseData,status,xhr){
					curPage = curPage+1;
					$("#myHomeContent").append(responseData);
				},
				error:function(error){}
				
			}); // end $.ajax();
		}
	});
</script>


</head>
<body>
	
	<div id="wrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<div id="myHomeContent">
			<h3>마이홈자랑</h3>
				<div align="right">
					<a id="writebtn" href="MyHomeWriteUIServlet">자랑하기</a>
				</div>
			<hr id="headline"/>
			
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
					<div class="contents_product">
						<ul class="contents_33_product_images">
						
							<c:forEach var="bestMyHomeDTO" items="${bestMyHomeList}" varStatus="status">
								<c:if test="${bestMyHomeDTO.img == null}">
									<c:set var="bestMainImg" value="ImgNotFound.png"/>
								</c:if>
								<c:forTokens var="img" items="${bestMyHomeDTO.img}" delims="," varStatus="imgSts">
									<c:if test="${imgSts.index == 0}">
										<c:set var="bestMainImg" value="${img}"/>
									</c:if>
								</c:forTokens>
								<li>
					            	<div class="img">
										<a href="MyHomeDetailServlet?hnum=${bestMyHomeDTO.hnum}">
						    				<img src="images/${bestMainImg}" width="95%" height="275">
							  				<div class="desc"><b>
							  					${bestMyHomeDTO.title}<br>
							  				</b></div>
						  				</a>
									</div>
				            	</li>  
							</c:forEach>
				
						</ul> <!-- contents_2_product_images -->
					</div> <!-- contents_2_product -->
				</div>	<!-- contents_22 -->
				
			</div>	<!-- myHomeVisual -->
			
			<hr/>
			
			<div class="content_22">
				<div class="contents_22_product">
					<ul class="contents_22_product_images">
					
						<c:forEach var="myHomeDTO" items="${MyHomeList}" varStatus="status">
							<c:if test="${myHomeDTO.img == null}">
								<c:set var="mainImg" value="ImgNotFound.png"/>
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
		
		</div>
		<br>
		
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- wrap -->
</body>
</html>