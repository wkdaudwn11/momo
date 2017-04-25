<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">

<link rel="stylesheet" href="css/normalize.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/templatemo-misc.css">
<link rel="stylesheet" href="css/templatemo-style.css">
     
    
<link href="css_momo/style.css" rel="stylesheet" type="text/css" />	<!-- css_momo -->
<link href="css/style.css" rel="stylesheet" type="text/css" />	<!-- css -->

<!-- 페북 -->
<jsp:include page="sns/facebook.jsp" flush="true"></jsp:include>

 
<script src="js/jquery.cookie.js"></script>

<!-- notification -->
<jsp:include page="notification.jsp" flush="true"></jsp:include>

<script type="text/javascript">	

	function logout(){
		var sns = '${sessionScope.login.sns}';
		if(sns == 'facebook'){
			logoutFB();
		}
		location.replace('LogoutServlet');
	}
	
	<!-- menu 롤오버 --> 
	/*마우스 오버 했을 때*/
	function MM_swapImage() { //v3.0
		var i, j = 0, x, a = MM_swapImage.arguments;
		document.MM_sr = new Array;
		for (i = 0; i < (a.length - 2); i += 3)
			if ((x = MM_findObj(a[i])) != null) {
				document.MM_sr[j++] = x;
				if (!x.oSrc)
					x.oSrc = x.src;
				x.src = a[i + 2];
			}
	}

	function MM_findObj(n, d) { //v4.01
		var p, i, x;
		if (!d)
			d = document;
		if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
			d = parent.frames[n.substring(p + 1)].document;
			n = n.substring(0, p);
		}
		if (!(x = d[n]) && d.all)
			x = d.all[n];
		for (i = 0; !x && i < d.forms.length; i++)
			x = d.forms[i][n];
		for (i = 0; !x && d.layers && i < d.layers.length; i++)
			x = MM_findObj(n, d.layers[i].document);
		if (!x && d.getElementById)
			x = d.getElementById(n);
		return x;
	}
	
	/*마우스 아웃 했을 때*/
	function MM_swapImgRestore() { //v3.0
		var i, x, a = document.MM_sr;
		for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++)
			x.src = x.oSrc;
	}

</script>
    
<div id="header">
	<br><br>
	<div class="logo">
		<a href="IndexServlet">
			<font class="logoEng"><b>MOMO${snsLogout}</b></font>
			<font class="logoKor"><b>가구</b></font>
		</a>
	</div>
	
	<div class="login">
		<ul>
		
		<c:if test="${sessionScope.login == null }"> <!-- 로그인 안했을 경우 -->
           	<li><a class="login_color" href="LoginUIServlet">로그인</a></font></li>
           	<li><a class="login_color" href="JoinUIServlet">회원가입</a></font></li>
           	<li><a class="login_black" href="FindUIServlet">ID/PW찾기</a></li>
		</c:if>
		
		<c:if test="${sessionScope.login != null}"> <!-- 로그인 했을 경우 -->
           	<li><a class="login_color" href="javascript:logout()">로그아웃</a></font></li>
           	<li><a class="login_color" href="PwdCheckUIServlet">정보수정</a></font></li>
           	<c:if test="${sessionScope.login.id != 'admin'}">
           		<li><a class="login_black" href="CartListServlet">장바구니</a></li>
           	</c:if>
           	<c:if test="${sessionScope.login.id == 'admin'}">
           		<li><a class="login_black" href="banWordUIServlet">금지어관리</a></li>
           	</c:if>
		</c:if>
		
			<li><a class="login_black" href="OrderListServlet">주문내역</a></li>
            <li><a class="login_black" href="MyPageUIServlet">마이페이지</a></li>
			<li><a class="login_black" href="QuestionListServlet">고객문의</a></li>

		</ul>
	</div>
	
	<ul class="menu">
		<li><!-- BedRoom -->
			<a href="BedRoomListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('BedRoom','','images/menu/BedRoom_over.jpg',1)">
				<img src="images/menu/BedRoom.jpg" id="BedRoom" />
			</a>
		</li>
		
		<li><!-- LivingRoom -->
			<a href="LivingRoomListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('LivingRoom','','images/menu/LivingRoom_over.jpg',1)">
				<img src="images/menu/LivingRoom.jpg" id="LivingRoom" />
			</a>
		</li>
		<li><!-- Kitchen-->
			<a href="KitchenListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('Kitchen','','images/menu/Kitchen_over.jpg',1)">
				<img src="images/menu/Kitchen.jpg" id="Kitchen" />
			</a>
		</li>
		<li><!-- ChildrenRoom -->
			<a href="ChildrenRoomListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('ChildrenRoom','','images/menu/ChildrenRoom_over.jpg',1)">
				<img src="images/menu/ChildrenRoom.jpg" id="ChildrenRoom" />
			</a>
		</li>
		<li><!-- MyHome -->
			<a href="MyHomeListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('MyHome','','images/menu/MyHome_over.jpg',1)">
				<img src="images/menu/MyHome.jpg" id="MyHome" />
			</a>
		</li>
		<li> <!-- FreeBoard -->
			<a href="FreeBoardListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('FreeBoard','','images/menu/FreeBoard_over.jpg',1)">
				<img src="images/menu/FreeBoard.jpg" id="FreeBoard" />
			</a>
		</li> 
	</ul> <!--  -->
</div>	<!-- header -->