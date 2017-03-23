<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">
<link rel="stylesheet" href="http://localhost:8090/momo/css/normalize.min.css">
<link rel="stylesheet" href="http://localhost:8090/momo/css/font-awesome.min.css">
<link rel="stylesheet" href="http://localhost:8090/momo/css/animate.css">
<link rel="stylesheet" href="http://localhost:8090/momo/css/templatemo-misc.css">
<link rel="stylesheet" href="http://localhost:8090/momo/css/templatemo-style.css">
     
    
<link href="http://localhost:8090/momo/css_momo/style.css" rel="stylesheet" type="text/css" />	<!-- css_momo -->
<link href="http://localhost:8090/momo/css/style.css" rel="stylesheet" type="text/css" />	<!-- css -->

<script type="text/javascript">	
	
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
		<a href="http://localhost:8090/momo/IndexServlet">
			<font class="logoEng"><b>MOMO</b></font>
			<font class="logoKor"><b>가구</b></font>
		</a>
	</div>
	
	<div class="login">
		<ul>
		
		<c:if test="${sessionScope.login == null }"> <!-- 로그인 안했을 경우 -->
	           	<li><a class="login_color" href="http://localhost:8090/momo/LoginUIServlet">로그인</a></font></li>
	           	<li><a class="login_color" href="http://localhost:8090/momo/JoinUIServlet">회원가입</a></font></li>
	            <li><a class="login_black" href="http://localhost:8090/momo/CartListServlet">장바구니</a></li>
		</c:if>	
		
		<c:if test="${sessionScope.login != null}"> <!-- 로그인 했을 경우 -->
	           	<li><a class="login_color" href="http://localhost:8090/momo/LogoutServlet">로그아웃</a></font></li>
	           	<li><a class="login_color" href="">정보수정</a></font></li>
	            <li><a class="login_black" href="http://localhost:8090/momo/CartListServlet">장바구니</a></li>
		</c:if>
		
			<li><a class="login_black" href="">주문조회</a></li>
            <li><a class="login_black" href="http://localhost:8090/momo/MypageUIServlet">마이페이지</a></li>
			<li><a class="login_black" href="http://localhost:8090/momo/QuestionServlet">상품문의</a></li>
		</ul>
	</div>
	
	<ul class="menu">
		<li><!-- bedroom -->
			<a href="http://localhost:8090/momo/BedRoomListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('BedRoom','','http://localhost:8090/momo/images/menu/BedRoom_over.jpg',1)">
				<img src="http://localhost:8090/momo/images/menu/BedRoom.jpg" id="BedRoom" />
			</a>
		</li>
		
		<li><!-- livingroom -->
			<a href="http://localhost:8090/momo/LivingRoomListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('LivingRoom','','http://localhost:8090/momo/images/menu/LivingRoom_over.jpg',1)">
				<img src="http://localhost:8090/momo/images/menu/LivingRoom.jpg" id="LivingRoom" />
			</a>
		</li>
		<li><!-- Kitchen-->
			<a href="http://localhost:8090/momo/KitchenListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('Kitchen','','http://localhost:8090/momo/images/menu/Kitchen_over.jpg',1)">
				<img src="http://localhost:8090/momo/images/menu/Kitchen.jpg" id="Kitchen" />
			</a>
		</li>
		<li><!-- ChildrenRoom -->
			<a href="http://localhost:8090/momo/ChildrenRoomListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('ChildrenRoom','','http://localhost:8090/momo/images/menu/ChildrenRoom_over.jpg',1)">
				<img src="http://localhost:8090/momo/images/menu/ChildrenRoom.jpg" id="ChildrenRoom" />
			</a>
		</li>
		<li>
			<a href="" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('MyHome','','http://localhost:8090/momo/images/menu/MyHome_over.jpg',1)">
				<img src="http://localhost:8090/momo/images/menu/MyHome.jpg" id="MyHome" />
			</a>
		</li>
		<li> <!-- 자유게시판 -->
			<a href="http://localhost:8090/momo/FreeBoardListServlet" onmouseout="MM_swapImgRestore()" 
				onmouseover="MM_swapImage('FreeBoard','','http://localhost:8090/momo/images/menu/FreeBoard_over.jpg',1)">
				<img src="http://localhost:8090/momo/images/menu/FreeBoard.jpg" id="FreeBoard" />
			</a>
		</li> 
	</ul> <!--  -->
</div>	<!-- header -->