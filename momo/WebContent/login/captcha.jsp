<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사진에 보이는 값들을 정확히 입력하세요.</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	
	$(document).ready(function(){
		
		$.ajax({
			type:"post",
			url:"captcha/APIExamCaptchaNkey.jsp",
			dataType:"text",
			success:function(responseData,status,xhr){
				
			},//success
			error:function(error){
				alert('인증번호 불러오기 실패!');
			}//error
		});//ajax
		
		$("#captchaBtn").on("click", function(){
			
			var captchaUserInput = document.getElementById("captchaUserInput").value;
			var captchakey = document.getElementById("captchakey").value;
			
			if(captchaUserInput == null || captchaUserInput == ""){
				alert('값을 입력해주세요.');
			}else{
				$.ajax({
					type:"post",
					url:"captcha/APIExamCaptchaNkeyResult.jsp",
					dataType:"text",
					data:{
						captchaUserInput : captchaUserInput,
						captchakey : captchakey
					},
					success:function(responseData,status,xhr){
						if(responseData.trim()=="성공"){
							opener.parent.loginSuccess();
							window.close();
						}else if(responseData.trim()=="실패"){
							alert('값이 일치하지 않습니다.\n다시 입력해주세요.');
						}else{
							alert('에러!!');
							console.log(responseData.trim());
						}
					},//success
					error:function(error){
						alert('인증번호 불러오기 실패!');
					}//error
				});//ajax
			}//if
		});//("#captchaBtn").on("click"
	});//ready
	
</script>

</head>
<body>
	<center>
	<iframe src="https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=${captchaKey}" width="200" height="90"></iframe><br />
	
	<input id="captchakey" type="hidden" value="${captchaKey}"/>
	사진에 보이시는 값을 입력해주세요.<br />
	<input id="captchaUserInput" type="text" /><br />
	<button id="captchaBtn">확인</button>
	</center>
	
</body>
</html>