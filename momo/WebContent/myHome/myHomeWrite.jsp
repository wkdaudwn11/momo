<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이홈자랑</title>

<style>
	
	
	#myHomeContent {width: 80%; margin: 0 auto; overflow: hidden;}
	#myHomeContent h3 { margin-left: 0px;}
	
	#upfile{width:5.5em; font-size: 0.75em; margin-bottom: 0.5em; vertical-align:top;}
	#button{font-size:0.645em; margin-bottom: 0.5em;}
	#button+input{width:50%; height:0.75em; font-size:0.65em; margin-left: 1em; border-style: none;}
	table{display:inline-block; margin-left: 1em;}
	table td{width:3em; height:3em;}
	table img{width:100%; height:100%;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.myHomeWriteBtn{width:100%; text-align: right;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if('${sessionScope.login}'==''){
			alert("로그인 후 이용 할 수 있습니다.");
			location.replace("LoginUIServlet");
	   	}
		
		$("#content").on("focus",function(){
			if($("#title").val() == ""){
				alert("제목을 입력해주세요");
				$("#content").trigger("blur");
				$("#title").trigger("focus");
			}
		});
		
		$("#button").on("click",function(){
			var form = document.getElementById('writeForm');
			var title = form.title.value;
			var content = form.content.value;
 			window.open("OrderListServlet?myHome=myHome&title="+title+"&content="+content,
							"주문내역 상세보기",'width=750, height=500, location=no, resizeable=no');
		});
		
		$("#upfile").on("change", function(e) {  
		 	var files = e.target.files; //FileList object		
		    var img = $("#img");
			var priviewImg = $("table tr");
			var checkFile = true;
			priviewImg.empty();  // 미리보기 비워주기 ( append 로 추가하기 때문.)
			if(files.length > 5){ 
				$("#upfile").val("");
				alert("이미지 파일은 5개 까지만 선택 할수 있습니다.");
			}else{
			    $.each(files, function(i, file) {
			        var pReader = new FileReader(); 
			        if(file.type.match(/image/g) == null){ // 이미지 파일만 올렸는지 다시 확인
			        	checkFile = false;	
			        	return false;					
			        }
			        pReader.addEventListener("load", function(e){ 
			            var pic = e.target;  
			            img.append("<td><img src='"+pic.result+"' disabled></td>")
			            show(); 
			        });
			        pReader.readAsDataURL(file);		
			    });	 // end $.each(files, function(i, file)
			}
			if(checkFile == false){ // 걸리면 선택 파일 지우고 파일 이미지도 지우고
				$("#upfile").val("");
		    	priviewImg.empty();  // 미리보기 이미지 empty
		    	alert("이미지 파일만 선택할수 있습니다. 다시 선택해주세요.");
		    }  
	    });// $("#img").on("change", function(e) 
		    		
	}); // end $(document).ready(function()
			
	function myHomeWrite(writeForm){
		if($("#title").val() ==""){
			alert("제목은 반드시 입력해야 합니다.");
			$("#title").trigger("focus");
		}else if($("#orderList").val() == ""){
			alert("주문내역이 선택되지 않았습니다.");
			$("#button").trigger("click");
		}else{
			writeForm.submit();	
		}
	}
	
	function show() {			 		 
		$(".thumbnail").click(function() {   				
			EXIF.getData(this, function() {					 
	            var make = EXIF.getTag(this, "Make"),		 
	            model = EXIF.getTag(this, "Model");			 
	            alert("I was taken by a " + make + " " + model);
		    });
		});
	}// end function show()
	
	function orderList(checkedProductNum,checkProductName){
		$("#orderListName").val(checkProductName);
		$("#orderListNum").val(checkedProductNum);
	}
</script>

</head>
<body>
	
	<c:set var="login" value="${sessionScope.login}" scope="request"/>
	<c:set var="myHomeDTO" value="${MyHomeDTO}"/>

	<div id="myHomeWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form id="writeForm" name="writeForm" action="MyHomeWriteServlet" method="post" enctype="multipart/form-data">
			<c:if test="${MyHomeDTO != null}">
				<input type="hidden" name="hnum" value="${myHomeDTO.hnum}"/>
				<input type="hidden" name="curPage" value="${curPage}">
			</c:if>
			<input type="hidden" id="orderListNum" name="orderList">
			<div id="myHomeContent">
				<h3>마이홈자랑</h3>
				<hr>
				<div>
					<p>
				    	&nbsp;<span style="width:24%;"><b>작성자</b></span>&nbsp;&nbsp;
				    	<input type="text" name="author" id="author" style="width:20%; height:50px;" value="${login.name}" readonly>
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>제목</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<!-- 수정일 때 -->
				    	<c:if test="${MyHomeDTO != null}">
				    		<input type="text" name="title"  id="title" value="${myHomeDTO.title}" style="width:88%; height:50px;" >
				    	</c:if>
				    	
				    	<!-- 수정이 아닐 때 -->
				    	<c:if test="${MyHomeDTO == null}">
				    		<input type="text" name="title"  id="title" value="${title}" style="width:88%; height:50px;" >
				    	</c:if>
					</p>
				</div>
					<input type="button" id="button" value="주문내역보기">
					<input type="text" id="orderListName" readonly="readonly">
				<div>
					<input type="file" id="upfile" name="upfile" accept="image/*" multiple>
					<table>
						<tr id="img"></tr>
					</table>
				</div>
				<div>
				    	&nbsp;<span style="width:24%"><b>내용</b></span>&nbsp;&nbsp;&nbsp;
				    	<!-- 수정일 때 -->
				    	<c:if test="${MyHomeDTO != null}">
				    		&nbsp;<textarea name="content" id="content" rows="10" cols="111" >${myHomeDTO.content}</textarea>
				    	</c:if>
				    	
				    	<!-- 수정이 아닐 때 -->
				    	<c:if test="${MyHomeDTO == null}">
				    		&nbsp;<textarea name="content" id="content" rows="10" cols="111" >${content}</textarea>
				    	</c:if>
				</div>
				<br>
				<div class="myHomeWriteBtn">
 					<a href="javascript:myHomeWrite(writeForm);"> 
						<img src="images\freeBoard/writeBtn.jpg" height="30">
					</a>&nbsp;
				</div> <!-- myHomeWriteBtn -->
				
			</div> <!-- myHomeContent -->
			<br>
		</form>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- myHomeWrap -->
</body>
</html>