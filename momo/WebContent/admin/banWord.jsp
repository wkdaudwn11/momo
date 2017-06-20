<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>금지어 관리</title>

<style>
#banWordWrap {
	margin: 0 auto;
	width: 80%;
	height: auto;
}

#banWordDiv {
	margin: 0 auto;
	width: 30%;
}

#banWordTable {
	margin: 0 auto;
	width: 30%;
	text-align: center;
}

.tableLeft {
	width: 20%;
}

.tableMiddle {
	width: 60%;
}

.tableRight {
	width: 20%;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if ('${sessionScope.login}' == ''
				|| '${sessionScope.login.id}' != 'admin') {
			alert("잘못된 접근입니다!");
			location.replace("../IndexServlet");
		}
	});

	function banWordDelete(bwnum) {
		location.replace("banWordDeleteServlet?bwnum=" + bwnum);
	}
</script>

</head>
<body>

	<c:set var="login" value="${sessionScope.login}" scope="request" />

	<jsp:include page="../include/header.jsp" flush="true"></jsp:include>

	<div id="banWordWrap">
		<br />

		<div id="banWordDiv">
			<form method="post" action="banWordRegisterServlet">
				<input type="text" name="banWordInput" placeholder="금지어를 입력하세요."
					style="width: 60%;">&nbsp; <input type="submit" value="추가">
			</form>
		</div>

		<br />
		<table id="banWordTable" border="1">
			<tr>
				<th class="tableLeft">번호</th>
				<th class="tableMiddle">단어</th>
				<th class="tableRight">삭제</th>
			</tr>

			<c:choose>
				<c:when test="${!empty list}">
					<c:forEach var="banWordDTO" items="${list}" varStatus="i">
						<tr>
							<td class="tableLeft">${i.count}</td>
							<td class="tableMiddle">${banWordDTO.word}</td>
							<td class="tableRight">
								<button onclick="banWordDelete('${banWordDTO.bwnum}')">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3">등록된 금지어가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>

		</table>
		<br />

	</div>
	<!-- banWordWrap -->

	<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>

</body>
</html>