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
			
		#login_wrap table{margin: 0 auto;}
		
		.login1 {width:80%; height:10em; margin: 0 auto; background-color: #fafafa}
		
		.login1 table td{margin: 0 auto; font-size: 0.813em; padding: 0.313em;}
		
		.login2 {width: 80%; height: 10em; background-color: #FFF; font-size: 20px; text-align: center; font-family: "맑은 고딕", "바탕";
					padding: 0.313em; color: #555;}
	</style>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			if(${loginFail != null}){
				alert('${loginFail}');
			}
			if(${message != null }){
				alert('${message}');
			}
		});// end $(document).ready()
	
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
	
	<!-- 페북로그인 -->
<script>

	// 이것은 FB.getLoginStatus()의 결과로 호출됩니다.
	function statusChangeCallback(response) {
    	console.log('statusChangeCallback');
    	console.log(response);
    	/*	응답 객체는 상태 필드와 함께 반환되어 앱은 현재 로그인 상태를 알고 있습니다.
    		응답 객체에 대한 전체 문서는 FB.getLoginStatus()에서 찾을 수 있습니다.*/
    	if (response.status === 'connected') {
   	   		login(); //로그인에 성공했을 경우
		} else if (response.status === 'not_authorized') {
    		console.log('페이스북에는 로그인 되어있으나, 앱에는 로그인 되어있지 않다.');
    	} else {
    		console.log('페이스북에 로그인이 되어있지 않아서, 앱에 로그인 되어있는지 불명확하다.');
    	}
	}//statusChangeCallback(response)

  /*이 함수는 누군가 Login으로 끝날 때 호출됩니다. 
  	단추. 샘플에 첨부 된 onlogin()를 참조하십시오.
 	아래 코드를 참조하십시오. */
	function checkLoginState() {
    	FB.getLoginStatus(function(response) {
      		statusChangeCallback(response);
    	});
  	}//checkLoginState()

	window.fbAsyncInit = function() {
		FB.init({
	    	appId      : '406889729678187', // 사용자 코드
	    	cookie     : true,  // 서버가 액세스 할 수 있도록 쿠키 활성화 
	    	xfbml      : true,  // 이 페이지에서 소셜 플러그인을 분석하십시오.
	    	version    : 'v2.8' // 그래프 API 버전 2.8 사용
	  	});
	
	  /*JavaScript SDK를 초기화 했으므로 이제 FB.getLoginStatus() 이 함수는
	  	이 페이지를 방문한 사람은 다음 세 가지 상태 중 하나를 반환 할 수 있습니다.
	  	당신이 제공하는 콜백. 그들은 할 수있다: */
	  // 1. 앱에 로그인되었습니다 ( '연결됨').
	  // 2. Facebook에 로그인되었지만 앱이 아닌 경우 ( 'not_authorized')
	  // 3. Facebook에 로그인하지 않았고 앱에 로그인했는지 여부를 알 수 없습니다.
	  // 위의 세 가지 경우는 콜백 함수에서 처리됩니다.
	
	  	FB.getLoginStatus(function(response) {
	    	statusChangeCallback(response);
	  	});
  	};

  	// SDK를 비동기 적으로 로드하십시오.
  	(function(d, s, id) {
    	var js, fjs = d.getElementsByTagName(s)[0];
    	
    	if (d.getElementById(id)){ 
    		return;
    	}
    	
    	js = d.createElement(s); js.id = id;
    	js.src = "//connect.facebook.net/en_US/sdk.js";
    	fjs.parentNode.insertBefore(js, fjs);
  	}(document, 'script', 'facebook-jssdk'));

   /*여기에 로그인 후 Graph API에 대한 간단한 테스트가 실행됩니다.
	성공한. 이 호출이 발생하면 statusChangeCallback ()을 참조하십시오. */
  	function login() {
    	FB.api('/me', function(user) {
    		var id = user.id;
      		var name = user.name;
      		var tel = user.tel;
      		
      		var loginForm = document.getElementById('loginForm');
      		loginForm.action="FacebookLoginServlet?id="+id+"&name="+name+"&tel="+tel;
      		loginForm.submit();
    	});
  	}//login()
   
</script>

</head>
<body>
	
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		<center><br>
		<div id="login_wrap">
	        <div class="login1">
	        <h2>LOGIN</h2>
	        <font size="2" color="#999999"><b>회원아이디와 비밀번호를 입력해주세요.</b></font>
	        	<form method="post" action="http://localhost:8090/momo/LoginCheckServlet" id="loginForm" name="loginForm" onsubmit="return loginFormSubmit()">
		            <table style="width: 25em;">
		                <tr>
		                    <td align="center" style="width:6.250em;">
		                        <font size="2"><b>아이디</b></font>
		                    </td>
		                    <td style="width:18.750em;">
		                        <input type="text" style="width:18.750em; height:1.875em;" id="id" name="id">
		                    </td>
		                    <td rowspan="2" style="width:6.250em;">
		                    	<input type="image" src="http://localhost:8090/momo/images/login/loginBtn.jpg" style=" width:6.25em; height:2.5em;">
		                    </td>
		                </tr>
		                <tr>
							<td align="center" style="width:6.250em;"><b><font size="2">비밀번호</font></b></td>
		                    <td>
		                        <input type="password" style="width:18.750em; height:1.875em;" id="pwd" name="pwd">
		                    </td>
		                </tr>
		                <tr>
		                	<td colspan="3" style="width:7em;">
		                		<center>
								<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
									facebook으로 로그인하기
								</fb:login-button>
								</center>
							</td>
		                </tr>
		            </table>
	            </form>
	        </div><!-- login1 -->
	        
	        <div class="login2">
	        	<font size="2" color="#555555">
	        	<table>
	        		<tr style="border-bottom: 1px dotted gray; height:5em;">
						<td style="width:30em;">저희 사이트에 방문하신게 처음이신가요?<br></td>
						<td>
							<a href="http://localhost:8090/momo/JoinUIServlet">
	               				<img src="http://localhost:8090/momo/images/login/joinBtn.jpg">
	               			</a>
	               		</td>
					</tr>
					<tr style="height:5em;">
						<td style="width:30em;">
							아이디나 비밀번호를 잊어버리셨나요?<br>찾기 버튼을 누르시고 해당 정보를 입력해주시길 바랍니다.
						</td>
						<td>
							<form method="get" action="http://localhost:8090/momo/FindUIServlet">
           						<!-- <img src="http://localhost:8090/momo/images/login/findBtn.jpg" width="100" height="20" 
           							onClick="findUIServlet()"><br /> -->
           						<input type="image" src="http://localhost:8090/momo/images/login/findBtn.jpg">
           					</form>
						</td>
					</tr>
           		</table>
      			</font>
	       	</div>	<!-- login2 -->
	       	
	    </div> <!-- login_wrap -->
	    </center><br>
		<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>