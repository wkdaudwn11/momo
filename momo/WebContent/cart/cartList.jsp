<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장바구니</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<style>
	#cartContent {width:60%; margin:0 auto; overflow:hidden;}
	#cartContent h3 {margin-left:0px;}
	
	.cartList {font-size:12px;}
	.cartList th {border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.cartList th {background:#f8f8f8; text-align:center;}
	.cartList td a{color: #3f4993; text-decoration: none;}
	.cartList td a:hover{color: #EDA900; text-decoration: underline;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
</style>

<script>
	$(document).ready(function(){
		//침실가구로 화면으로 이동
		$("#goShopping").on("click", function(){
			location.replace('BedRoomListServlet');
		});
	});
	
	//전체선택과 전체해제
	function checkCartAll(){
		var checkCartAll = document.getElementById("checkCartAll");
		var checkCart = document.getElementsByName("checkCart");
		
		if(checkCartAll.checked == true){
			for(var i = 0; i<checkCart.length; i++){
				checkCart[i].checked = true;
			}
		}else{
			for(var i = 0; i<checkCart.length; i++){
				checkCart[i].checked = false;
			}
		}
	}//checkCartAll()
	
	// 삭제버튼을 눌렀을 경우 실행되는 함수
	function deleteOne(cnum, name){
		var result = confirm(name+'을(를) 장바구니에서 삭제하시겠습니까?');
		if(result == true){
			location.replace('http://localhost:8090/momo/CartDeleteServlet?cnum='+cnum);
		}
	}//deleteOne(cnum, name)
	
	// 수량수정 버튼을 눌렀을 경우 실행되는 함수
	function updateCount(cnum, num){
		var arrayCount = document.getElementsByName("count");
		var count = arrayCount[num-1].value;
		location.replace('http://localhost:8090/momo/CartUpdateCountServlet?cnum='+cnum+'&count='+count);
	}//updateCount(cnum, num)
	
	//체크된 것들을 삭제하는 함수
	function checkCart(cartForm){
		
		var checkCart = document.getElementsByName("checkCart");
		var count = 0;
		
		for(var i = 0; i<checkCart.length; i++){
			if(checkCart[i].checked == true){
				count++;
			}
		}
		
		if(count >= 1){
			cartForm.action="CartDeleteServlet";
			cartForm.submit();
		}else{
			alert('최소 1개 이상 체크해주세요.');
		}
	}//checkCart(cartForm)
	
	//체크된 것들을 주문하는 함수
	function checkOrder(cartForm){
		
		var checkCart = document.getElementsByName("checkCart");
		var count = 0;
		
		for(var i = 0; i<checkCart.length; i++){
			if(checkCart[i].checked == true){
				count++;
			}
		}
		
		if(count >= 1){
			cartForm.action="OrderSheetUIServlet";
			cartForm.submit();
		}else{
			alert('최소 1개 이상 체크해주세요.');
		}
	}
</script>

</head>
<body>
	<c:set var="cartPageDTO" value="${cartPageDTO}" scope="request"/> <!-- 페이징 처리에 필요한 data가진 class -->
	<c:set var="cartList" value="${cartPageDTO.cartList}" scope="request"/> <!-- 페이지에 보여줄 리스트 -->
	<c:set var="curPage" value="${cartPageDTO.curPage}" scope="request"/> <!-- 요청된 현재 페이지 -->
	<c:set var="perPage" value="${cartPageDTO.perPage}" scope="request"/> <!-- 페이지 당 보여줄 리스트 수(10) -->
	<c:set var="page" value="${cartPageDTO.page}" scope="request"/> <!-- 표시할 페이지 수 -->
	<c:set var="pageblock" value="${Math.ceil(curPage/page)}" scope="request"/> <!-- 표시할 페이지 블럭수 -->
	<c:set var="totalRecord" value="${cartPageDTO.totalRecord}" scope="request"/> <!-- 전체 게시물 수 -->
	<c:set var="x" value="${(curPage-1)*10}" /> <!-- 상품 번호를 나타내기 위한 변수 -->
	
	<div id="cartWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<div id="cartContent">
			<h3>장바구니</h3>
			<hr>
			<p>장바구니 목록(전체: ${totalRecord})</p>
			
			<!-- 장바구니 리스트 -->
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="cartList">
				<tr height="30"> 
					<th width="60">
						<input type="checkbox" name="checkCartAll" id="checkCartAll" onclick="checkCartAll()">
						전체선택
					</th> 
					<th width="50">사   진</th> 
				    <th width="190">제품명</th>
				    <th width="100">수   량</th> 
				    <th width="100">가   격</th>
				    <th width="100">취   소</th>   
				</tr>
				<c:choose>
					<c:when test="${totalRecord == 0}">
						<table>
							<tr>
								<td align="center">
									장바구니에 저장된 상품이 없습니다.
							    </td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<form method="post" name="cartForm" id="cartForm">
							<c:forEach var="cartDTO" items="${cartList}" varStatus="i">
								<tr height="30" style="border-bottom:1px solid #ddd;">
									<td  width="50" align="center" >
										<input type="checkbox" name="checkCart" id="checkCart" class="check" value="${cartDTO.cnum}">&nbsp;
										<b>${(totalRecord - (i.count + x)) + 1}</b>
									</td>
								    <td  width="50" align="center">
								    	<img src="http://localhost:8090/momo/images/${cartDTO.category}/${cartDTO.image1}.JPG" width="50" height="50">
								    </td>
				 					<td width="200" align="center">
				 						<c:if test="${cartDTO.category == 'bedRoom'}">
									    	<a href="http://localhost:8090/momo/BedRoomDetailServlet?bnum=${cartDTO.pnum}">
									    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
									    <c:if test="${cartDTO.category == 'livingRoom'}">
									    	<a href="http://localhost:8090/momo/LivingRoomDetailServlet?lnum=${cartDTO.pnum}">
									    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
									    <c:if test="${cartDTO.category == 'kitchen'}">
									    	<a href="http://localhost:8090/momo/KitchenDetailServlet?knum=${cartDTO.pnum}">
									    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
									    <c:if test="${cartDTO.category == 'childrenRoom'}">
									    	<a href="http://localhost:8090/momo/ChildrenRoomDetailServlet?cnum=${cartDTO.pnum}">
									    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
				 					</td>			    
								    <td width="100" align="center">
										<input type="number" name="count" id="count" min="1" max="9" value="${cartDTO.count}" style="width:35px; align:center;">
										&nbsp;<a href="#"><img src="http://localhost:8090/momo/images\cart/updateCountBtn.jpg" width="40" height="20" onclick="updateCount('${cartDTO.cnum}', '${i.count + x}')"></a>
										<%-- <input type="image" src="http://localhost:8090/momo/images\cart/updateCountBtn.jpg" width="40" height="25" onclick="updateCount('${cartDTO.cnum}', '${i.count + x}')"
											style="padding-top:5px;"> --%>
									</td>
								    <td width="100" align="center">
										<b><font color="red"><del><fmt:formatNumber value="${cartDTO.price * cartDTO.count}" type="currency" /></del></font><br />
										<font color="#3f4993"><fmt:formatNumber value="${(cartDTO.price * (1.0 - (cartDTO.discount/100))) * cartDTO.count}" type="currency" /></font></b>
									</td>
								    <td width="100" align="center">
								    	<a href="#"><img src="http://localhost:8090/momo/images\cart/deleteBtn.jpg" onclick="deleteOne('${cartDTO.cnum}', '${cartDTO.name}')"></a>
										<%-- <input type="image" src="http://localhost:8090/momo/images\cart/deleteBtn.jpg" name="deleteOne" id="deleteOne" 
											onclick="deleteOne('${cartDTO.cnum}', '${cartDTO.name}')"> --%>
									</td>
								</tr>
							</c:forEach>
						</form>
					</c:otherwise>
				</c:choose>
			</table> <!-- cartList -->
			
			<!-- 페이징처리 -->
			<c:if test="${pageblock*page <= Math.ceil(totalRecord/perPage)}">
				<c:set var="endPage" value="${pageblock*page}" scope="request"/>
			</c:if>
			<c:if test="${pageblock*page > Math.ceil(totalRecord/perPage)}">
				<c:set var="endPage" value="${Math.ceil(totalRecord/perPage)}" scope="request"/>
			</c:if>
			
			<div class="paging">
				<c:if test="${curPage != 1}">
					<p><a href="CartListServlet?curPage=1">[처음]</a>
				</c:if>
				
				<c:if test="${pageblock > 1}">
					<a href="http://localhost:8090/momo/CartListServlet?curPage=${Math.round((pageblock*page)-19)}">
						[이전]
					</a>
				</c:if> &nbsp;
				
				 <c:forEach var="i" begin="${(pageblock*page)-(page-1)}" end="${endPage}" >
					<c:choose>
						<c:when test="${curPage == i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="http://localhost:8090/momo/CartListServlet?curPage=${i}">
								${i}
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach> &nbsp;
				
				<c:if test="${pageblock != Math.ceil((totalRecord/perPage+1)/page)}">
					<a href="http://localhost:8090/momo/CartListServlet?curPage=${Math.round((pageblock*page)+1)}">
						[다음]
					</a>
				</c:if>
				
				<c:if test="${curPage != Math.ceil(totalRecord/perPage) && totalRecord != 0}">
					<a href="http://localhost:8090/momo/CartListServlet?curPage=${Math.round((totalRecord/perPage )+1)}">
						[끝]
					</a></p>
				</c:if>
				
				<br>
			</div>	<!-- paging -->
			<br>
			
			<input type="image" src="http://localhost:8090/momo/images\cart/orderBtn.jpg" onclick="checkOrder(cartForm)">
			<input type="image" src="http://localhost:8090/momo/images\cart/checkDeleteBtn.jpg" id="checkDelete" onclick="checkCart(cartForm)">
			<input type="image" src="http://localhost:8090/momo/images\cart/goShoppingBtn.jpg" id="goShopping">
			
		</div> <!-- cartContent -->
		<br><br><br><br>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- cartWrap -->
	
</body>
</html>