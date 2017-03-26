<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<style>
	#boardContent {width:60%; height:100%; margin:0 auto; overflow:hidden;}
	#boardContent h3 {margin-left:0px;}
	
	.boardList {font-size:12px;}
	.boardList th, .boardList td {border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:14px 0 10px 0;}
	.boardList th {background:#f8f8f8;text-align:center;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.boardBtn{width:100%;}
	.boardBtnleft{width:50%; float: left;}
	.boardBtnRight{width:100%; text-align: right;}
	
	#repleList{width:100%;}
</style>

<script type="text/javascript">
	
	//글 수정 관련 함수
	function update(detailForm){
		detailForm.action="FreeBoardUpdateUIServlet";
		detailForm.submit();
	}//update(detailForm)
	
	//댓글 작성 관련 함수
	function repleWrite(seq){
		if('${login}'!=''){
			var target = "";
			if(seq == -1){
				target = document.noticeRepleWriteForm;
			}else{
				target= document.getElementsByClassName("repleWriteForm")[seq];
 			}
			
		 	if(target.content.value != null && target.content.value != ''){
		 		target.submit();
   			}else{
				alert('내용을 입력해주세요.');
			}
			
		}else{
			alert('로그인 하셔야 댓글을 작성하실 수 있습니다.');
		} 
		
	}//repleWrite(id) 
	
	//댓글 삭제 관련 함수
	function repleDelete(frnum, fnum, curPage){
		location.replace('http://localhost:8090/momo/FreeBoardRepleDelete?frnum='+frnum+'&fnum='+fnum+'&curPage='+curPage);
	}//repleDelete(frnum, fnum, curPage)
	
	//삭제가 완료되면 삭제되었다고 alert을 띄어주는 함수
	function onloadCheck(){
		var x = '${repleDel}';
		if(x != ''){
			alert(x);
		}
	}//onloadCheck()
	
	//답변 작성 폼을 띄어주는 함수
	function replePlus(i){
		if(${empty login}){
			alert("로그인이 필요합니다.");
		}else{
			$(".rePlus").not($(".rePlus").eq(i)).hide(); // 선택된 댓글폼이 아닌것 숨김
 			$(".rePlus").eq(i).toggle();	// 선택된 댓글 폼 show , hide 
		}
	}// end replePlus
	
	function goodPlus(){
		if('${login.id}' != ""){
			$.ajax({
				type:"get",
				url:"freeBoard/freeBoardGoodCount.jsp",
				dataType:"text",
				data:{ fnum:${FreeBoardDTO.fnum} },
				success:function(responseData,status,xhr){
					if(responseData.trim()=="false"){
						alert("게시물 당 한번만 추천 할 수 있습니다.");
					}else{
						alert("추천~~!");
						$("#goodCnt").text(responseData.trim());
					}
				},
				error:function(error){}
			});
		}else{
			alert('로그인을 하셔야 추천이 가능합니다.');
		}
	}//goodPlus()
	
</script>

</head>
<body onload="onloadCheck()">
	
	<c:set var="freeBoardDTO" value="${FreeBoardDTO}" scope="request"/>
	<c:set var="login" value="${sessionScope.login}" scope="session"/>
	<c:set var="repleCount" value="${repleCount}" scope="request"/>	<!-- 댓글 갯수 -->

	<div id="boardWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>		
		
		<form id="detailForm" name="detailForm" method="get">
			<input type="hidden" name="fnum" value="${freeBoardDTO.fnum}">
			<input type="hidden" name="curPage" value="${curPage}">
			<input type="hidden" name="author" value="${freeBoardDTO.author}">
			<input type="hidden" name="title" value="${freeBoardDTO.title}">
			<input type="hidden" name="content" value="${freeBoardDTO.content}">
			<input type="hidden" name="content" value="sysdate">
		
		<div id="boardContent">
			<h3>자유게시판</h3>
			<hr>
			<font size="2px">
				<div style="border-bottom: 1px solid;">
					<p>
				    	&nbsp;<span style="width:24%"><b>작성날짜</b></span>&nbsp;&nbsp;
						|　　${freeBoardDTO.writeday}　　　　　　　　　　　　　　　　　　　　　　　　　　　　조회: ${freeBoardDTO.readCnt}　　　추천: <span id="goodCnt">${freeBoardDTO.goodCnt}</span>　
						<a href="javascript:goodPlus();"> 
							<img src="http://localhost:8090/momo/images\freeBoard/recommend.png" width="30px" height="30px">				
						</a> <!-- 추천 -->
					</p>
				</div>
				<div style="border-bottom: 1px solid;">
					<p>
				    	&nbsp;<span style="width:24%"><b>작성자</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
						|　　${freeBoardDTO.author}
					</p>
				</div>
				<div style="border-bottom: 1px solid;">
					<p>
				    	&nbsp;<span style="width:24%"><b>제목</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    	|　　${freeBoardDTO.title}
					</p>
				</div>
			<div>
				<p>
					<textarea rows="15" cols="142" style="border-style: none" readonly>${freeBoardDTO.content}</textarea>
			    </p>
			</div>
		</form> <!-- detailForm -->
		<hr>
		
		<!-- 댓글 작성 폼 -->
		<form method="post" action="FreeBoardRepleWrite" name="noticeRepleWriteForm">
			<input type="hidden" name="fnum" value="${freeBoardDTO.fnum}">
			<input type="hidden" name="id" value="${login.id}">
			<input type="hidden" name="author" value="${login.name}">
			<input type="hidden" name="curPage" value="${curPage}">
			<table border="1">	
				<tr>
					<td rowspan="2" style="width:7.5em; text-align: center;">
						<c:if test="${login.id == null}">로그인<br>해주세요.</c:if>	<!-- 로그인 안했을 경우 -->
						<c:if test="${login.id != null}">${login.name}</c:if>	<!-- 로그인 했을 경우 -->
					</td>
					<td rowspan="2" style="width:56em; padding-left:0.313em;">
						<textarea name="content" rows="2" cols="110" style="border: none" ></textarea>
					</td>
					<td rowspan="2" style="width:7.250em; text-align: center;">
						<a href="javascript:repleWrite(-1);" style="text-decoration: none">
							댓글작성
						</a>
					</td>
				</tr>
			</table>
		</form> <!-- repleWriteForm -->
		
		<!-- 댓글 갯수가 0 이상이면 댓글 리스트를 보여줌 -->
		<c:if test="${repleCount > 0}">
			<br>
			<div id="repleList">
					<c:forEach var="freeBoardRepleDTO" items="${repleList}" varStatus="i">
						<table>	<!-- 댓글 리스트 테이블 -->
							<c:if test="${i.count % 2 != 0}">	<!-- 홀수 일 경우 흰색 -->
								<tr class="reple" style="background-color: #f9f8fe">
							</c:if>
							<c:if test="${i.count % 2 == 0}">	<!-- 짝수 일 경우 컬러색 -->
								<tr style="background-color: #ffffff">
							</c:if>
							<c:if test="${freeBoardRepleDTO.reLevel > 0}">
								<c:forEach begin="0" end="${freeBoardRepleDTO.reLevel-1}">
									<td width="20px" height="10px"></td>
								</c:forEach>
								<td>			
									<input type="image" src="images/freeBoard/arrow.png" width="20px" height="20px">
								</td>
							</c:if>
								<td style="width: 6.250em; text-align: center; font-size: 1.063em;">
									${freeBoardRepleDTO.author}<br>
									${freeBoardRepleDTO.writeday}
								</td>
								<td style="width: 60em; padding-left: 0.313em;">
									${freeBoardRepleDTO.content}
								</td>
								<td style="width: 7.250em; text-align: center;">
									<c:if test="${login.id != freeBoardRepleDTO.id && login.id != 'admin'}">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
									<c:if test="${login.id == freeBoardRepleDTO.id || login.id == 'admin'}">
										<a href="javascript:repleDelete('${freeBoardRepleDTO.frnum}', '${freeBoardDTO.fnum}', '${curPage}');" style="text-decoration: none">
											[삭제]
										</a>
									</c:if>
									<c:if test="${freeBoardRepleDTO.reLevel < 2}">
										<a href="javascript:replePlus(${i.index});">[답변]</a>
									</c:if>
								</td>
								</tr>
								<c:if test="${i.count % 2 != 0}">
									<tr style="background-color: #f9f8fe">
								</c:if>
								<c:if test="${i.count % 2 == 0}">
									<tr style="background-color: #ffffff">
								</c:if>
								</tr>
							
						</table>
						
						<!-- 답변 작성 폼 (처음엔 안보여주다가, 답변 버튼을 누르면 나타남) -->
						<div class="rePlus" style="display: none">
							<form action="FreeBoardRepleWrite" method="post" class="repleWriteForm" name="repleWriteForm">
								<input type="hidden" name="frnum" value="${freeBoardRepleDTO.frnum}">
								<input type="hidden" name="fnum" value="${freeBoardDTO.fnum}">
								<input type="hidden" name="id" value="${login.id}">
								<input type="hidden" name="author" value="${login.name}">
								<input type="hidden" name="curPage" value="${curPage}">
								<table align="right" border="1" >
									<tr>
										<td rowspan="2" style="width:7.5em; text-align: center;">
											${login.name}
										</td>
										<td style="width:60em; padding-left:0.313em;" >
											<textarea name="content" rows="2" cols="115" style="border: none" ></textarea>
										</td>
										<td style="width:7.250em; text-align: center;">
											<a href="javascript:repleWrite(${i.index});" style="text-decoration: none">답변달기</a>
										</td>
									</tr>
								</table>
							</form>
						</div><!-- .rePlus -->
						
					</c:forEach>
				
			</div> <!-- #repleList -->
		</c:if>
		</font>
		
		<br>
		<div class="boardBtn">
			<div class="boardBtnleft">
				<c:if test="${login.id == freeBoardDTO.id || login.id == 'admin'}">  
					<a href="javascript:update(detailForm);"> 
						<img src="http://localhost:8090/momo/images\freeBoard/updateBtn.jpg">
					</a>&nbsp;<!-- 수정 -->
									
					<a href="http://localhost:8090/momo/FreeBoardDeleteServlet?fnum=${freeBoardDTO.fnum}&curPage=${curPage}&author=${freeBoardDTO.author}"> 
						<img src="http://localhost:8090/momo/images\freeBoard/deleteBtn.jpg">
					</a>&nbsp;<!-- 삭제 -->
				</c:if>
			</div> <!-- .boardBtnleft -->
									
			<div class="boardBtnRight">
				<a href="http://localhost:8090/momo/FreeBoardListServlet?curPage=${curPage}">
					<img src="http://localhost:8090/momo/images\freeBoard/listBtn.jpg">
				</a><!-- 목록보기 -->
			</div> <!-- .boardWriteBtn -->
		</div> <!-- .boardBtn -->
		
		<br>
		</div> <!-- boardContent -->
		
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- boardWrap -->
</body>
</html>