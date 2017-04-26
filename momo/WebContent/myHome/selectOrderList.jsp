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
	$(document).ready(function (){
		
		$("#choiceBtn").on("click",function(){
			
			//var checkOrder = document.getElementsByName("singleProduct"); // 상품 리스트 들
			var productList = $("[name='singleProduct']");
			var checkedProductNum = $.map(productList,function(obj,idx){	// 체크된 상품의 상품번호(onum) 
					if(obj.checked){	return obj.value;	}
			}); // end $.map(return obj.val(););
			var checkProductName = $.map(productList,function(obj,idx){	// 체크된 상품의 상품이름(name)
				if(obj.checked){	return $(".productName").eq(idx).text();	}
			}); // end $.map(return  $(".productName"));
			
			opener.parent.orderList(checkedProductNum,checkProductName);
			window.close();
		});//$("#choiceBtn").on("click",function()
				
		$("#cancelBtn").on("click",function(){
			window.close();
		});//$("#choiceBtn").on("click",function()
		
	}); // end $(document).ready({});
	
	// 'ㅁㅁ외 ㅁ건'인 제목을 클릭 했을 때
	function groupDivFunc(orderListNumber){
		$(".toggleTr"+orderListNumber).toggle(400);
	}
	
	// 'ㅁㅁ외 ㅁ건'인 항목의 체크박스를 클릭 했을 때
	function productPack(orderListNumber){
		
		var pack = document.getElementById("pack"+orderListNumber);
		var $included = $(".includedProduct"+orderListNumber);
		$.each($included,function(idx,obj){
			obj.checked = pack.checked;
		});
		
		includeProduct(orderListNumber);
		
	}//checkGroupDivFunc(orderListNumber, realProductCount, equalGroupCount)
	
	//그룹 내의 체크박스를 클릭 할 경우 실행되는 함수
	function includeProduct(orderListNumber){
		var checkAll = document.getElementById("checkAll");
		var pack = document.getElementById("pack"+orderListNumber);
		var $included = $(".includedProduct"+orderListNumber); // 묶음 상품에 포함된 상품 리스트
		var checkList = $included.map(function( idx , element ){
			 if(element.checked){ return idx;}
		}); // 체크된 리스트
		
		if(checkList.length == $included.length){
			pack.checked = true;
			$(".toggleTr"+orderListNumber).show(400);
		}else{
			if(checkList.length == 0){
				$(".toggleTr"+orderListNumber).hide();
			}
			pack.checked = false;
			checkAll.checked = false;
		}
	}//checkOrderDivFunc(orderListNumber, realProductCount, equalGroupCount)
	
	//전체선택과 전체해제
	function checkOrderAll(){
		var checkAll = document.getElementById("checkAll");
		$(":checkbox").each(function(idx,element){
			element.checked = checkAll.checked;
		});
		
	}//checkOrderAll()
	
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
	<c:set var="totalRecordDistinct" value="${orderPageDTO.totalRecordDistinct}" scope="request"/> <!-- groupnum 중복값을 제거한 전체 게시물 수 -->
	<c:set var="x" value="${(curPage-1)*10}" /> <!-- 상품 번호를 나타내기 위한 변수 -->
	
	<div id="orderWrap">
		
		<div id="orderContent">
			<h3>주문내역</h3>
			<hr>
			<p>주문 목록(전체: ${totalRecordDistinct})</p>
			
			<!-- 주문내역 리스트 -->
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="orderList">
				<tr height="30"> 
					<th width="60">
						<input type="checkbox" name="checkOrderAll" id="checkAll" onchange="checkOrderAll()">
						전체
					</th> 
					<th width="50">사   진</th> 
				    <th width="150">제품명</th>
				    <th width="50">수   량</th> 
				    <th width="100">가   격</th>
				    <th width="90">주문상태</th>
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
						
							<c:set var="prevGroupnum" value="-1" />	<!-- 이전 상품에 대한 그룹번호 -->
							<c:set var="prevIndex" value="0" />	<!-- 한 그룹당 표시할 주문번호 -->
							
							<c:set var="minus" value="0" />	<!-- 동일한 그룹번호의 총 갯수를 담을 변수 (주문번호 표시에 사용)-->
							
							<!-- 밑에 반복문은 정확하게 상품의 갯수만큼 반복문을 도는 게 아니다.
								예를들어 주문내역이 ㅁㅁ외 2건, ㅁㅁㅁ. 이렇게 두 개가 있다고 치자.
								ㅁㅁ외 2건은 총 3개의 상품이다. +ㅁㅁㅁ까지 하면 상품의 갯수는 총 4개다.
								그러나 반복문은 5번을 돌게 된다. 그래서 반복문의 index값인 varStatus로는
								정확한 상품의 갯수를 알 수가 없다. 그래서 따로 정확한 상품의 갯수를 알기 위한 변수를 만들었다.
								크게 3개의 if문이 있는데 'orderDTO.equalGroupCount > 1' 이라는 조건의 if문빼고
								나머지 2개의 if문을 탈 때는 이 변수를 +1씩 증가시켜준다.
								위에서 생략한 if문의 경우, ㅁㅁ외 ㅁ건이라고 표시해주는 if문이기 때문에
								수량과는 관계가 없기 때문. '진짜상품갯수' 라는 의미로 realProductCount라고 이름을 지었다. -->
							<c:set var="realProductCount" value="0"/>
							
							<c:forEach var="orderDTO" items="${orderList}" varStatus="i" >
								
								<input type="hidden" name="productTotalNum" value="${i.count}">
								<input type="hidden" name="equalGroupCount" value="${orderDTO.equalGroupCount}">
								
								<c:if test="${prevGroupnum == orderDTO.groupnum}">
									<c:set var="minus" value="${minus+1}" />
								</c:if>
								
								<!-- 이전에 뿌려진 리스트와 묶인 상품이 아니면  -->
								<c:if test="${prevGroupnum != orderDTO.groupnum}">
									<c:set var="prevGroupnum" value="${orderDTO.groupnum}" />
									<c:set var="prevIndex" value="${i.count-minus}" />
									
									<c:set var="orderListNumber" value="${(totalRecordDistinct - (prevIndex + x)) + 1}" />
									
									<!-- 단일 상품 리스트 뿌려주는 곳 -->
									<c:if test="${orderDTO.equalGroupCount == 1}">
										<c:set var="realProductCount" value="${realProductCount+1}"/>
										<tr height="30" style="border-bottom:1px solid #ddd;">
											<td  width="50" align="center" >
												<input type="checkbox" name="singleProduct" value="${orderDTO.onum}">&nbsp;
	//////////////////											<b>${totalRecord}//${totalRecordDistinct}//${orderList.size()}///${orderDTO.equalGroupCount}//${i.count}//${i.index}</b>
		/////////////////											<b>${totalRecord - i.index}</b>
											</td>
										    <td  width="50" align="center">
										    	<img src="images/${orderDTO.category}/${orderDTO.image1}.JPG" width="50" height="50">
										    </td>
						 					<td width="160" align="center"> <!-- equalGroupCount -->
										    	<div id="oneDiv" onclick="oneDivFunc('${orderDTO.category}', '${orderDTO.pnum}')">
									    			<b class="productName">${orderDTO.pname}</b>&nbsp;&nbsp;
									    		</div>
						 					</td>			    
										    <td width="50" align="center">
										    	${orderDTO.count}개
											</td>
										    <td width="100" align="center">
												<b><font color="#3f4993"><fmt:formatNumber value="${(orderDTO.price * (1.0 - (orderDTO.discount/100))) * orderDTO.count}" type="currency" /></font></b>
											</td>
											<td width="90" align="center">
										    	${orderDTO.orderstate}
											</td>
										</tr>
									</c:if> <!-- orderDTO.equalGroupCount == 1 -->
									
									<!-- ㅁㅁ외 ㅁ건의 제목을 뿌려주는 if문 -->
									<!-- 묶음상품의 제목을 뿌려주는 곳 -->
									<c:if test="${orderDTO.equalGroupCount > 1}">
										<tr height="30" style="border-bottom:1px solid #ddd;">
											<td width="50" align="center" >
												<div>
													<input type="checkbox"  id="pack${orderListNumber}" value="${orderDTO.groupnum}" onchange="productPack('${orderListNumber}')">&nbsp;
	//////////////												<b>${totalRecord}//${totalRecordDistinct}//${orderList.size()}///${orderDTO.equalGroupCount}//${i.count}//${i.index}</b>
	/////////////////											<b>${totalRecord - i.index}</b>
												</div>
											</td>
										    <td width="50" align="center">
										    	<img src="images/${orderDTO.category}/${orderDTO.image1}.JPG" width="50" height="50">
										    </td>
						 					<td width="150" align="center">
					 							<a href="#">
											    	<div id="groupDiv" onclick="groupDivFunc('${orderListNumber}')">
														<b>${orderDTO.pname}&nbsp;외&nbsp;${orderDTO.equalGroupCount-1}개</b>&nbsp;&nbsp;
													</div>
												</a>
						 					</td>			    
										    <td width="50" align="center">
										    	${orderDTO.equalGroupTotalCount}개
											</td>
										    <td width="100" align="center">
												<b><font color="#3f4993"><fmt:formatNumber value="${orderDTO.equalGroupTotalPrice}" type="currency" /></font></b>
											</td>
											<td width="90" align="center">
										    	${orderDTO.orderstate}
											</td>
										</tr>
									</c:if> <!-- orderDTO.equalGroupCount > 1 -->
								</c:if> <!-- prevGroupnum != orderDTO.groupnum -->
								
								<!-- 이전 상품과 현재 상품의 그룹번호가 같으면 (ㅁㅁ외 ㅁ건의 제목을 눌렀을 때 밑에 나타나는 품목들) -->
								<!-- 묶음 상품 의 단일 리스트 뿌려주는 곳 -->
								<c:if test="${prevGroupnum == orderDTO.groupnum && orderDTO.equalGroupCount > 1}">
									<c:set var="realProductCount" value="${realProductCount+1}"/>
									<tr class="toggleTr${orderListNumber}" height="30" style="display: none; border-bottom: 1px solid #ddd; background-color: #f6f6f6;">
										<td colspan="7">
											<table><tr>
												<td width="200" align="center">
													<div>
														<input type="checkbox" name="singleProduct" class="includedProduct${orderListNumber}" value="${orderDTO.onum}" onchange="includeProduct('${orderListNumber}')">&nbsp;
													</div>
												</td>
												<td width="150" align="left"> 
													<img src="images/${orderDTO.category}/${orderDTO.image1}.JPG" width="50" height="50"> 
												</td>
												<td width="190" align="center"> 
										    		<div id="oneDiv" onclick="oneDivFunc('${orderDTO.category}', '${orderDTO.pnum}')">
										    			<b class="productName">${orderDTO.pname}</b>&nbsp;&nbsp;
										    		</div>
												</td>
												<td width="195" align="center">
													${orderDTO.count}개
												</td>
												<td width="100" align="center">
													<b><font color="red"><del><fmt:formatNumber value="${orderDTO.price * orderDTO.count}" type="currency" /></del></font><br />
													<font color="#3f4993"><fmt:formatNumber value="${(orderDTO.price * (1.0 - (orderDTO.discount/100))) * orderDTO.count}" type="currency" /></font></b>
												</td>
											</tr></table>
										</td>
									</tr>
								</c:if>
									
							</c:forEach>
						</form>
					</c:otherwise>
				</c:choose>
			</table> <!-- orderList -->
			
			<br>
			
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
			
			<input type="button" value="선택" id="choiceBtn">
			<input type="button" value="취소" id="cancelBtn" >
			
		</div> <!-- orderContent -->
		<br><br><br><br>
	</div> <!-- orderWrap -->
	
</body>
</html>