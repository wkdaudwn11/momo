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
	#childrenRoomDetailWrap{width: 70%; height: 350em; margin: 0 auto;}
	
	
	#childrenRoomDetailVisual{width: 100%; height: 20em;}
	
	#childrenRoomDetailVisualleft{width: 50%; height: 100%; float: left;}
	
	#childrenRoomDetailVisualRight{height: 100%;}
	.visualRightTable{margin: 0 auto; text-align: left;}
	.visualRightTable .productName{color: gray; font-size: 15px; font: bold;}
	.visualRightTable .productPrice{color: #5b6bdf; font-size: 15px; font: bold;}
	.visualRightTable .productPrice2{color: red; font-size: 15px; font: bold;}
	.visualRightTable .productPrice3{color: #3f4993; font-size: 15px; font: bold;}
	
	#childrenRoomDetailContent{width: 70%; height: 90%; margin: 0 auto;}
</style>

<script>
	function rightOrder(detailForm){
		var productCount = detailForm.productCnt.value;
		
		if(productCount > 0 && productCount < 10){
			detailForm.action="OrderSheetUIServlet?category=childrenRoom";
			detailForm.submit();
		}else{
			alert("수량이 잘못되었습니다. 다시 확인해주세요.");
		}
	}//rightOrder(detailForm)
	
	function addCart(detailForm, name){
		
		var productCount = detailForm.productCnt.value;
		
		if(productCount > 0 && productCount < 10){
			detailForm.action="http://localhost:8090/momo/CartAddServlet?category=childrenRoom&productCount="+productCount;
			detailForm.submit();
		}else{
			alert("수량이 잘못되었습니다. 다시 확인해주세요.");
		}
	}//addCart(detailForm)
	
	function submitCheck(){
		
	}
</script>

</head>
<body>

<c:if test="${loginFail != null}">
	<script>
		alert('${loginFail}');
	</script>
</c:if>

<c:if test="${addCartSuccess != null}">
	<script>
		var result = confirm('${addCartSuccess}');
		if(result == true){
			location.replace('CartListServlet');
		}
	</script>
</c:if>

<jsp:include page="../include/header.jsp" flush="true"></jsp:include>

<div id="childrenRoomDetailWrap">
	<h3>${ChildrenRoomDTO.name}</h3>
	<hr>
	
	<div id="childrenRoomDetailVisual">
		<div id="childrenRoomDetailVisualleft">
			<center>
				<img src="http://localhost:8090/momo/images/childrenRoom/${ChildrenRoomDTO.image1}.JPG" width="80%" height="400px">
			</center>
		</div>
		
		<div id="childrenRoomDetailVisualRight">
			<form method="post" name="detailForm" id="detailForm">
				<input type="hidden" name="pnum" value="${ChildrenRoomDTO.cnum}">
				<input type="hidden" name="pname" value="${ChildrenRoomDTO.name}">
				<input type="hidden" name="price" value="${ChildrenRoomDTO.price}">
				<input type="hidden" name="discount" value="${ChildrenRoomDTO.discount}">
				<input type="hidden" name="image1" value="${ChildrenRoomDTO.image1}">
				
				<table class="visualRightTable" width="40%">
					<tr>
						<td class="productName" style="width: 30%">제품명</td>
						<td class="productName"><h4>${ChildrenRoomDTO.name}</h4></td>
					</tr>
					<tr>
						<td class="productPrice">소비자가격</td>
						<td	class="productPrice2">
							<del><fmt:formatNumber value="${ChildrenRoomDTO.price}" type="currency" /></del>
						</td>
					</tr>
					<tr>
						<td class="productPrice">판매가격</td>
						<td class="productPrice3">
							<fmt:formatNumber value="${ChildrenRoomDTO.price * (1.0 - (ChildrenRoomDTO.discount/100))}" type="currency" />
						</td>
					</tr>
				</table>
				<hr>
				<table class="visualRightTable" width="40%" style="background-color: #f1f1f1;">
					<tr>
						<td class="productName" style="width: 30%">원산지</td>
						<td class="productName">한국</td>
					</tr>
					<tr>
						<td class="productName">수량</td>
						<td	class="productName">
							<font size="2">
								<input type="number" name="productCnt" id="productCnt" min="1" max="9" value="1" style="width: 30%; height: 20px;" />
							</font>
						</td>
					</tr>
					<tr>
						<td class="productName">규격</td>
						<td class="productName">
							1625*2105*1000mm
						</td>
					</tr>
					<tr>
						<td class="productName">배송비</td>
						<td class="productName">
							하단 상세정보 참조
						</td>
					</tr>
				</table>
				<hr>
				<center>
					<input type="image" src="http://localhost:8090/momo/images\product/rightOrderBtn.jpg" onclick="rightOrder(detailForm)">&nbsp;&nbsp;
					<input type="image" src="http://localhost:8090/momo/images\product/addCartBtn.jpg" onclick="addCart(detailForm, '${ChildrenRoomDTO.name}')">
				</center>
			</form>
		</div> <!-- childrenRoomDetailVisualRight -->
	</div> <!-- childrenRoomDetailVisual -->
	
	<hr>
	
	<div id="childrenRoomDetailContent">
		<img src="http://localhost:8090/momo/images\childrenRoom/${ChildrenRoomDTO.image2}.jpg" width="100%" height="100%">
	</div>
	
	<hr>
	
</div><!-- childrenRoomDetailWrap -->

<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>

</body>

</html>