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

	</style>

	<script type="text/javascript">
		
		function findIdUI(){
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
		}
		
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
		<c:if test="${requestScope.findValue == 'id'}">
	        <div id="login1"><br />
	        	아이디 찾기<input type="radio" name="find"  id="id" value="id" onClick="findIdUI()" checked>&nbsp;
				비밀번호 찾기<input type="radio" name="find" id="pwd" value="pwd" onClick="findPwdUI()">
	        	<br> <h2>아이디 찾기</h2>
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
			    			<!-- <input type="text" name="answer" id="answer" style="width:45%; height:20px;"> -->
			    			<input type="text" name="answer" id="answer" style="width:45%; height:30px;">
						</p>
					</div>
		            <input type="image" src="http://localhost:8090/momo/images/login/findIdBtn.jpg" 
		            	style="width:100px; height:30px;"> <!-- 서브밋 버튼 -->
		            <a href="http://localhost:8090/momo/JoinUIServlet">
               			<img src="http://localhost:8090/momo/images/login/joinBtn.jpg" width="100" height="30">
               		</a>
	            </form>
	            <br />
	        </div><!-- login1 -->
	    </c:if>
       	
       	<c:if test="${requestScope.findValue == 'pwd'}">
	        <div id="login1"><br />
	        	아이디 찾기<input type="radio" name="find"  id="id" value="id" onClick="findIdUI()">&nbsp;
				비밀번호 찾기<input type="radio" name="find" id="pwd" value="pwd" onClick="findPwdUI()" checked>
	        	<br><h2>비밀번호 찾기</h2>
	        <font size="2" color="#999999">아이디를 입력하신 후, 질문을 선택하여 답변을 작성해주세요.</font>
	        	<form method="post" action="FindServlet" id="findForm" name="findForm">
	        		<input type="hidden" name="findValue" value="${requestScope.findValue}">
	        		<div>
						<p>
			    			<span style="width:24%"><b>아이디</b></span>
			    			<input type="text" name="userid"  id="userid" style="width:45%; height:30px;">
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
			    			<input type="text" name="answer"  id="answer" style="width:45%; height:30px;">
						</p>
					</div>
		            <input type="image" src="http://localhost:8090/momo/images/login/findPwdBtn.jpg" 
		            	style="width:100px; height:30px;">
		            <a href="http://localhost:8090/momo/JoinUIServlet">
	               		<img src="http://localhost:8090/momo/images/login/joinBtn.jpg" width="100" height="30">
	               	</a>
	            </form>
	            <br />
	        </div><!-- login1 -->
	    </c:if>
    </div> <!-- login_wrap -->
    </center>
    <br />
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
