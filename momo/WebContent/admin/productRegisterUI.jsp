<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 등록</title>

<style>
	#productRegisterContent {width:80%; margin:0 auto; overflow:hidden;}
	#productRegisterContent h3 {margin-left:0px;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.boardWriteBtn{width:100%; text-align: right;}
	
	.display {display: none;}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("#image_preview").addClass("display");
		
		if('${sessionScope.login}' == '' || '${sessionScope.login.id}' != 'admin'){
   	  		alert("잘못된 접근입니다!");
   	  		location.replace("../IndexServlet");
		}
		
		$("#upfile").on("change", function(e) {
			readURL(this, e);
		});
		
		//사진 미리보기
		function readURL(input, e) {
			var file = e.target.files;
			
			$("#image_preview").addClass("display");
			
			if(file.length == 1){
				if(file[0].type.match(/image/g) == null){ // 이미지 파일만 올렸는지 다시 확인
		        	alert('이미지 파일만 올릴 수 있습니다.');
		        }else{
					var reader = new FileReader();
	
					reader.onload = function(e) {
						$('#blah').attr('src', e.target.result);
					}
	
					reader.readAsDataURL(input.files[0]);
					
					$("#image_preview").removeClass("display");
		        }
			}else{
				$("#upfile").val("");
				alert('image 파일을 한개만 올릴 수 있습니다.');
			}
		}//readURL(input)
		
		$("#content").on("keyup", function(e){
			
		});
	});
	
</script>

</head>
<body>
	
	<c:set var="login" value="${sessionScope.login}" scope="request"/>

	<div id="productRegisterWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form id="productRegisterForm" name="productRegisterForm" action="" method="post" enctype="multipart/form-data">
			<div id="productRegisterContent">
				<h3>상품 등록</h3>
				<hr>
				<div>
					<p>
				    	&nbsp;<span style="width:24%;"><b>카테고리</b></span>
				    	<select style="width: 3%; height: 30px;">
				    		<option>1</option>
				    		<option>2</option>
				    		<option>3</option>
				    		<option>4</option>
				    	</select>
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>이름</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name=""  id="" style="width:50%; height:30px;">
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>가격</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name=""  id="" style="width:25%; height:30px;">
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>할인율</b></span>&nbsp;&nbsp;
				    	<input type="text" name=""  id="" style="width:25%; height:30px;">
					</p>
				</div> 
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>대표사진</b></span>
				    	<input type="file" id="upfile" name="upfile" accept="image/*" multiple>
					</p>
					<p id="image_preview">
						&nbsp;<span style="width:24%"><b>미리보기</b></span>
						<img id="blah" src="#" alt="your image" width="200" height="200" />
					</p>
				</div>
				<div>
			    	&nbsp;<span style="float: left; margin-left: 10px; margin-right: 4%;"><b>내용</b></span>
			    	<div style="width: 100%; border: 1px solid black;">
			    		<center>
			    			<img src="images/login/joinBtn.jpg" />
				    		<textarea name="content" id="content" rows="10" cols="120" style="border-style: none;"></textarea>
				    		<img src="images/login/joinBtn.jpg" />
				    		<textarea name="content" id="content"  cols="120" style="border-style: none; overflow: visible;"></textarea>
			    		</center>
			    	</div>
				</div>
				<br>
				<div class="boardWriteBtn">
 					<a href="javascript:boardWrite(writeForm);"> 
							<img src="images\freeBoard/writeBtn.jpg" height="30">
					</a>&nbsp;
				</div> <!-- boardWriteBtn -->
				
			</div> <!-- boardContent -->
			<br>
		</form>
		<jsp:include page="../include/footer.jsp" flush="true"></jsp:include>
	</div> <!-- boardWrap -->
</body>
</html>