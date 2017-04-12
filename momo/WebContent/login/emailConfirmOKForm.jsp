<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
	
	<title>momo</title>
	
	<style type="text/css">
	
		#login_wrap {width: 50%; margin: 0 auto; border-style: solid; border-color: #CCC;
			margin-top: 10px; margin-bottom: 10px;}
			
		#login_wrap table{margin: 0 auto;}
		
		.login1 {width:80%; height:15em; margin: 0 auto; background-color: #fafafa}
		
	</style>
</head>
<body>
	<jsp:include page="sendMail.jsp" flush="true"></jsp:include>

	<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
	<center><br><br />
	
	<div id="login_wrap">
        <div class="login1">
        	<c:set var="memberDTO" value="${applicationScope.memberDTO}" />
        	<br /><br /><br />
        	<font color="#13132f" size="20"><b>${memberDTO.name}</b></font>님!<br>
        	<c:if test="${applicationScope.findRadio == 'id'}">
        		아이디는 <font color="#13132f" size="5">${memberDTO.id}</font> 입니다.
        	</c:if>
        	<c:if test="${applicationScope.findRadio == 'pwd'}">
        		비밀번호는 <font color="#13132f" size="5">${memberDTO.pwd}</font> 입니다.
        	</c:if>
        </div><!-- login1 -->
    </div> <!-- login_wrap -->
    
    </center><br><br />
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>