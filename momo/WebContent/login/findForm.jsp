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
		
		.displayNone {display: none;}

	</style>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	
	<script>
		$(document).ready(function(){
			if(document.getElementById('id').checked == true){
				$("#findPwdDiv").addClass("displayNone");
				var pwd = document.getElementById('pwd');
				pwd.checked = false;
			}
			if(document.getElementById('questionConfirm').selected == true){
				$(".telConfirmDiv").addClass("displayNone");
				$(".emailConfirmDiv").addClass("displayNone");
			}
		});
		
		function checkFind(checkValue){
			var id = document.getElementById('id');
			var pwd = document.getElementById('pwd');
			
			var id2 = document.getElementById('id2');
			var pwd2 = document.getElementById('pwd2');
			
			$("#findIdDiv").removeClass("displayNone");
			$("#findPwdDiv").removeClass("displayNone");
			
			if(checkValue == 'id'){
				$("#findPwdDiv").addClass("displayNone");
				pwd.checked = false;
				id.checked = true;
			}else{
				$("#findIdDiv").addClass("displayNone");
				id2.checked = false;
				pwd2.checked = true;
			}
		}//checkFind(checkValue)
		
		function selectConfirmFunc(selectConfirm){
			$(".questionConfirmDiv").removeClass("displayNone");
			$(".telConfirmDiv").removeClass("displayNone");
			$(".emailConfirmDiv").removeClass("displayNone");
			
			if(selectConfirm.value == 'question'){
				$(".telConfirmDiv").addClass("displayNone");
				$(".emailConfirmDiv").addClass("displayNone");
			}else if(selectConfirm.value == 'tel'){
				$(".questionConfirmDiv").addClass("displayNone");
				$(".emailConfirmDiv").addClass("displayNone");
				$("#findIdTelTelConfirmP").addClass("displayNone"); 
				$("#findPwdTelTelConfirmP").addClass("displayNone");
			}else{
				$(".questionConfirmDiv").addClass("displayNone");
				$(".telConfirmDiv").addClass("displayNone");
			}
		}//selectConfirmFunc(selectConfirm)
		
		function confirmNumber(tel, findValue){
	    	var telComfirmNumber = 0;
	    	
	    	if(tel.value == null || tel.value == ""){
	    		alert('연락처를 입력해주세요.');
	    		tel.focus();
	    	}else if(tel.value.length < 9 || tel.value.length > 11){
	    		alert('연락처는 9자리 이상 입력하셔야 합니다.');
	    		tel.focus();
	    	}else if(!tel.value.match(/[0-9].*[0-9]/)){
				alert("연락처는 숫자만 입력가능합니다.");
				tel.focus();
			}else{
				if(confirm(tel.value+'(으)로 인증번호를 받으시겠습니까?')){
					$.ajax({
						type:"post",
						url:"join/randomNumberAjax.jsp",
						dataType:"text",
						data:{
							usertel : tel.value
						},
						success:function(responseData,status,xhr){
							if(findValue == 'id'){
								$("#findIdTelTelConfirmP").removeClass("displayNone");
								$("#findIdTelTelConfirm").focus();
							}else{
								$("#findPwdTelTelConfirmP").removeClass("displayNone");
								$("#findPwdTelTelConfirm").focus();
							}
						},//success
						error:function(error){
							alert('인증번호 불러오기 실패!');
						}//error
					});//ajax
				}//confirm(tel.value+'(으)로 인증번호를 받으시겠습니까?')
			}//tel.value == null || tel.value == ""
	    }//confirmNumber(tel, findValue)
	    
	    function telConfirmCheck(telConfirm, findValue){
	    	$.ajax({
				type:"post",
				url:"join/telConfirmAjax.jsp",
				dataType:"text",
				data:{
					inputNum : telConfirm.value
				},
				success:function(responseData,status,xhr){
					if(findValue == 'id'){
						if(document.getElementById("findIdTelTelConfirmResult").innerText=responseData.trim()=="인증번호가 일치합니다."){
		    				document.getElementById('findIdTelIsTelComfirm').value = "o";
	    					$("#findIdTelTelConfirmResult").css("color","green");
		    			}else if(document.getElementById("findIdTelTelConfirmResult").innerText=responseData.trim()=="인증번호가 불일치합니다."){
		    				document.getElementById('findIdTelIsTelComfirm').value = "x";
		    				$("#findIdTelTelConfirmResult").css("color","red");
		    			}
						$("#findIdTelTelConfirmResult").text(responseData.trim());
					}else{
						if(document.getElementById("findPwdTelTelConfirmResult").innerText=responseData.trim()=="인증번호가 일치합니다."){
		    				document.getElementById('findPwdTelIsTelComfirm').value = "o";
	    					$("#findPwdTelTelConfirmResult").css("color","green");
		    			}else if(document.getElementById("findPwdTelTelConfirmResult").innerText=responseData.trim()=="인증번호가 불일치합니다."){
		    				document.getElementById('findPwdTelIsTelComfirm').value = "x";
		    				$("#findPwdTelTelConfirmResult").css("color","red");
		    			}
						$("#findPwdTelTelConfirmResult").text(responseData.trim());
					}

				},//success
				error:function(error){
					alert('인증번호 불러오기 실패!');
				}//error
			});//ajax
	    }//telConfirmCheck(telConfirm, findValue)
		
		function findId(form, selectValue){
			var result = true;
			
			if(selectValue == 'question'){
				var selectQuestion = form.findIdQuestionQuestion.value;
				if(selectQuestion == 'default'){
					alert('질문을 선택해주세요.');
					result = false;
				}
			}else if(selectValue == 'tel'){
				var isTelComfirm = form.findIdTelIsTelComfirm.value;
				if(isTelComfirm == 'no'){
					alert('인증번호 받기 버튼을 눌러주세요.');
					result = false;
				}else if(isTelComfirm == 'x'){
					alert('인증번호를 제대로 입력해주세요.');
					result = false;
				}
			}
			return result;
		}//findId(form, selectValue)
		
		function findPwd(form, selectValue){
			var result = true;
			
			if(selectValue == 'question'){
				var selectQuestion = form.findPwdQuestionQuestion.value;
				if(selectQuestion == 'default'){
					alert('질문을 선택해주세요.');
					result = false;
				}
			}else if(selectValue == 'tel'){
				var isTelComfirm = form.findPwdTelIsTelComfirm.value;
				if(isTelComfirm == 'no'){
					alert('인증번호 받기 버튼을 눌러주세요.');
					result = false;
				}else if(isTelComfirm == 'x'){
					alert('인증번호를 제대로 입력해주세요.');
					result = false;
				}
			}
			
			return result;
		}//findPwd(form, selectValue)
	</script>

