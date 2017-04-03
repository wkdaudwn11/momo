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
			}
			if(document.getElementById('questionConfirm').selected == true){
				$(".telConfirmDiv").addClass("displayNone");
				$(".emailConfirmDiv").addClass("displayNone");
			}
		});
		
		function checkFind(checkValue){
			var id = document.getElementById('id');
			var pwd = document.getElementById('pwd');
			
			$("#findIdDiv").removeClass("displayNone");
			$("#findPwdDiv").removeClass("displayNone");
			
			if(checkValue == 'id'){
				$("#findPwdDiv").addClass("displayNone");
				pwd.checked = false;
				id.checked = true;
			}else{
				$("#findIdDiv").addClass("displayNone");
				$("#telConfirmDiv").addClass("displayNone");
				$("#emailConfirmDiv").addClass("displayNone");
				id.checked = false;
				pwd.checked = true;
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
			}else{
				$(".questionConfirmDiv").addClass("displayNone");
				$(".telConfirmDiv").addClass("displayNone");
			}
		}//selectConfirmFunc(selectConfirm)
	</script>
	
	<script type="text/javascript">
		
		/* function findIdUI(){
			var id = document.getElementById('id');
			var pwd = document.getElementById('pwd');
			
			pwd.checked = false;
			
			findValue = id.value;
			location.replace("FindUIServlet?findValue="+findValue);
		}
		
		function findPwdUI(){
			var id = document.getElementById('id');
			var pwd = document.getElementById('pwd');
			
			id.checked = false;
			
			var findValue = pwd.value;
			location.replace("FindUIServlet?findValue="+findValue);
		} */
		
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
        	아이디 찾기<input type="radio" name="id"  id="id" value="id" onClick="checkFind('id')" checked>&nbsp;
			비밀번호 찾기<input type="radio" name="pwd" id="pwd" value="pwd" onClick="checkFind('pwd')">
			
        	<br> <h2>아이디 찾기</h2>
        	
        	<select id="selectConfirmId" name="selectConfirmId" onchange="selectConfirmFunc(selectConfirmId)">
        		<option name="questionConfirm" id="questionConfirm" value="question" selected="selected">질문과 답변으로 찾기</option>
        		<option name="telConfirm" id="telConfirm" value="tel">핸드폰 인증으로 찾기</option>
        		<option name="emailConfirm" id="emailConfirm" value="eamil">이메일 인증으로 찾기</option>
        	</select>
        	<br>
        	
        	<div class="questionConfirmDiv">
	        	<font size="2" color="#999999">질문을 선택하여 답변을 작성해주세요.</font>
	        	<form get="post" action="FindServlet" id="findForm" name="findForm">
	        		<input type="hidden" name="findValue" value="${requestScope.findValue}">
					<input type="hidden" name="userid"  id="userid" >
	        		<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>이름</b></span>
			    			<input type="text" name="name"  id="name" style="width:45%; height:30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>질문</b></span>
			    			<select name="question" style="width:45%; height:30px;">
		                        	<option>질문을 선택해주세요.</option>
		                        	<option>내가 다녔던 초등학교는?</option>
		                        	<option>어머니 성함은?</option>
		                        	<option>아버지 성함은?</option>
		                    </select>
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>답변</b></span>
			    			<input type="text" name="answer" id="answer" style="width:45%; height:30px;">
						</p>
					</div>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="telConfirmDiv">
	        	<font size="2" color="#999999">이름과 연락처를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" id="findForm" name="findForm">
	        		<input type="hidden" name="findValue" value="${requestScope.findValue}">
					<input type="hidden" name="userid"  id="userid" >
	        		<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>이　　름</b></span>
			    			<input type="text" name="name"  id="name" style="width:45%; height:30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>연 락 처</b></span>
			    			<input type="text" name="tel" id="tel" style="width:25%; height:30px;">
			    			<input type="button" name="confirmNumberBtn" id="confirmNumberBtn" value="인증번호 받기" style="width: 19%; height: 30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:15%"><b>인증번호</b></span>
			    			<input type="text" name="confirmNumber" id="confirmNumber" style="width:45%; height:30px;">
						</p>
					</div>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="emailConfirmDiv">
	        	<font size="2" color="#999999">이름과 이메일를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" id="findForm" name="findForm">
	        		<input type="hidden" name="findValue" value="${requestScope.findValue}">
					<input type="hidden" name="userid"  id="userid" >
	        		<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>이　름</b></span>
			    			<input type="text" name="name"  id="name" style="width:45%; height:30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>이메일</b></span>
			    			<input type="text" name="email1" id="email1" style="width:22%; height:30px;">@
			    			<input type="text" name="email2" id="email2" style="width:22%; height:30px;">
						</p>
					</div>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            <br />
        </div><!-- login1 -->
        
        <div id="findPwdDiv"><br />
        	아이디 찾기<input type="radio" name="id"  id="id" value="id" onClick="checkFind('id')">&nbsp;
			비밀번호 찾기<input type="radio" name="pwd" id="pwd" value="pwd" onClick="checkFind('pwd')" checked>
			
        	<br><h2>비밀번호 찾기</h2>
        	
        	<select id="selectConfirmPwd" name="selectConfirmPwd" onchange="selectConfirmFunc(selectConfirmPwd)">
        		<option name="questionConfirm" id="questionConfirm" value="question" selected="selected">질문과 답변으로 찾기</option>
        		<option name="telConfirm" id="telConfirm" value="tel">핸드폰 인증으로 찾기</option>
        		<option name="emailConfirm" id="emailConfirm" value="eamil">이메일 인증으로 찾기</option>
        	</select>
        	<br>
        	
        	<div class="questionConfirmDiv">
	        	<font size="2" color="#999999">질문을 선택하여 답변을 작성해주세요.</font>
	        	<form get="post" action="FindServlet" id="findForm" name="findForm">
	        		<input type="hidden" name="findValue" value="${requestScope.findValue}">
					<input type="hidden" name="userid"  id="userid" >
					<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>아이디</b></span>
			    			<input type="text" name="id"  id="id" style="width:45%; height:30px;">
						</p>
					</div>
	        		<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>이　름</b></span>
			    			<input type="text" name="name"  id="name" style="width:45%; height:30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>질　문</b></span>
			    			<select name="question" style="width:45%; height:30px;">
		                        	<option>질문을 선택해주세요.</option>
		                        	<option>내가 다녔던 초등학교는?</option>
		                        	<option>어머니 성함은?</option>
		                        	<option>아버지 성함은?</option>
		                    </select>
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>답　변</b></span>
			    			<input type="text" name="answer" id="answer" style="width:45%; height:30px;">
						</p>
					</div>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="telConfirmDiv">
	        	<font size="2" color="#999999">아이디, 이름, 연락처를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" id="findForm" name="findForm">
	        		<input type="hidden" name="findValue" value="${requestScope.findValue}">
					<input type="hidden" name="userid"  id="userid" >
					<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>아 이 디</b></span>
			    			<input type="text" name="id"  id="id" style="width:45%; height:30px;">
						</p>
					</div>
	        		<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>이　　름</b></span>
			    			<input type="text" name="name"  id="name" style="width:45%; height:30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>연 락 처</b></span>
			    			<input type="text" name="tel" id="tel" style="width:25%; height:30px;">
			    			<input type="button" name="confirmNumberBtn" id="confirmNumberBtn" value="인증번호 받기" style="width: 19%; height: 30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:15%"><b>인증번호</b></span>
			    			<input type="text" name="confirmNumber" id="confirmNumber" style="width:45%; height:30px;">
						</p>
					</div>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
	            </form>
            </div>
            
            <div class="emailConfirmDiv">
	        	<font size="2" color="#999999">아이디, 이름, 이메일를 작성해주세요.</font>
	        	<form get="post" action="FindServlet" id="findForm" name="findForm">
	        		<input type="hidden" name="findValue" value="${requestScope.findValue}">
					<input type="hidden" name="userid"  id="userid" >
					<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>아이디</b></span>
			    			<input type="text" name="id"  id="id" style="width:45%; height:30px;">
						</p>
					</div>
	        		<div>
						<p>
			    			<span style="width:24%">&nbsp;&nbsp;<b>이　름</b></span>
			    			<input type="text" name="name"  id="name" style="width:45%; height:30px;">
						</p>
					</div>
					<div>
						<p>
			    			&nbsp;&nbsp;<span style="width:24%"><b>이메일</b></span>
			    			<input type="text" name="email1" id="email1" style="width:22%; height:30px;">@
			    			<input type="text" name="email2" id="email2" style="width:22%; height:30px;">
						</p>
					</div>
		            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
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
