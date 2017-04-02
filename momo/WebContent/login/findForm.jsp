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
	
		#login_wrap {width: 80%; margin: 0 auto;}
		
		#find_id {width: 50%; float: left; text-align:center; margin-top:50px; margin-bottom:50px;
			border-top: 3px solid #CCC; border-left: 3px solid #CCC; border-bottom: 3px solid #CCC;}
			
		#find_pwd {width: 50%; float: left;  text-align:center; margin-top:50px; margin-bottom:50px; 
			border: 3px solid #CCC;}
			
		.displayNone {display: none;}
		.displayBlock {display: block;}

	</style>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
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
		
		function ajaxUI(findValue){
			
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
	
	<div id="login_wrap">
		<div id="find_id">
        	<h2>아이디 찾기</h2>
        	<select>
        		<option>질문과 답변</option>
        		<option>핸드폰 인증</option>
        		<option>이메일 인증</option>
        	</select>
        	<br>
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
		    			<!-- <input type="text" name="answer" id="answer" style="width:45%; height:20px;"> -->
		    			<input type="text" name="answer" id="answer" style="width:45%; height:30px;">
					</p>
				</div>
	            <input type="image" src="images/login/findIdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
            </form>
		</div> <!-- find_id -->
		
	    <div id="find_pwd">
        	<h2>비밀번호 찾기</h2>
        	<select>
        		<option>질문과 답변</option>
        		<option>핸드폰 인증</option>
        		<option>이메일 인증</option>
        	</select>
        	<br>
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
		    			<!-- <input type="text" name="answer" id="answer" style="width:45%; height:20px;"> -->
		    			<input type="text" name="answer" id="answer" style="width:45%; height:30px;">
					</p>
				</div>
	            <input type="image" src="images/login/findPwdBtn.jpg" style="width:100px; height:40px;"> <!-- 서브밋 버튼 -->
            </form>
		</div> <!-- find_pwd -->
    </div> <!-- login_wrap -->
    
    　<br />
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
