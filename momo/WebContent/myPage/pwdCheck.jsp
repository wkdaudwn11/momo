<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 재확인</title>

<style>
	#pwdCheckContent {width:70%; margin: 0 auto; border:2px solid gray;}
	#pwdCheckContent img{width:90%;}
	
	#inputPwdTable {width:80%; margin: 0 auto; background-color: #fcfcfc; padding-top: 2em; padding-bottom: 2em;}
	#inputPwdTable table{width: 50%; margin:0 auto;}
	
	#inputPwdBtn{width:30%; margin: 0 auto;}
</style>

<script>
	function pwdCheking(value){
		
		var pwdCheckForm = document.getElementById('pwdCheckForm');
		
		if(value == 'submit'){
			pwdCheckForm.action="PwdCheckServlet";
			pwdCheckForm.submit;
		}else{
			var result = confirm('정말로 취소하시겠습니까?');
			if(result == true){
				pwdCheckForm.action="MypageUIServlet";
				pwdCheckForm.submit;
			}
		}	
	}
	
</script>

</head>
<body>
<div id="wrap">
	<jsp:include page="../include/header.jsp" flush="true"></jsp:include><br>
	
	<div id="pwdCheckContent">
		<center><img src="http://localhost:8090/momo/images/myPage/pwdCheck.jpg"></center>
		
		<form method="post" name="pwdCheckForm" id="pwdCheckForm">		
			<div id="inputPwdTable">
				<table>
					<tr>
						<td>아이디</td>
						<td>wkdaudwn11</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="pwd" id="pwd" style="height:1em;">
						</td>
					</tr>
				</table>
			</div>
			<br>
			
			<div id="inputPwdBtn">
				<input type="image" src="http://localhost:8090/momo/images/myPage/pwdCheckSubmitBtn.jpg" onclick="pwdCheking('submit')">&nbsp;&nbsp;
				<input type="image" src="http://localhost:8090/momo/images/myPage/pwdCheckCancelBtn.jpg" onclick="pwdCheking('cancel')">
			</div>
		</form>
	</div><!-- pwdCheckContent -->
	
	<br><jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
</div> <!-- wrap -->
</body>
</html>