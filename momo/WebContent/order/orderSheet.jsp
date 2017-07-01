<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문서 작성</title>

<!-- DAUM 주소 라이브러리 시작 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="js/daum.js"></script>
<!-- DAUM 주소 라이브러리 끝 -->

<style>
	#orderContent {width:60%; margin:0 auto; overflow:hidden;}
	#orderContent h3 {margin-left:0px;}
	
	.orderList {font-size:12px;}
	.orderList th {border-top:1px solid black; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.orderList th {background:#f8f8f8; text-align:center;}
	.orderList td a{color: #3f4993; text-decoration: none;}
	.orderList td a:hover{color: #EDA900; text-decoration: underline;}
</style>

<script>

	//체크를하면 회원정보의 값을 배송지정보에 넣음.
	function same(){
		var sameCheck = document.getElementById("sameCheck");
		var name = document.getElementById('name');
		var tel = document.getElementById('tel');
		var post1 = document.getElementById('post1');
		var post2 = document.getElementById('post2');
		var addr1 = document.getElementById('addr1');
		var addr2 = document.getElementById('addr2');
		
		if(sameCheck.checked == true){
			name.value = document.getElementById('buyername').value;
			tel.value = document.getElementById('buyertel').value;
			post1.value = document.getElementById('buyerpost1').value;
			post2.value = document.getElementById('buyerpost2').value;
			addr1.value = document.getElementById('buyeraddr1').value;
			addr2.value = document.getElementById('buyeraddr2').value;
		}else{
			name.value = "";
			tel.value = "";
			post1.value = "";
			post2.value = "";
			addr1.value = "";
			addr2.value = "";
		}
	}//same()
	
	function checkOrder(orderForm){
		var inputCheck = true;
		
		var name = document.getElementById('name').value;
		var tel = document.getElementById('tel').value;
		var post1 = document.getElementById('post1').value;
		
		if(name == null || name == ""){
			inputCheck = false;
			alert('이름을 입력해주세요.');
			name.focus();
		}else if(tel == null || tel == ""){
			inputCheck = false;
			alert('연락처 입력해주세요.');
			tel.focus();
		}else if(post1 == null || post1 == ""){
			inputCheck = false;
			alert('주소를 입력해주세요.');
			post1.focus();
		}
		
		if(inputCheck == true){
			orderForm.action="OrderSheetServlet?confirmOK=false";
			if('${sessionScope.login.sns}' != ""){   
				var confirmOK = confirm('입력하신 배송정보를 회원정보로 등록하시겠습니까? \n (이름은 바꿀 수 없습니다.)');
				if(confirmOK == true){
					orderForm.action="OrderSheetServlet?confirmOK=true";
				}
			}
			orderForm.submit();
		}
	}//checkOrder(orderForm)
	
	//주문취소 버튼을 누르면 이전 페이지로 이동
	function backPage(orderForm){
		if(confirm('정말 주문을 취소하시겠습니까?') == true){
			orderForm.action = "${sessionScope.prevPage}";
			orderForm.submit();
		}
	}//backPage(orderForm)
</script>

</head>
<body>
sns: ${sessionScope.login.sns}
<c:set var="totalPrice" value="0" />	<!-- 전체가격 -->

<div id="orderWrap">
	<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
	
	<div id="orderContent">
		<h3>주문서 작성</h3>
		<hr>
		<span><img src="images/order/zzz.jpg" width="10" height="10">&nbsp;주문 상세내역</span>
		
		<!-- 주문 리스트 -->
		<form method="post" name="orderForm" id="orderForm">
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="orderList">
				<tr height="30"> 
					<th width="50">번   호</th> 
					<th width="50">사   진</th> 
				    <th width="200">제품명</th>
				    <th width="100">수   량</th>
				    <th width="100">적립금</th> 
				    <th width="100">가   격</th>
				</tr>
				<c:if test="${cartList != null}">
					<c:forEach var="cartDTO" items="${cartList}" varStatus="i">
						<tr height="30" style="border-bottom:1px dotted #ddd;">
							<td  width="50" align="center" >
								<b>${i.count + x}</b>
							</td>
						    <td  width="50" align="center">
						    	<!-- 상품 등록 버튼을 눌러서 상품을 등록을 했을 경우 -->
								<c:if test="${cartDTO.register == 'o'}">
				   					<img src="ProductRegisterImg/${cartDTO.pnum}_${cartDTO.name}/${cartDTO.image1}" width="50" height="50">
				   				</c:if>
				   				
				   				<!-- DB에서 insert로 상품을 등록했을 경우 -->
				   				<c:if test="${cartDTO.register == 'x'}">
				   					<img src="images/bedRoom/${cartDTO.image1}.JPG" width="50" height="50">
				   				</c:if>
						    </td>
		 					<td width="200" align="center">
		 						<c:if test="${cartDTO.category == 'bedRoom'}">
							    	<a href="BedRoomDetailServlet?bnum=${cartDTO.pnum}">
							    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
							    	</a> 
							    </c:if>
		 						<c:if test="${cartDTO.category == 'livingRoom'}">
							    	<a href="LivingRoomDetailServlet?lnum=${cartDTO.pnum}">
							    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
							    	</a> 
							    </c:if>
							    <c:if test="${cartDTO.category == 'kitchen'}">
							    	<a href="KitchenDetailServlet?knum=${cartDTO.pnum}">
							    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
							    	</a> 
							    </c:if>
							    <c:if test="${cartDTO.category == 'childrenRoom'}">
							    	<a href="ChildrenRoomDetailServlet?cnum=${cartDTO.pnum}">
							    		<b>${cartDTO.name}</b>&nbsp;&nbsp;
							    	</a> 
							    </c:if>
		 					</td>			    
						    <td width="100" align="center">
								${cartDTO.count}
							</td>
							<td width="100" align="center">
						    	0
							</td>
						    <td width="100" align="center">
								<b><font color="red"><del><fmt:formatNumber value="${cartDTO.price * cartDTO.count}" type="currency" /></del></font><br />
								
								<font color="#3f4993"><fmt:formatNumber value="${(cartDTO.price * (1.0 - (cartDTO.discount/100))) * cartDTO.count}" type="currency" /></font></b>
								<c:set var="totalPrice" value="${totalPrice + ((cartDTO.price * (1.0 - (cartDTO.discount/100))) * cartDTO.count)}" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${cartList == null}">
					<input type="hidden" name="pnum" value="${pnum}">
					<input type="hidden" name="category" value="${category}">
					<input type="hidden" name="pname" value="${pname}">
					<input type="hidden" name="count" value="${count}">
					<input type="hidden" name="price" value="${price}">
					<input type="hidden" name="discount" value="${discount}">
					<input type="hidden" name="image1" value="${image1}">
					
					<tr height="30" style="border-bottom:1px dotted #ddd;">
						<td  width="50" align="center" >
							<b>1</b>
						</td>
					    <td  width="50" align="center">
						    <img src="images/${category}/${image1}.JPG" width="50" height="50">
					    </td>
	 					<td width="200" align="center">
	 						<c:if test="${category == 'bedRoom'}">
						    	<a href="BedRoomDetailServlet?bnum=${pnum}">
						    		<b>${pname}</b>&nbsp;&nbsp;
						    	</a> 
						    </c:if>
	 						<c:if test="${category == 'livingRoom'}">
						    	<a href="LivingRoomDetailServlet?lnum=${pnum}">
						    		<b>${pname}</b>&nbsp;&nbsp;
						    	</a> 
						    </c:if>
						    <c:if test="${category == 'kitchen'}">
						    	<a href="KitchenDetailServlet?knum=${pnum}">
						    		<b>${pname}</b>&nbsp;&nbsp;
						    	</a> 
						    </c:if>
						    <c:if test="${category == 'childrenRoom'}">
						    	<a href="ChildrenRoomDetailServlet?cnum=${pnum}">
						    		<b>${pname}</b>&nbsp;&nbsp;
						    	</a> 
						    </c:if>
	 					</td>			    
					    <td width="100" align="center">
							${count}
						</td>
						<td width="100" align="center">
					    	0
						</td>
					    <td width="100" align="center">
							<b><font color="red"><del><fmt:formatNumber value="${price * count}" type="currency" /></del></font><br />
							
							<font color="#3f4993"><fmt:formatNumber value="${(price * (1.0 - (discount/100))) * count}" type="currency" /></font></b>
							<c:set var="totalPrice" value="${totalPrice + ((price * (1.0 - (discount/100))) * count)}" />
						</td>
					</tr>
				</c:if>
				<tr height="30" style="border-bottom:1px solid black;">
					<td colspan="6" align="center">
						<b><font size="2">결제금액:</font><font color="#3f4993"><fmt:formatNumber value="${totalPrice}" type="currency" /></font></b>
					</td>
				</tr>
			</table> <!-- cartList -->
			
			<br><br>
			<c:if test="${sessionScope.login.addr1 != 'sns'}">
				<span><img src="images/order/zzz.jpg" width="10" height="10">&nbsp;주문자 정보</span>
				<table width="100%" cellpadding="0" cellspacing="0" border="0" class="orderList">
					<tr height="30" style="border-top:1px solid black; border-bottom:1px dotted #ddd;">
						<td width="100" align="center">성 명</td>
						<td width="200">
							<input type="text" name="buyername" id="buyername" value="${memberDTO.name}" style="height:30px;" readonly>
						</td>
						<td width="100" align="center">연 락 처</td>
						<td width="200">
							<input type="text" name="buyertel" id="buyertel" value="${memberDTO.tel}" style="height:30px;" readonly>
						</td>
					</tr>
					<tr height="30" style="border-bottom:1px solid black;">
						<td width="100" align="center">주 소</td>
						<td colspan="3">
							<input type="text" name="buyerpost1" id="buyerpost1" class="postcodify_postcode5" style="width:100px; height:30px;" value="${memberDTO.post1}" readonly> - 
	                        <input type="text" name="buyerpost2" id="buyerpost2" class="postcodify_postcode5" style="width:100px; height:30px;" value="${memberDTO.post2}" readonly><br>
							<input type="text" name="buyeraddr1" id="buyeraddr1" placeholder="도로명주소" style="width: 350px; height:30px;" value="${memberDTO.addr1}" readonly><br>
							<input type="text" name="buyeraddr2" id="buyeraddr2" placeholder="지번주소" style="width: 350px; height:30px;" value="${memberDTO.addr2}" readonly>
						</td>
					</tr>
				</table>
			</c:if>
			<br><br>
			
			<span>
				<img src="images/order/zzz.jpg" width="10" height="10">&nbsp;배송지 정보
				<c:if test="${sessionScope.login.addr1 != 'sns'}">
				　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　<input type="checkbox" id="sameCheck" onclick="same()"> <font size="2">회원정보와 동일</font>
				</c:if>
			</span><br>
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="orderList">
				<tr height="30" style="border-top:1px solid black; border-bottom:1px dotted #ddd;">
					<td width="100" align="center">성 명</td>
					<td width="200">
						<input type="text" name="name" id="name" value="" style="height:30px;" placeholder="성명">
					</td>
					<td width="100" align="center">연락처</td>
					<td width="200">
						<input type="text" name="tel" id="tel" value="" style="height:30px;" placeholder="연락처">
					</td>
				</tr>
				<tr height="30" style="border-bottom:1px dotted #ddd;">
					<td width="100" align="center">주 소</td>
					<td colspan="3">
						<input type="text" readonly name="post1" id="post1" class="postcodify_postcode5" style="width:100px; height:30px;" value=""> - 
                        <input type="text" readonly name="post2" id="post2" class="postcodify_postcode5" style="width:100px; height:30px;" value="">
                        <!-- <input type="button" class="mainBtn" value="검색" style="width:19%; height:25px;" onclick="openDaumPostcode()"> -->
                        <a href="#"><img src="images/order/zipcodeSearchBtn.jpg" class="mainBtn" onclick="openDaumPostcode()"></a>
						<span id="callbacknestsgroomtistorycom739114" style="width: 1px; height: 1px; float: right;">
							<embed width="1" height="1" id="bootstrappersgroomtistorycom739114" src="http://sgroom.tistory.com/plugin/CallBack_bootstrapperSrc?nil_profile=tistory&nil_type=copied_post"
									type="application/x-shockwave-flash" swliveconnect="true" flashvars="&callbackId=sgroomtistorycom739114&host=http://sgroom.tistory.com&embedCodeSrc=http%3A%2F%2Fsgroom.tistory.com%2Fplugin%2FCallBack_bootstrapper%3F%26src%3D%2F%2Fs1.daumcdn.net%2Fcfs.tistory%2Fresource%2F3771%2Fblog%2Fplugins%2FCallBack%2Fcallback%26id%3D73%26callbackId%3Dsgroomtistorycom739114%26destDocId%3Dcallbacknestsgroomtistorycom739114%26host%3Dhttp%3A%2F%2Fsgroom.tistory.com%26float%3Dleft"
									enablecontextmenu="false" wmode="transparent" allowscriptaccess="always">
						</span>
						<span style="line-height: 10%;"><br></span>
						<input type="text" name="addr1" id="addr1" placeholder="도로명주소" style="width: 350px; height:30px;" value="" readonly><br>
						<input type="text" name="addr2" id="addr2" placeholder="지번주소" style="width: 350px; height:30px;" value="" readonly>
					</td>
				</tr>
				<tr height="30" style="border-bottom:1px dotted #ddd;">
					<td width="100" align="center">주문메세지<br>(100자 내외)</td>
					<td colspan="3">
						<textarea rows="5" cols="100" name="orderMessage" id="orderMessage"></textarea>
					</td>
				</tr>
				<tr height="30" style="border-bottom:1px solid black;">
					<td width="100" align="center" style="border-right: 1px solid #ddd;">결제방법</td>
					<td colspan="3">
						&nbsp;무통장 입금&nbsp;<input type="radio" id="mutongjang" name="mutongjang" value="mutongjang">
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<br>
						<a href="javascript:checkOrder(orderForm)">
							<img src="images\cart/orderBtn.jpg">
						</a>
						<a href="javascript:backPage(orderForm)">
							<img src="images\order/orderCancelBtn.jpg">
						</a>
					</td>
				</tr>
			</table>
		</form>
		<!-- <input type="image" src="images\cart/orderBtn.jpg"> -->
		
	</div> <!-- cartContent -->
	<br>
	<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
</div> <!-- cartWrap -->
	
</body>
</html>