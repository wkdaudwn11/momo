<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.freeboard.FreeBoardPageDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판</title>

<style>
	#boardContent {width:70%; margin:0 auto; overflow:hidden;}
	#boardContent h3 {margin-left:0px;}
	
	.boardList {font-size:12px;}
	.boardList th, .boardList td {border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.boardList th {background:#f8f8f8;text-align:center;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.boardWriteBtn{width:100%; text-align: right;}
</style>

<script>
	window.onload = function onload(){
		if('${AccessWrong}'!=''){
			alert("게시물 수정 실패!");
		}
		if('${WriteSuccess}'!=''){
			alert("${WriteSuccess}");
		}
		if('${DeleteSuccess}'!=''){
			alert('${DeleteSuccess}');
		}
	}
</script>

</head>
<body>

	<c:set var="freeBoardPage" value="${freeBoardPage}" scope="request"/> <!-- 페이징 처리에 필요한 data가진 class -->
	
	<c:set var="freeBoardList" value="${freeBoardPage.freeBoardList}" scope="request"/> <!-- 페이지에 보여줄 리스트 -->
	<c:set var="curPage" value="${freeBoardPage.curPage}" scope="request"/> <!-- 요청된 현재 페이지 -->
	<c:set var="perPage" value="${freeBoardPage.perPage}" scope="request"/> <!-- 페이지 당 보여줄 리스트 수(10) -->
	<c:set var="page" value="${freeBoardPage.page}" scope="request"/> <!-- 표시할 페이지 수 -->
	<c:set var="pageblock" value="${Math.ceil(curPage/page)}" scope="request"/> <!-- 표시할 페이지 블럭수 -->
	<c:set var="totalRecord" value="${freeBoardPage.totalRecord}" scope="request"/> <!-- 전체 게시물 수 -->
	
	<c:set var="search" value="${search}" scope="request"/> <!-- 검색  정보  -->

	<div id="boardWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<div id="boardContent">
			<h3>자유게시판</h3>
			<hr>
			<p>글목록(전체 글: ${totalRecord})</p>
			
			<!-- 게시판 리스트 -->
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="boardList">
				<tr height="30"> 
					<th width="50">번 호</th> 
					<th width="200">제   목</th> 
				    <th width="100">작성자</th>
				    <th width="150">작성일</th> 
				    <th width="50">조 회</th>
				    <th width="50">추 천</th>   
				</tr>
				<c:choose>
					<c:when test="${totalRecord == 0}">
						<table>
							<tr>
								<td align="center">
									게시판에 저장된 글이 없습니다.
							    </td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<c:forEach var="freeBoardDTO" items="${freeBoardList}" >
							<tr height="30">
								<td  width="50" align="center" >${freeBoardDTO.fnum}</td>
							    <td  width="200" align="left">				           
								    <a href="http://localhost:8090/momo/FreeBoardDetailServlet?fnum=${freeBoardDTO.fnum}&curPage=${curPage}">
								    	${freeBoardDTO.title}&nbsp;&nbsp;
								    	<c:if test="${freeBoardDTO.repleCnt > 0}"> <!-- 댓글 갯수가 0보다 크면 댓글 갯수를 보여줌 -->
								    		(${freeBoardDTO.repleCnt})
								    	</c:if>
								    </a> 
								<%-- <% if(article.getReadcount()>=20){%>
								         <!-- 핫  <img src="../../images/hot.gif" border="0"  height="16">--><%}%> --%> 
							    </td>
			 					<td width="50" align="center">${freeBoardDTO.author}</td>			    
							    <td width="150" align="center">${freeBoardDTO.writeday}</td>
							    <td width="50" align="center">${freeBoardDTO.readCnt}</td>
							    <td width="50" align="center">${freeBoardDTO.goodCnt}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table> <!-- boardList -->
			
			<!-- 페이징처리 -->
			<c:if test="${pageblock*page <= Math.ceil(totalRecord/perPage)}">
				<c:set var="endPage" value="${pageblock*page}" scope="request"/>
			</c:if>
			<c:if test="${pageblock*page > Math.ceil(totalRecord/perPage)}">
				<c:set var="endPage" value="${Math.ceil(totalRecord/perPage)}" scope="request"/>
			</c:if>
			
			<div class="paging">
				<c:if test="${curPage != 1}">
					<p><a href="FreeBoardListServlet?curPage=1">[처음]</a>
				</c:if>
				
				<c:if test="${pageblock > 1}">
					<a href="http://localhost:8090/momo/FreeBoardListServlet?curPage=${Math.round((pageblock*page)-19)}&searchType=${search.searchType}&searchValue=${search.searchValue}">
						[이전]
					</a>
				</c:if> &nbsp;
				
				 <c:forEach var="i" begin="${(pageblock*page)-(page-1)}" end="${endPage}" >
					<c:choose>
						<c:when test="${curPage == i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="http://localhost:8090/momo/FreeBoardListServlet?curPage=${i}&searchType=${search.searchType}&searchValue=${search.searchValue}">
								${i}
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach> &nbsp;
				
				<c:if test="${pageblock != Math.ceil((totalRecord/perPage+1)/page)}">
					<a href="http://localhost:8090/momo/FreeBoardListServlet?curPage=${Math.round((pageblock*page)+1)}&searchType=${search.searchType}&searchValue=${search.searchValue}">
						[다음]
					</a>
				</c:if>
				
				<c:if test="${curPage != Math.ceil(totalRecord/perPage)}">
					<a href="http://localhost:8090/momo/FreeBoardListServlet?curPage=${Math.round((totalRecord/perPage))}&searchType=${search.searchType}&searchValue=${search.searchValue}">
						[끝]
					</a></p>
				</c:if>
				
				<br>
			</div>	<!-- boardPaging -->
			
			<!-- 글 검색 -->
			<form id="search" action="FreeBoardListServlet" method="get">
				<select	name="searchType">
					<option value="title"
						<c:if test="${search.searchType}=='title'">
							selected
						</c:if> >제목 </option>
					<option value="author"
						<c:if test="${search.searchType}=='author'">
							selected
						</c:if> >작성자 </option>
				</select>
				<input type="text" name="searchValue" value="${search.searchValue}"><input type="submit" value="검색">
			</form>
			
			<div class="boardWriteBtn">
				<a href="http://localhost:8090/momo/FreeBoardWriteUIServlet">
					<img src="http://localhost:8090/momo/images\freeBoard/writeBtn.jpg" height="30px">
				</a>
			</div> <!-- boardWriteBtn -->
			
		</div> <!-- boardContent -->
		<br>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- boardWrap -->
</body>
</html>