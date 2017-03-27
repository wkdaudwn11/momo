<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.question.QuestionPage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>문의 게시판</title>

<style>
	#questionContent {width:70%; margin:0 auto; overflow:hidden;}
	#questionContent h3 {margin-left:0px;}
	
	.questionList {font-size:12px;}
	.questionList th, .questionList td {border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.questionList th {background:#f8f8f8;text-align:center;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.questionWriteBtn{width:100%; text-align: right;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	var successPassword = new Array(); // 비밀번호 입력 성공된 경우 index 저장 
	var currindex; // 현재 요청한 인덱스

	$(document).ready(function(){
		if('${AccessWrong}'!=''){
			alert("게시물 수정 실패!");
		}
		if('${WriteSuccess}'!=''){
			alert("${WriteSuccess}");
		}
		if('${DeleteSuccess}'!=''){
			alert('${DeleteSuccess}');
		}
		
		$("#searchType").on("change",function(){
			if($(this).val() == 'category'){
				$("#searchValue").html(
						"<select name='searchValue'>"+
							"<option value='A/S'>A/S</option>"+
							"<option value='product'>제품문의</option>"+
							"<option value='delevery'>배송문의</option>"+
							"<option value='etc'>기타</option>"+
						"</select>");
			}
		});// end on("change")
		
		/* 게시글 비밀번호 입력시*/
		$(".tr").on("click","#input",function(){
			inputPwd = $(this).prev("input").val();
			selectQnum = $(this).closest("tr").prevAll(".hiddenQnum").val();
			$.ajax({
				type:"post",
				url:"question/questionDetail.jsp",
				dataType:"text",
				data:{
					password : inputPwd,
					qnum : selectQnum
				},
				success:function(responseData,status,xhr){
					if(responseData.trim() == "thraw"){
						alert("비밀번호가 맞지 않습니다.다시 확인해주세요");
					}else{
						successPassword[successPassword.length] = currindex;
						readCntPlus(selectQnum);
						$("#show").text(responseData.trim());
					}
				},
				error:function(error){}
			});
		});// end $(".td").on("click","#input")
	
	});// end $(document).ready();  ------------------------------------
	
	
	/** 조회수 업데이트 후 반환*/
	function readCntPlus(selectQnum){
		var readCnt;
		$.ajax({
			type:"get",
			url:"question/readCntPlus.jsp",
			dataType:"text",
			data:{
				qnum : selectQnum
			},
			success:function(responseData,status,xhr){
				readCnt = responseData.trim();
				$(".readCnt").eq(currindex).text(readCnt);
			},
			error:function(error){}
		}); // end $.ajax()  -- readCnt 증가
	} // end readCntPlus(selectQnum)
	
	/* 내용 상세보기 */
	function questionDetail(qnum,index,content,password){
		var target = $(".tr").eq(index);
		currindex = index;
		$(".tr").not(target).hide();
		if(password == null || successPassword.indexOf(currindex) != -1){
			if($(".tr").eq(currindex).attr("style") =="display: none;"){ readCntPlus(qnum); }
			target.html("<td colspan='6'>"+content+"</td>");
		}else{
			target.html("<td colspan='6' id='show'><b>비밀번호</b><input type='password' style='width:15em;'><button id='input'>입력</button></td>");
		}
		$(".tr").eq(index).toggle();
	}// end questionDetail(qnum){$.ajax()}
	
</script>

</head>
<body>

	<c:set var="questionPage" value="${QuestionPage}" scope="request"/> <!-- 페이징 처리에 필요한 data가진 class -->
	
	<c:set var="questionList" value="${QuestionPage.questionList}" scope="request"/> <!-- 페이지에 보여줄 리스트 -->
	<c:set var="curPage" value="${QuestionPage.curPage}" scope="request"/> <!-- 요청된 현재 페이지 -->
	<c:set var="perPage" value="${QuestionPage.perPage}" scope="request"/> <!-- 페이지 당 보여줄 리스트 수(5) -->
	<c:set var="page" value="${QuestionPage.page}" scope="request"/> <!-- 표시할 페이지 수 -->
	<c:set var="pageblock" value="${Math.ceil(curPage/page)}" scope="request"/> <!-- 표시할 페이지 블럭수 -->
	<c:set var="totalRecord" value="${QuestionPage.totalRecord}" scope="request"/> <!-- 전체 게시물 수 -->
	
	<c:set var="search" value="${search}" scope="request"/> <!-- 검색  정보  -->

	<div id="questionWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<div id="questionContent">
			<h3>문의 게시판</h3>
			<hr>
			
			<!-- 게시판 리스트 -->
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="questionList">
				<tr height="30"> 
					<th width="50">번 호</th> 
					<th width="50">분류</th>
					<th width="200">제   목</th> 
				    <th width="100">작성자</th>
				    <th width="150">작성일</th> 
				    <th width="50">조 회</th>
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
						<c:forEach var="questionDTO" items="${questionList}" varStatus="status">
							<input class="hiddenQnum" type="hidden" value="${questionDTO.qnum}">
							<input class="index" type="hidden" value="${status.index}">
							<tr  height="30">
								<td  width="50" align="center" >
									<%-- <c:if test="'${questionDTO.reple}' =='y' "><img src="http://localhost:8090/momo/question/arrow.png"></c:if>
									<c:if test="'${questionDTO.reple}' !='y' ">${questionDTO.qnum}</c:if> --%>
									</td>
								<td width="50" align="center">[&nbsp;${questionDTO.category}&nbsp;]</td>
							    <td  width="200" align="left">				
								    <a href="javascript:questionDetail(${questionDTO.qnum},${status.index},'${questionDTO.content}'<c:if test="${questionDTO.password != null}">,${questionDTO.password}</c:if>);">
								    	<c:if test="${questionDTO.password != null}">
								    		<img src="http://localhost:8090/momo/images/question/lock.gif"> &nbsp;
								    	</c:if>
								    	${questionDTO.title}
								    </a>
								<%-- <% if(article.getReadcount()>=20){%>
								         <!-- 핫  <img src="../../images/hot.gif" border="0"  height="16">--><%}%> --%> 
							    </td>
			 					<td width="50" align="center">${questionDTO.author}</td>			    
							    <td width="150" align="center">${questionDTO.writeday}</td>
							    <td class="readCnt" width="50" align="center">${questionDTO.readCnt}</td>
							</tr>
							<tr class="tr" style="display: none;"></tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table> <!-- questionList -->
			
			<!-- 페이징처리 -->
			<c:if test="${pageblock*page <= Math.ceil(totalRecord/perPage)}">
				<c:set var="endPage" value="${pageblock*page}" scope="request"/>
			</c:if>
			<c:if test="${pageblock*page > Math.ceil(totalRecord/perPage)}">
				<c:set var="endPage" value="${Math.ceil(totalRecord/perPage)}" scope="request"/>
			</c:if>
			
			<div class="paging">
				<c:if test="${curPage != 1}">
					<p><a href="QuestionListServlet?curPage=1">[처음]</a>
				</c:if>
				
				<c:if test="${pageblock > 1}">
					<a href="http://localhost:8090/momo/QuestionListServlet?curPage=${Math.round((pageblock*page)-19)}&searchType=${search.searchType}&searchValue=${search.searchValue}">
						[이전]
					</a>
				</c:if> &nbsp;
				
				 <c:forEach var="i" begin="${(pageblock*page)-(page-1)}" end="${endPage}" >
					<c:choose>
						<c:when test="${curPage == i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="http://localhost:8090/momo/QuestionListServlet?curPage=${i}&searchType=${search.searchType}&searchValue=${search.searchValue}">
								${i}
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach> &nbsp;
				
				<c:if test="${pageblock != Math.ceil((totalRecord/perPage+1)/page)}">
					<a href="http://localhost:8090/momo/QuestionListServlet?curPage=${Math.round((pageblock*page)+1)}&searchType=${search.searchType}&searchValue=${search.searchValue}">
						[다음]
					</a>
				</c:if>
				
				<c:if test="${curPage != Math.ceil(totalRecord/perPage)}">
					<a href="http://localhost:8090/momo/QuestionListServlet?curPage=${Math.round((totalRecord/perPage))}&searchType=${search.searchType}&searchValue=${search.searchValue}">
						[끝]
					</a></p>
				</c:if>
				
				<br>
			</div>	<!-- questionPaging -->
			
			<!-- 글 검색 -->
			<form id="search" action="QuestionListServlet" method="get">
				<select	id="searchType" name="searchType">
					<option value="title"
						<c:if test="${search.searchType}=='title'">
							selected
						</c:if> >제목 </option>
					<option value="content"
						<c:if test="${search.searchType}=='content'">
							selected
						</c:if> >내용</option>
					<option value="author"
						<c:if test="${search.searchType}=='author'">
							selected
						</c:if> >작성자 </option>
					<option value="category"
						<c:if test="${search.searchType}=='category'">
							selected
						</c:if> >분류 </option>
				</select>
				<span id="searchValue"><input type="text" name="searchValue" value="${search.searchValue}"><input type="submit" value="검색"></span>
			</form>
			
			<div class="questionWriteBtn">
				<a href="http://localhost:8090/momo/QuestionWriteUIServlet">
					<img src="http://localhost:8090/momo/images\freeBoard/writeBtn.jpg" height="30px">
				</a>
			</div> <!-- questionWriteBtn -->
			
		</div> <!-- questionContent -->
		<br>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- questionWrap -->
</body>
</html>