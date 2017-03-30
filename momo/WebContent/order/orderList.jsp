<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문내역</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<style>
	#orderContent {width:80%; margin:0 auto; overflow:hidden;}
	#orderContent h3 {margin-left:0px;}
	
	.orderList {font-size:12px;}
	.orderList th {border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.orderList th {background:#f8f8f8; text-align:center;}
	.orderList td a{color: #3f4993; text-decoration: none;}
	.orderList td a:hover{color: #EDA900; text-decoration: underline;}
	
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
	function checkOrderAll(){
		var checkOrderAll = document.getElementById("checkOrderAll");
		var checkOrder = document.getElementsByName("checkOrder");
		
		if(checkOrderAll.checked == true){
			for(var i = 0; i<checkOrder.length; i++){
				checkOrder[i].checked = true;
			}
		}else{
			for(var i = 0; i<checkOrder.length; i++){
				checkOrder[i].checked = false;
			}
		}
	}//checkCartAll()
	
	// 삭제버튼을 눌렀을 경우 실행되는 함수
	function deleteOne(cnum, name){
		var result = confirm(name+'을(를) 주문내역에서 삭제하시겠습니까?');
		if(result == true){
			location.replace('OrderDeleteServlet?onum='+onum);
		}
	}//deleteOne(cnum, name)
	
	//체크된 것들을 삭제하는 함수
	function deleteCheck(orderForm){
		
		var checkOrder = document.getElementsByName("checkOrder");
		var count = 0;
		
		for(var i = 0; i<checkOrder.length; i++){
			if(checkOrder[i].checked == true){
				count++;
			}
		}
		
		if(count >= 1){
			orderForm.action="OrderDeleteServlet";
			orderForm.submit();
		}else{
			alert('최소 1개 이상 체크해주세요.');
		}
	}//deleteCheck(orderForm)

</script>

</head>
<body>
	<c:set var="orderPageDTO" value="${orderPageDTO}" scope="request"/> <!-- 페이징 처리에 필요한 data가진 class -->
	<c:set var="orderList" value="${orderPageDTO.orderList}" scope="request"/> <!-- 페이지에 보여줄 리스트 -->
	<c:set var="curPage" value="${orderPageDTO.curPage}" scope="request"/> <!-- 요청된 현재 페이지 -->
	<c:set var="perPage" value="${orderPageDTO.perPage}" scope="request"/> <!-- 페이지 당 보여줄 리스트 수(10) -->
	<c:set var="page" value="${orderPageDTO.page}" scope="request"/> <!-- 표시할 페이지 수 -->
	<c:set var="pageblock" value="${Math.ceil(curPage/page)}" scope="request"/> <!-- 표시할 페이지 블럭수 -->
	<c:set var="totalRecord" value="${orderPageDTO.totalRecord}" scope="request"/> <!-- 전체 게시물 수 -->
	<c:set var="x" value="${(curPage-1)*10}" /> <!-- 상품 번호를 나타내기 위한 변수 -->
	
	<div id="orderWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<div id="orderContent">
			<h3>주문내역</h3>
			<hr>
			<p>주문 목록(전체: ${totalRecord})</p>
			
			<!-- 주문내역 리스트 -->
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="cartList">
				<tr height="30"> 
					<th width="60">
						<input type="checkbox" name="checkOrderAll" id="checkOrderAll" onclick="checkOrderAll()">
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
									주문내역이 없습니다.
							    </td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<form method="post" name="orderForm" id="orderForm">
							<c:forEach var="cartDTO" items="${orderList}" varStatus="i">
								<tr height="30" style="border-bottom:1px solid #ddd;">
									<td  width="50" align="center" >
										<input type="checkbox" name="checkOrder" id="checkOrder" class="check" value="${orderDTO.onum}">&nbsp;
										<b>${(totalRecord - (i.count + x)) + 1}</b>
									</td>
								    <td  width="50" align="center">
								    	<img src="images/${orderDTO.category}/${orderDTO.image1}.JPG" width="50" height="50">
								    </td>
				 					<td width="200" align="center">
				 						<c:if test="${orderDTO.category == 'bedRoom'}">
									    	<a href="BedRoomDetailServlet?bnum=${orderDTO.pnum}">
									    		<b>${orderDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
									    <c:if test="${orderDTO.category == 'livingRoom'}">
									    	<a href="LivingRoomDetailServlet?lnum=${orderDTO.pnum}">
									    		<b>${orderDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
									    <c:if test="${orderDTO.category == 'kitchen'}">
									    	<a href="KitchenDetailServlet?knum=${orderDTO.pnum}">
									    		<b>${orderDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
									    <c:if test="${orderDTO.category == 'childrenRoom'}">
									    	<a href="ChildrenRoomDetailServlet?cnum=${orderDTO.pnum}">
									    		<b>${orderDTO.name}</b>&nbsp;&nbsp;
									    	</a> 
									    </c:if>
				 					</td>			    
								    <td width="100" align="center">
								    	${orderDTO.count}
									</td>
								    <td width="100" align="center">
										<b><font color="red"><del><fmt:formatNumber value="${orderDTO.price * orderDTO.count}" type="currency" /></del></font><br />
										<font color="#3f4993"><fmt:formatNumber value="${(orderDTO.price * (1.0 - (orderDTO.discount/100))) * orderDTO.count}" type="currency" /></font></b>
									</td>
								    <td width="100" align="center">
								    	<a href="#"><img src="images\cart/deleteBtn.jpg" onclick="deleteOne('${orderDTO.onum}', '${orderDTO.name}')"></a>
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
					<p><a href="OrderListUIServlet?curPage=1">[처음]</a>
				</c:if>
				
				<c:if test="${pageblock > 1}">
					<a href="OrderListUIServlet?curPage=${Math.round((pageblock*page)-19)}">
						[이전]
					</a>
				</c:if> &nbsp;
				
				 <c:forEach var="i" begin="${(pageblock*page)-(page-1)}" end="${endPage}" >
					<c:choose>
						<c:when test="${curPage == i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="OrderListUIServlet?curPage=${i}">
								${i}
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach> &nbsp;
				
				<c:if test="${pageblock != Math.ceil((totalRecord/perPage+1)/page)}">
					<a href="OrderListUIServlet?curPage=${Math.round((pageblock*page)+1)}">
						[다음]
					</a>
				</c:if>
				
				<c:if test="${curPage != Math.ceil(totalRecord/perPage) && totalRecord != 0}">
					<a href="OrderListUIServlet?curPage=${Math.round((totalRecord/perPage )+1)}">
						[끝]
					</a></p>
				</c:if>
				
				<br>
			</div>	<!-- paging -->
			<br>
			
			<input type="image" src="images\cart/orderBtn.jpg" onclick="checkOrder(cartForm)">
			<input type="image" src="images\cart/checkDeleteBtn.jpg" id="checkDelete" onclick="deleteCheck(cartForm)">
			<input type="image" src="images\cart/goShoppingBtn.jpg" id="goShopping">
			
		</div> <!-- cartContent -->
		<br><br><br><br>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- cartWrap -->
	
</body>
</html>