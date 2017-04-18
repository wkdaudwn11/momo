<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
	
	<title>로그인</title>
	
	<style type="text/css">
	
		#login_wrap {width: 50%; margin: 0 auto; border-style: solid; border-color: #CCC;
			margin-top: 10px; margin-bottom: 10px;}
			
		#login_wrap table{margin: 0 auto;}
		
		.login1 {width:80%; height:15em; margin: 0 auto; background-color: #fafafa}
		
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
			var id = document.loginForm.id.value;
			var pwd = document.loginForm.pwd.value;
			
			if(id == null || id == ''){
				alert('아이디를 입력해주세요.');
			}else{
				if(pwd == null || pwd == ''){
					alert('비밀번호를 입력해주세요.');
				}else{
					$.ajax({
						type:"post",
						url:"login/loginCheck.jsp",
						dataType:"text",
						data:{
							id : id,
							pwd : pwd
						},
						success:function(responseData,status,xhr){
							if(responseData.trim()=="성공"){
								captchar(300,185);
							}else if(responseData.trim()=="실패"){
								alert('아이디 혹은 비밀번호가 틀립니다.\n다시 입력해주세요.');
							}else{
								alert('로그인 에러!!');
								console.log(responseData.trim());
							}
						},//success
						error:function(error){
							alert('로그인 실패!');
						}//error
					});//ajax
				}
			}
			
			return false;
		}//loginFormSubmit()
		
		function captchar(popWidth, popHeight){
			var result;
			var captcharKey = '${sessionScope.captchaKey}';
					
			var url = "login/captcha.jsp?captcharKey="+captcharKey;
			var winHeight = document.body.clientHeight;	// 현재창의 높이
			var winWidth = document.body.clientWidth;	// 현재창의 너비
			var winX = window.screenLeft;	// 현재창의 x좌표
			var winY = window.screenTop;	// 현재창의 y좌표
			var popX = winX + (winWidth - popWidth)/2;
			var popY = winY + (winHeight - popHeight)/2;
			
			window.open(url,"캡차","width="+(popWidth+15)+"px,height="+(popHeight-15)+"px,top="+popY+",left="+popX);
			
			return result;
		}//captchar()
		
		function loginSuccess(){
			document.getElementById("loginForm").submit();
		}//loginSuccess()
		
	</script>
</head>
<body>
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		<center><br>
		<div id="login_wrap">
	        <div class="login1">
	        <h2>LOGIN</h2>
	        <font size="2" color="#999999"><b>회원아이디와 비밀번호를 입력해주세요.</b></font>
	        	<form method="post" action="LoginCheckServlet" id="loginForm" name="loginForm" onsubmit="return loginFormSubmit()">
		            <table style="width: 25em;">
		                <tr>
		                    <td align="center" style="width:6.250em;">
		                        <font size="2"><b>아이디</b></font>
		                    </td>
		                    <td style="width:18.750em;">
		                        <input type="text" style="width:18.750em; height:1.875em;" id="id" name="id">
		                    </td>
		                    <td rowspan="2" style="width:6.250em;">
		                    	<input type="image" src="images/login/loginBtn.jpg" style=" width:6.25em; height:2.5em;">
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
								<a href="javascript:loginFB()">
									<img src="images/login/facebookLoginBtn.jpg">
								</a>
								</center>
							</td>
		                </tr>
		                <tr>
		                	<td colspan="3" style="width:7em;">
		                		<center>
		                			<a id="kakao-login-btn"></a>
		                			<jsp:include page="../include/sns/kakaotalk.jsp" flush="true"></jsp:include>
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
							<a href="JoinUIServlet">
	               				<img src="images/login/joinBtn.jpg">
	               			</a>
	               		</td>
					</tr>
					<tr style="height:5em;">
						<td style="width:30em;">
							아이디나 비밀번호를 잊어버리셨나요?<br>찾기 버튼을 누르시고 해당 정보를 입력해주시길 바랍니다.
						</td>
						<td>
							<form method="get" action="FindUIServlet">
           						<input type="image" src="images/login/findBtn.jpg">
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