</head>
<body>

	<c:if test="${loginFail != null }">
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
	<br />
	<center>
	<div id="login_wrap">
        <div id="findIdDiv"><br />
        	아이디 찾기<input type="radio" name="id"  id="id" onClick="checkFind('id')" checked>&nbsp;
			비밀번호 찾기<input type="radio" name="pwd" id="pwd" onClick="checkFind('pwd')">
			
        	<br> <h2>아이디 찾기</h2>
        	
        	<select id="selectConfirmId" name="selectConfirmId" onchange="selectConfirmFunc(selectConfirmId)">
        		<option name="questionConfirm" id="questionConfirm" value="question" selected="selected">질문과 답변으로 찾기</option>
        		<option name="telConfirm" id="telConfirm" value="tel">핸드폰 인증으로 찾기</option>
        		<option name="emailConfirm" id="emailConfirm" value="eamil">이메일 인증으로 찾기</option>
        	</select>
        	<br>
        	
        	<div class="questionConfirmDiv">
	        	<font size="2" color="#999999">질문을 선택하여 답변을 작성해주세요.</font>
	        	<form get="post" action="FindServlet" name="findIdQuestionForm" onsubmit="return findId(findIdQuestionForm, 'question')">
	        		<input type="hidden" name="findIdQuestion" value="momo">
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>이름</b></span>
		    			<input type="text" name="findIdQuestionName" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>질문</b></span>
		    			<select name="findIdQuestionQuestion" style="width:45%; height:30px;">
	                        	<option value="default">질문을 선택해주세요.</option>
	                        	<option value="내가 다녔던 초등학교는?">내가 다녔던 초등학교는?</option>
	                        	<option value="어머니 성함은?">어머니 성함은?</option>
	                        	<option value="아버지 성함은?">아버지 성함은?</option>
	                    </select>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>답변</b></span>
 		    			<input type="text" name="findIdQuestionAnswer" style="width:45%; height:30px;" required>
					</p>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="telConfirmDiv">
	        	<font size="2" color="#999999">이름과 연락처를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" name="findIdTelForm" onsubmit="return findId(findIdTelForm, 'tel')">
	        		<input type="hidden" name="findIdTel" value="momo">
	        		<input type="hidden" name="findIdTelIsTelComfirm" id="findIdTelIsTelComfirm" value="no">
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>이　　름</b></span>
		    			<input type="text" name="findIdTelName" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>연 락 처</b></span>
		    			<input type="text" name="findIdTelTel" style="width:25%; height:30px;" placeholder="'-'빼고 입력" required>
		    			<input type="button" name="findIdTelConfirmNumberBtn" value="인증번호 받기" style="width: 19%; height: 30px;"
		    					onclick="confirmNumber(findIdTelTel, 'id')">
					</p>
					<p id="findIdTelTelConfirmP">
						&nbsp;&nbsp;<span style="width:24%"><b>인증번호</b></span>
						<input type="text" name="findIdTelTelConfirm" id="findIdTelTelConfirm" maxlength="6" style="width:45%; height: 30px;" 
								onkeyup="telConfirmCheck(findIdTelTelConfirm, 'id')"><br />
                      	<font color="#13132f" size="3">
                   			<span id="findIdTelTelConfirmResult"></span>
                   		</font>
					</p>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="emailConfirmDiv">
	        	<font size="2" color="#999999">이름과 이메일를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" name="findIdEmailForm" onsubmit="return findId(findIdEmailForm, 'email')">
	        		<input type="hidden" name="findIdEmail" value="momo">
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>이　름</b></span>
		    			<input type="text" name="findIdEmailName" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>이메일</b></span>
		    			<input type="text" name="findIdEmailEmail1" style="width:22%; height:30px;" required>@
		    			<input type="text" name="findIdEmailEmail2" style="width:22%; height:30px;" required>
					</p>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            <br />
        </div><!-- login1 -->
        
        <div id="findPwdDiv"><br />
        	아이디 찾기<input type="radio" name="id2"  id="id2" onClick="checkFind('id')">&nbsp;
			비밀번호 찾기<input type="radio" name="pwd2" id="pwd2" onClick="checkFind('pwd')" checked>
			
        	<br><h2>비밀번호 찾기</h2>
        	
        	<select id="selectConfirmPwd" name="selectConfirmPwd" onchange="selectConfirmFunc(selectConfirmPwd)">
        		<option name="questionConfirm" id="questionConfirm" value="question" selected="selected">질문과 답변으로 찾기</option>
        		<option name="telConfirm" id="telConfirm" value="tel">핸드폰 인증으로 찾기</option>
        		<option name="emailConfirm" id="emailConfirm" value="eamil">이메일 인증으로 찾기</option>
        	</select>
        	<br>
        	
        	<div class="questionConfirmDiv">
	        	<font size="2" color="#999999">질문을 선택하여 답변을 작성해주세요.</font>
	        	<form get="post" action="FindServlet" name="findPwdQuestionForm" onsubmit="return findPwd(findPwdQuestionForm, 'question')">
	        		<input type="hidden" name="findPwdQuestion" value="momo">
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>아이디</b></span>
		    			<input type="text" name="findPwdQuestionId" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>이　름</b></span>
		    			<input type="text" name="findPwdQuestionName" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>질　문</b></span>
		    			<select name="findPwdQuestionQuestion" style="width:45%; height:30px;">
	                        	<option value="default">질문을 선택해주세요.</option>
	                        	<option value="내가 다녔던 초등학교는?">내가 다녔던 초등학교는?</option>
	                        	<option value="어머니 성함은?">어머니 성함은?</option>
	                        	<option value="아버지 성함은?">아버지 성함은?</option>
	                    </select>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>답　변</b></span>
		    			<input type="text" name="findPwdQuestionAnswer" style="width:45%; height:30px;" required>
					</p>
		            <input type="image" src="images/login/findPwdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="telConfirmDiv">
	        	<font size="2" color="#999999">아이디, 이름, 연락처를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" name="findPwdTelForm" onsubmit="return findPwd(findPwdTelForm, 'tel')">
	        		<input type="hidden" name="findPwdTel" value="momo">
	        		<input type="hidden" name="findPwdTelIsTelComfirm" id="findPwdTelIsTelComfirm" value="no">
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>아 이 디</b></span>
		    			<input type="text" name="findPwdTelId" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>이　　름</b></span>
		    			<input type="text" name="findPwdTelName" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>연 락 처</b></span>
		    			<input type="text" name="findPwdTelTel" style="width:25%; height:30px;" placeholder="'-'빼고 입력" required>
		    			<input type="button" name="findPwdTelConfirmNumberBtn" value="인증번호 받기" style="width: 19%; height: 30px;"
		    					onclick="confirmNumber(findPwdTelTel, 'pwd')">
					</p>
					<p id="findPwdTelTelConfirmP">
						&nbsp;&nbsp;<span style="width:24%"><b>인증번호</b></span>
						<input type="text" name="findPwdTelTelConfirm" id="findPwdTelTelConfirm" maxlength="6" style="width:45%; height: 30px;" 
								onkeyup="telConfirmCheck(findPwdTelTelConfirm, 'pwd')"><br />
                      	<font color="#13132f" size="3">
                   			<span id="findPwdTelTelConfirmResult"></span>
                   		</font>
					</p>
		            <input type="image" src="images/login/findPwdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="emailConfirmDiv">
	        	<font size="2" color="#999999">아이디, 이름, 이메일를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" name="findPwdEmailForm" onsubmit="return findPwd(findPwdEmailForm, 'email')">
	        		<input type="hidden" name="findPwdEmail" value="momo">
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>아이디</b></span>
		    			<input type="text" name="findPwdEmailId" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			<span style="width:24%">&nbsp;&nbsp;<b>이　름</b></span>
		    			<input type="text" name="findPwdEmailName" style="width:45%; height:30px;" required>
					</p>
					<p>
		    			&nbsp;&nbsp;<span style="width:24%"><b>이메일</b></span>
		    			<input type="text" name="findPwdEmailEmail1" style="width:22%; height:30px;" required>@
		    			<input type="text" name="findPwdEmailEmail2" style="width:22%; height:30px;" required>
					</p>
		            <input type="image" src="images/login/findPwdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <br />
        </div><!-- login1 -->
    </div> <!-- login_wrap -->
    </center>
    <br />
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
