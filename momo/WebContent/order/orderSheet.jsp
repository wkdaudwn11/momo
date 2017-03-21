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
		
	}
</script>

</head>
<body>

<c:set var="totalPrice" value="0" />	<!-- 전체가격 -->

<div id="orderWrap">
	<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
	
	<div id="orderContent">
		<h3>주문서 작성</h3>
		<hr>
		<span><img src="http://localhost:8090/momo/images/order/zzz.jpg" width="10" height="10">&nbsp;주문 상세내역</span>
		
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
				<c:forEach var="cartDTO" items="${cartList}" varStatus="i">
					<tr height="30" style="border-bottom:1px dotted #ddd;">
						<td  width="50" align="center" >
							<b>${i.count + x}</b>
						</td>
					    <td  width="50" align="center">
					    	<c:if test="${cartDTO.category == 'bedroom'}">				           
						    	<img src="http://localhost:8090/momo/images/bedroom/${cartDTO.image1}.JPG" width="50" height="50">
						    </c:if>
					    </td>
	 					<td width="200" align="center">
	 						<c:if test="${cartDTO.category == 'bedroom'}">
						    	<a href="http://localhost:8090/momo/BedRoomDetailServlet?bnum=${cartDTO.pnum}">
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
				<tr height="30" style="border-bottom:1px solid black;">
					<td colspan="6" align="center">
						<b><font size="2">결제금액:</font><font color="#3f4993"><fmt:formatNumber value="${totalPrice}" type="currency" /></font></b>
					</td>
				</tr>
			</table> <!-- cartList -->
			
			<br><br>
			
			<span><img src="http://localhost:8090/momo/images/order/zzz.jpg" width="10" height="10">&nbsp;주문자 정보</span>
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="orderList">
				<tr height="30" style="border-top:1px solid black; border-bottom:1px dotted #ddd;">
					<td width="100" align="center">성 명</td>
					<td width="200">
						<input type="text" name="buyername" id="buyername" value="${memberDTO.name}" style="height:30px;" readonly>
					</td>
					<td width="100" align="center">휴 대 전 화</td>
					<td width="200">
						<input type="text" name="buyertel" id="buyertel" value="${memberDTO.tel}" style="height:30px;" readonly>
					</td>
				</tr>
				<tr height="30" style="border-bottom:1px solid black;">
					<td width="100" align="center">주 소</td>
					<td colspan="3">
						<input type="text" readonly name="buyerpost1" id="buyerpost1" class="postcodify_postcode5" style="width:100px; height:30px;" value="${memberDTO.post1}"> - 
                        <input type="text" readonly name="buyerpost2" id="buyerpost2" class="postcodify_postcode5" style="width:100px; height:30px;" value="${memberDTO.post2	}"><br>
						<input name="addr1" type="text" id="buyeraddr1" placeholder="도로명주소" style="width: 350px; height:30px;" value="${memberDTO.addr1}" readonly><br>
						<input name="addr2" type="text" id="buyeraddr2" placeholder="지번주소" style="width: 350px; height:30px;" value="${memberDTO.addr2}" readonly>
					</td>
				</tr>
			</table>
			
			<br><br>
			
			<span>
				<img src="http://localhost:8090/momo/images/order/zzz.jpg" width="10" height="10">&nbsp;배송지 정보
				　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　<input type="checkbox" id="sameCheck" onclick="same()"> <font size="2">회원정보와 동일</font>
			</span><br>
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="orderList">
				<tr height="30" style="border-top:1px solid black; border-bottom:1px dotted #ddd;">
					<td width="100" align="center">성 명</td>
					<td width="200">
						<input type="text" name="name" id="name" value="" style="height:30px;" placeholder="성명" readonly>
					</td>
					<td width="100" align="center">휴 대 전 화</td>
					<td width="200">
						<input type="text" name="tel" id="tel" value="" style="height:30px;" placeholder="휴대폰번호" readonly>
					</td>
				</tr>
				<tr height="30" style="border-bottom:1px dotted #ddd;">
					<td width="100" align="center">주 소</td>
					<td colspan="3">
						<input type="text" readonly name="post1" id="post1" class="postcodify_postcode5" style="width:100px; height:30px;" value=""> - 
                        <input type="text" readonly name="post2" id="post2" class="postcodify_postcode5" style="width:100px; height:30px;" value="">
                        <!-- <input type="button" class="mainBtn" value="검색" style="width:19%; height:25px;" onclick="openDaumPostcode()"> -->
                        <a href="#"><img src="http://localhost:8090/momo/images/order/zipcodeSearchBtn.jpg" class="mainBtn" onclick="openDaumPostcode()"></a>
						<span id="callbacknestsgroomtistorycom739114" style="width: 1px; height: 1px; float: right;">
							<embed width="1" height="1" id="bootstrappersgroomtistorycom739114" src="http://sgroom.tistory.com/plugin/CallBack_bootstrapperSrc?nil_profile=tistory&nil_type=copied_post"
									type="application/x-shockwave-flash" swliveconnect="true" flashvars="&callbackId=sgroomtistorycom739114&host=http://sgroom.tistory.com&embedCodeSrc=http%3A%2F%2Fsgroom.tistory.com%2Fplugin%2FCallBack_bootstrapper%3F%26src%3D%2F%2Fs1.daumcdn.net%2Fcfs.tistory%2Fresource%2F3771%2Fblog%2Fplugins%2FCallBack%2Fcallback%26id%3D73%26callbackId%3Dsgroomtistorycom739114%26destDocId%3Dcallbacknestsgroomtistorycom739114%26host%3Dhttp%3A%2F%2Fsgroom.tistory.com%26float%3Dleft"
									enablecontextmenu="false" wmode="transparent" allowscriptaccess="always">
						</span>
						<span style="line-height: 10%;"><br></span>
						<input type="text" name="addr1" id="addr1" placeholder="도로명주소" style="width: 350px; height:30px;" value="" readonly><br>
						<input type="text" name="addr2" id="addr2" placeholder="지번주소" style="width: 350px; height:30px;" value="">
					</td>
				</tr>
				<tr height="30" style="border-bottom:1px solid black;">
					<td width="100" align="center">주문메세지<br>(100자 내외)</td>
					<td colspan="3">
						<textarea rows="5" cols="100" name="orderMessage" id="orderMessage"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<br>
						<input type="image" src="http://localhost:8090/momo/images\cart/orderBtn.jpg" onclick="checkOrder(cartForm)">&nbsp;
						<input type="image" src="http://localhost:8090/momo/images\order/orderCancelBtn.jpg" onclick="checkOrder(cartForm)">
					</td>
				</tr>
			</table>
		</form>
		<!-- <input type="image" src="http://localhost:8090/momo/images\cart/orderBtn.jpg"> -->
		
	</div> <!-- cartContent -->
	<br>
	<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
</div> <!-- cartWrap -->
	
</body>
</html>