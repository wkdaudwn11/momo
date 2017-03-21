<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>로그인</title>
	
	<style type="text/css">
	
		#login_wrap {width: 50%; margin: 0 auto; border-style: solid; border-color: #CCC;
			margin-top: 10px; margin-bottom: 10px;}
		
		.login1 {width:50%; height:9em;}
		
		.login1 table td{margin: 0 auto; font-size: 0.813em; padding: 0.313em;}
		
		.login2 {width: 70%; height: 10.5em; background-color: #FFF; font-size: 20px; text-align: center; font-family: "맑은 고딕", "바탕";
					padding: 0.313em; color: #555;}
	</style>

	<script type="text/javascript">
		
		function loginFormSubmit(){
			
			var result = false;
			var id = document.loginForm.id.value;
			var pwd = document.loginForm.pwd.value;
			
			if(id == null || id == ''){
				alert('아이디를 입력해주세요.');
			}else{
				if(pwd == null || pwd == ''){
					alert('비밀번호를 입력해주세요.');
				}else{
					result = true;
				}
			}
			
			return result;
		}//loginFormSubmit()
		
	</script>

</head>
<body>

	<c:if test="${loginFail != null}">
	  <script type="text/javascript">
	  	var x= '${loginFail}';
	    alert(x);
	  </script>
	</c:if>
	
	<c:if test="${message != null }">
	  <script type="text/javascript">
	  	var x= '${message}';
	    alert(x);
	  </script>
	</c:if>
	
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		<center><br>
		<div id="login_wrap">
	        <div class="login1">
	        <h2>LOGIN</h2>
	        <font size="2" color="#999999"><b>회원아이디와 비밀번호를 입력해주세요.</b></font>
	        	<form method="post" action="http://localhost:8090/momo/LoginCheckServlet" id="loginForm" name="loginForm" onsubmit="return loginFormSubmit()">
		            <table width="500">
		                <tr>
		                    <td align="center">
		                        <font size="2"><b>아이디</b></font>
		                    </td>
		                    <td style="width:12.5em">
		                        <input type="text" style="width:12.5em; height:1.875em;" id="id" name="id">
		                    </td>
		                    <td rowspan="2">
		                    	<!-- <img src="http://localhost:8090/momo/images/login/loginBtn.jpg" width="100" height="50" onclick="loginFormSubmit()"> -->
		                    	<input type="image" src="http://localhost:8090/momo/images/login/loginBtn.jpg" style=" width:6.25em; height:2.5em;">
		                    </td>
		                </tr>
		                <tr>
							<td align="center"><b><font size="2">비밀번호</font></b></td>
		                    <td>
		                        <input type="password" style="width:12.5em; height:1.875em;" id="pwd" name="pwd">
		                    </td>
		                </tr>
		            </table>
	            </form>
	        </div><!-- login1 -->
	        <div class="login2">
	        	<font size="2" color="#555555">
					저희 사이트에 방문하신게 처음이신가요? <br />
					회원이 되시면 다양한 정보와 혜택을 누리실 수 있습니다.<br />
					<a href="http://localhost:8090/momo/JoinUIServlet">
	               		<img src="http://localhost:8090/momo/images/login/joinBtn.jpg" width="100" height="20">
	               	</a><br /><br />
             		아이디나 비밀번호를 잊어버리셨나요? <br />
					찾기 버튼을 누르시고 해당 정보를 입력해주시길 바랍니다.
					<form method="get" action="http://localhost:8090/momo/FindUIServlet">
           				<!-- <img src="http://localhost:8090/momo/images/login/findBtn.jpg" width="100" height="20" 
           					onClick="findUIServlet()"><br /> -->
           				<input type="image" src="http://localhost:8090/momo/images/login/findBtn.jpg"
           					style="width:7.2em; height:1.5em;">
           			</form>
      			</font>
	       	</div>	<!-- login2 -->
	       	
	    </div> <!-- login_wrap -->
	    </center><br>
		<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>