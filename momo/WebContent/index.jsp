<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>모모</title>
	
	<!-- menu 슬라이드 (새로고침)-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script> 
		$(document).ready(function(){
		    $(".flip").click(function(){
		        $(".panel").slideToggle("slow");
		    });
		});
	</script>
	
	<style> 
		.panel {display: none;}
	</style>
	
</head>
<body>

	<!-- 회원가입 성공했으면 띄어주는 alert -->
	<c:if test="${!(empty joinMessage)}">
		alert(${joinMessage});
	</c:if>
	
	<%-- 로그인 성공했으면 띄어주는 alert
	<c:if test="${loginMessage != null}">
		<script type="text/javascript">
	  		var x= '${loginMessage}';
	    	alert(x);
	 	</script>
	</c:if> --%>
	
	<!-- 메세지 -->
	<c:if test="${message != null}">
		<script type="text/javascript">
	  		var x= '${message}';
	    	alert(x);
	 	</script>
	</c:if>

	<div id="wrap">
		<jsp:include page="include/header.jsp"></jsp:include>
		
		<div id="visual">
 			<script src="js/jquery.cycle2.js"></script>	 
			<div class="cycle-slideshow" id="buk" cycle-slideshow data-cycle-loader="wait" data-cycle-timeout=5000 data-cycle-fx=scrollHorz>	
				<div class="cycle-pager"></div> 
			    <img src="images\visual/visual_5.jpg" width="100%" height="100%">
			    <img src="images\visual/visual_2.jpg" width="100%" height="100%">
			    <img src="images\visual/visual_3.jpg" width="100%" height="100%">
			    <img src="images\visual/visual_4.jpg" width="100%" height="100%">
			    <img src="images\visual/visual_1.jpg" width="100%" height="100%">
			    <img src="images\visual/visual_6.jpg" width="100%" height="100%">
		    </div>
		</div>	<!-- visual -->
		
		<div id="content_1">
			<h2>상품소개</h2>
			<div class="content1_left">
				<img src="images\content/content_1.jpg" width="100%" height="570px">
			</div>
			<div class="content1_right">
				<img src="images\content/content_2.jpg" width="40%" height="285px">
				<img src="images\content/content_3.jpg" width="40%" height="285px">
			</div>	
		</div>	<!-- content_1 -->
		
		<br />
		
		<div id="content_2">
			<h2>신상품</h2>
			<div class="contents_2_product">
				<ul class="contents_2_product_images">
		        	<li>
		            	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image1','','images/newProduct/5.jpg',1)">
		            		<img src="images/newProduct/1.jpg" width="95%" height="275" id="image1" />
		            	</a>
		            </li>
		            <li>
		   	        	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image2','','images/newProduct/6.jpg',1)">
		   	        		<img src="images/newProduct/2.jpg" width="95%" height="275" id="image2" />
		   	        	</a>
		   	        </li>
		            <li>
		       	    	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image3','','images/newProduct/7.jpg',1)">
		       	    		<img src="images/newProduct/3.jpg" width="95%" height="275" id="image3" />
		       	    	</a>
		       	    </li>
		            <li>
		       	    	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image4','','images/newProduct/8.jpg',1)">
		       	    		<img src="images/newProduct/4.jpg" width="95%" height="275" id="image4" />
		       	    	</a>
		       	    </li>
	        	</ul> <!-- contents_2_product_images -->
			</div> <!-- contents_2_product -->
			
			<div class="contents_2_product">
				<ul class="contents_2_product_images">
		        	<li>
		            	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image5','','images/newProduct/1.jpg',1)">
		            		<img src="images/newProduct/5.jpg" width="95%" height="275" id="image5" />
		            	</a>
		            </li>
		            <li>
		   	        	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image6','','images/newProduct/2.jpg',1)">
		   	        		<img src="images/newProduct/6.jpg" width="95%" height="275" id="image6" />
		   	        	</a>
		   	        </li>
		            <li>
		       	    	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image7','','images/newProduct/3.jpg',1)">
		       	    		<img src="images/newProduct/7.jpg" width="95%" height="275" id="image7" />
		       	    	</a>
		       	    </li>
		            <li>
		       	    	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('image8','','images/newProduct/4.jpg',1)">
		       	    		<img src="images/newProduct/8.jpg" width="95%" height="275" id="image8" />
		       	    	</a>
		       	    </li>
	        	</ul> <!-- contents_2_product_images -->
			</div> <!-- contents_2_product -->
		</div> <!-- content_2 -->
		
		<br />
		
		<div id="content_3">
			<h2>마이홈자랑</h2>
				<ul class="contents_3_myhome_images">
		        	<li>
		            	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myHome1','','images/myHome/myHome1.PNG',1)">
		            		<img src="images/myHome/myHome1.PNG" width="95%" height="275" id="myHome1" />
		            	</a>
		            </li>
		            <li>
		   	        	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myHome2','','images/myHome/myHome2.PNG',1)">
		   	        		<img src="images/myHome/myHome2.PNG" width="95%" height="275" id="myHome2" />
		   	        	</a>
		   	        </li>
		            <li>
		       	    	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myHome3','','images/myHome/myHome3.PNG',1)">
		       	    		<img src="images/myHome/myHome3.PNG" width="95%" height="275" id="myHome3" />
		       	    	</a>
		       	    </li>
		            <li>
		       	    	<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myHome4','','images/myHome/myHome4.PNG',1)">
		       	    		<img src="images/myHome/myHome4.PNG" width="95%" height="275" id="myHome4" />
		       	    	</a>
		       	    </li>
	        	</ul> <!-- contents_3_myhome_images -->
		</div> <!-- content_3 -->
		
		<jsp:include page="include/footer.jsp"></jsp:include>
		
	</div>	<!-- wrap  -->
</body>
</html>