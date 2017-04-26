<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 등록</title>

<style>
	#productRegisterContent {width:80%; margin:0 auto; overflow:hidden;}
	#productRegisterContent h3 {margin-left: 0px;}
	
	.paging {width:100%; text-align: center; font-size: 16px; color: #000000;}
	.boardWriteBtn{width:100%; text-align: right;}
	
	.upfileContent{width: 5em;}
	#upfile{width: 5.1em;}
	
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
		});//upfile
		
		//대표사진 미리보기
		function readURL(input, e) {
			var file = e.target.files;
			
			$("#image_preview").addClass("display");
			
			if(file.length == 1){
				if(file[0].type.match(/image/g) == null){
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
		}//readURL(input, e)
		
		upfileContentClickCount = 0; // #upfileContent 클릭 횟수를 나타내는 변수
		
		$("#fileDiv").on("change", ".upfileContent", function(e){
			readURLContent(this, e);
		});

		//content에 업로드한 사진 미리보기
		function readURLContent(input, e) {
			var files = e.target.files;
			var fileCheck = true;
			
			$("#image_preview_content").addClass("display");
			
			if(files.length > 0){
				
				for(var i=0; i<files.length; i++){
					if(files[i].type.match(/image/g) == null){
						fileCheck = false;
						break;
					}
				}
				
				if(fileCheck == true){
					/* input type="file" 한 개 당 한 개의 사진(들)만 올릴 수 있기 때문에
					기존의 file버튼을 감춰주고 새로운 file버튼을 만든다.*/
					$(".upfileContent").addClass("display");
					$("#fileDiv").append("<input type='file' class='upfileContent' name='upfileContent' accept='image/*' multiple >");
					
					upfileContentClickCount++; // 사진을 올렸으면 +1 증가시켜준다.
					
					$.each(files, function(i, value){
						
						var reader = new FileReader();
						
						reader.onload = function(e) {
							
							if(upfileContentClickCount == 1){	// 처음에 사진 올리는 것은 기본으로 들어있는 textArea의 위에다가 올려야함.
								// 이미지를 넣을 때 hidden태그에다가 image의 이름을 넣어준다.
								$("<span class='image_preview_content'><img src="+e.target.result+"><input type='hidden' class='imageName' value='"+value.name+"'></span>").prependTo("#contentDiv");
							}else if(upfileContentClickCount > 1){ // 두번째 사진 올리는 것은 기본으로 들어있는 textArea의 아래에다가 올려야함.
								
								if(files.length == 1){
									
									$("#contentDiv").append("<span class='image_preview_content'><img src="+e.target.result+"><input type='hidden' class='imageName' value='"+value.name+"'></span>");
									$("#contentDiv").append("<div class='divisionLine'><input type='hidden' class='divisionLinetHidden' value='momo'></div>");
									$("#contentDiv").append("<textarea class='content' name='content' rows='10' cols='120' style='border-style: none;'></textarea>");
									
								}else{ // 두번 째 사진을 올리는데, 파일이 여러장이면 사진을 붙여서 올려야함
									
									$("#contentDiv").append("<span class='image_preview_content'><img src="+e.target.result+"><input type='hidden' class='imageName' value='"+value.name+"'></span>");
								
									if(i == files.length-1){ // i(반복문의 index)가 files.length-1이라는 건, 사진이 다 올라왔다는 경우니까 textarea를 뿌려준다.
										$("#contentDiv").append("<div class='divisionLine'><input type='hidden' class='divisionLinetHidden' value='momo'></div>");
										$("#contentDiv").append("<textarea class='content' rows='10' cols='120' style='border-style: none;'></textarea>");
									}//if(i == files.length-1)
									
								}//if(files.length == 1)
							
							}//if(upfileContentClickCount == 1)
						}//reader.onload = function(e)
						
						reader.readAsDataURL(input.files[i]);
						
						$("#image_preview_content").removeClass("display");
					});//$.each(files, function(i, value)
							
				}else{
					alert('이미지 파일만 올릴 수 있습니다.');
				}//if(fileCheck == true)
					
			}else{
				$("#upfile").val("");
			}//if(files.length > 0)
				
		}//readURLContent(input, e)
		
	});
					
	function productRegister(){
		
		var result = true;
		var form = document.getElementById('productRegisterForm');
		
		var content = "";
		var contentArray = document.getElementsByClassName("content");
		
		var imageName = null;
		var imageNameArray = document.getElementsByClassName("imageName");
		
		for(var i=0; i<contentArray.length; i++){
			if(imageName != null){
				imageName += imageNameArray[i].value+"&&";
				content += "&&"+contentArray[i].value;
			}else{
				content += contentArray[i].value;
			}
		}
		
		document.getElementById("contentHap").value = content;
		document.getElementById("imageHap").value = imageName;
		
		if(form.name.value == ""){
			alert('상품의 이름을 입력해주세요.');
			result = false;
		}else if(form.price.value == ""){
			alert('상품의 가격을 입력해주세요.');
			result = false;
		}else if(form.discount.value == ""){
			var confirmResult = confirm('상품의 할인율을 입력 안 할 경우 0%로 적용됩니다.\n 0%로 적용하시겠습니까?');
			if(confirmResult == true){
				form.discount.value = 0;
			}else{
				result = false;
			}
		}else if(form.upfile.value == ""){
			alert('대표사진을 올려주세요.');
			result = false;
		}
		
		if(result == true){
			form.submit();
		}
	}//productRegister(form)
	
</script>

</head>
<body>
	
	<c:set var="login" value="${sessionScope.login}" scope="request"/>

	<div id="productRegisterWrap">
		<jsp:include page="../include/header.jsp" flush="true"></jsp:include>
		
		<form id="productRegisterForm" method="post" action="ProductRegisterServlet" enctype="multipart/form-data"> 
		
			<input type="hidden" id="contentHap" name="contentHap">
			<input type="hidden" id="imageHap" name="imageHap">
			
			<div id="productRegisterContent">
				<h3>상품 등록</h3>
				<hr>
				<div>
					<p>
				    	&nbsp;<span style="width:24%;"><b>카테고리</b></span>
				    	<select name="category" style="width: 3%; height: 30px;">
				    		<option value="1">1</option>
				    		<option value="2">2</option>
				    		<option value="3">3</option>
				    		<option value="4">4</option>
				    	</select>
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%;"><b>이름</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name="name" id="name" style="width:50%; height:30px;">
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>가격</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="text" name="price" id="price" style="width:25%; height:30px;">
					</p>
				</div>
				<div>
					<p>
				    	&nbsp;<span style="width:24%"><b>할인율</b></span>&nbsp;&nbsp;
				    	<input type="text" name="discount" id="discount" style="width:25%; height:30px;">
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
			    	<div id="fileDiv">
			    		&nbsp;<span style="float: left; margin-left: 10px; margin-right: 2.5%;">
			    			<b>내용</b>
			    		</span>
			    		<input type="file" class="upfileContent" name="upfileContent" accept="image/*" multiple>
			    	</div>
			    	
			    	<center>
			    	<div id="contentDiv" style="width: 100%; border: 1px solid black;">
			    		<div class="divisionLineDefault">
			    		</div>
			    		<textarea class="content" name='content' rows="10" cols="120" style="border-style: none;"></textarea>
			    	</div>
			    	</center>
			    	
				</div>
				<br>
				<div class="boardWriteBtn">
 					<a href="javascript:productRegister();"> 
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