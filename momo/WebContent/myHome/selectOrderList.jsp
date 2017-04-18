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
			
			var checkedProduct = new Array(); // 체크된 상품 담을 배열
			var checkOrder = document.getElementsByName("checkOrder");
			
			for(var i = 0; i<checkOrder.length; i++){
				if(checkOrder[i].checked == true){
					checkedProduct[i] = checkOrder[i].value;
				}
			}
			
			/* 마미홈자랑 글쓰기 화면에서 [주문내역보기] 버튼을 눌렀을 때, 제목과 내용을 서블릿으로 넘겨주는데, 그 넘겨받은 값을 서블릿으로부터 다시 받음.
			팝업창에서 [선택] 버튼을 누르면 팝업창이 닫히고 부모창이 reload 되면서, 사용자가 입력했던 제목과 내용을 다시 뿌려주기 위함 */
			var title = '${title}';
			var content = '${content}';
			
			opener.parent.location='MyHomeWriteUIServlet?title='+title+"&content="+content+"&checkedProduct="+checkedProduct;
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
	function checkOrderGroupDivFunc(orderListNumber, realProductCount, equalGroupCount){
		
		var checkOrder = document.getElementsByName("checkOrder");
		var checkOrderGroup = document.getElementById("checkOrderGroup"+orderListNumber);
		
		if(checkOrderGroup.checked == true){
			// equalGroupCount: 같은 그룹의 갯수를 뜻하므로, 반복문을 돌릴 횟수로 사용. (3이면 3바퀴)
			// realProductCount: 선택된 그룹 내에서 시작되는 checkOrder의 index값
			for(var i=0; i<equalGroupCount; i++){
				var k = (parseInt(realProductCount)) + i;
				checkOrder[k].checked = true;
			}
			$(".toggleTr"+orderListNumber).show(400);
		}else if(checkOrderGroup.checked == false){
			for(var i=0; i<equalGroupCount; i++){
				var k = (parseInt(realProductCount)) + i;
				checkOrder[k].checked = false;
			}
			$(".toggleTr"+orderListNumber).hide(400);
		}
	}//checkGroupDivFunc(orderListNumber, realProductCount, equalGroupCount)
	
	//그룹 내의 체크박스를 클릭 할 경우 실행되는 함수
	function checkOrderDivFunc(orderListNumber, realProductCount, equalGroupCount, nowProductTotalCount){
		
		var checkOrder = document.getElementsByName("checkOrder");
		var checkOrderGroup = document.getElementById("checkOrderGroup"+orderListNumber);
		
		var count = parseInt(equalGroupCount);
		var totalCount = parseInt(nowProductTotalCount);
		var checkedAll = true; // 그룹 체크박스를 체크할지 안할지 판별하는 변수
		
		// checkIsAllFalse라는 배열변수의 값들이 전부 다 false일 경우엔, 켜져있는 토글을 hide()해준다.
		var checkIsAllFalse = new Array();
		
		// 한 개라도 체크가 풀리면 그룹 체크박스를 해제해준다.
		// 반대로 모두 다 체크가 된 상태라면 그룹 체크박스를 체크해준다.
		for(var i=0; i < count; i++){		
			if(checkOrder[(realProductCount-1)+i].checked == false){	
				checkedAll = false;
				checkIsAllFalse[i] = false;
			}else{
				checkIsAllFalse[i] = true;
			}
		}
		
		if(checkedAll == true){
			checkOrderGroup.checked = true;
		}else if(checkedAll == false){
			checkOrderGroup.checked = false;
		}
		 
		var hideCheck = false; // 이 변수가 false면 현재 toggle로 인해 내려왔던 tr들이 hide된다.
		
		// 위에서 선언했던 checkIsAllFalse 배열 값들 중에 하나라도 true가 있으면 hideCheck변수를 true로 바꿔준다.
		// 하나라도 체크가 되어 있으면 hide()를 하면 안되기 때문.
		/* for(var k=0; k<checkIsAllFalse.length; k++){
			if(checkIsAllFalse[k] == true){
				hideCheck = true;
				break;
			}
		}
		
		if(hideCheck == false){
			$(".toggleTr"+orderListNumber).hide(400);
		} */
	}//checkOrderDivFunc(orderListNumber, realProductCount, equalGroupCount)
	
	//전체선택과 전체해제
	function checkOrderAll(){
		var checkOrderAll = document.getElementById("checkOrderAll");
		var checkOrder = document.getElementsByName("checkOrder");
		var checkOrderGroup = document.getElementsByName("checkOrderGroup");
		
		if(checkOrderAll.checked == true){
			for(var i = 0; i<checkOrder.length; i++){
				checkOrder[i].checked = true;
			}
			for(var k = 0; k<checkOrderGroup.length; k++){
				checkOrderGroup[k].checked = true;
			}
		}else{
			for(var i = 0; i<checkOrder.length; i++){
				checkOrder[i].checked = false;
			}
			for(var k = 0; k<checkOrderGroup.length; k++){
				checkOrderGroup[k].checked = false;
			}
		}
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
						<input type="checkbox" name="checkOrderAll" id="checkOrderAll" onclick="checkOrderAll()">
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
							
							<c:set var="nowProductTotalCount" value="0" />
							
							<c:forEach var="orderDTO" items="${orderList}" varStatus="i" >
								
								<c:set var="nowProductTotalCount" value="${nowProductTotalCount + orderDTO.count}" />
								
								<input type="hidden" name="productTotalNum" value="${i.count}">
								<input type="hidden" name="equalGroupCount" value="${orderDTO.equalGroupCount}">
								
								<c:if test="${prevGroupnum == orderDTO.groupnum}">
									<c:set var="minus" value="${minus+1}" />
								</c:if>
								
								<!-- 같은 그룹이 아니면 실행 (단일제품) -->
								<c:if test="${prevGroupnum != orderDTO.groupnum}">
									<c:set var="prevGroupnum" value="${orderDTO.groupnum}" />
									<c:set var="prevIndex" value="${i.count-minus}" />
									
									<c:set var="orderListNumber" value="${(totalRecordDistinct - (prevIndex + x)) + 1}" />
									
									<c:if test="${orderDTO.equalGroupCount == 1}">
										<c:set var="realProductCount" value="${realProductCount+1}"/>
										<tr height="30" style="border-bottom:1px solid #ddd;">
											<td  width="50" align="center" >
												<input type="checkbox" name="checkOrder" class="check" value="${orderDTO.onum}">&nbsp;
												<b>${orderListNumber}</b>
											</td>
										    <td  width="50" align="center">
										    	<img src="images/${orderDTO.category}/${orderDTO.image1}.JPG" width="50" height="50">
										    </td>
						 					<td width="160" align="center"> <!-- equalGroupCount -->
										    	<div id="oneDiv" onclick="oneDivFunc('${orderDTO.category}', '${orderDTO.pnum}')">
									    			<b>${orderDTO.pname}</b>&nbsp;&nbsp;
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
									<c:if test="${orderDTO.equalGroupCount > 1}">
										<tr height="30" style="border-bottom:1px solid #ddd;">
											<td width="50" align="center" >
												<div id="checkOrderGroupDiv" onclick="checkOrderGroupDivFunc('${orderListNumber}', '${realProductCount}', ${orderDTO.equalGroupCount})">
													<input type="checkbox" name="checkOrderGroup" id="checkOrderGroup${orderListNumber}" class="checkOrderGroup" value="${orderDTO.groupnum}">&nbsp;
													<b>${orderListNumber}</b>
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
								<c:if test="${prevGroupnum == orderDTO.groupnum && orderDTO.equalGroupCount > 1}">
									<c:set var="realProductCount" value="${realProductCount+1}"/>
									<tr class="toggleTr${orderListNumber}" height="30" style="display: none; border-bottom: 1px solid #ddd; background-color: #f6f6f6;">
										<td colspan="7">
											<table><tr>
												<td width="200" align="center">
													<div id="checkOrderDiv" onclick="checkOrderDivFunc('${orderListNumber}', '${realProductCount}', '${orderDTO.equalGroupCount}', '${nowProductTotalCount}')">
														<input type="checkbox" name="checkOrder" class="check" value="${orderDTO.onum}">&nbsp;
													</div>
												</td>
												<td width="150" align="left"> 
													<img src="images/${orderDTO.category}/${orderDTO.image1}.JPG" width="50" height="50"> 
												</td>
												<td width="190" align="center"> 
										    		<div id="oneDiv" onclick="oneDivFunc('${orderDTO.category}', '${orderDTO.pnum}')">
										    			<b>${orderDTO.pname}</b>&nbsp;&nbsp;
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