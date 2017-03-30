<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="no-js" ng-app>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원가입</title>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	
	<!-- DAUM 주소 라이브러리 시작 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="../js/daum.js"></script>
	<!-- DAUM 주소 라이브러리 끝 -->

    <style>
    	button, select {padding : 12px 15px; width : 100%;}
    	
    	button {background : #000000;}    
    		
    	.postcodify_controls{background : #000000;} 
    	
    	.search_button{padding : 0px 0px;}
    	
    	.close_button{padding : 0px 0px;}
    	
    	#insert_img{width:730px; margin-top:10px; margin-left:30px;}
    	
    	#joinWrap {width:80%; margin:0 auto;}
    	
    	.content-section {width:40%; float: left; padding-right: 40px;}
    </style>
    
    <script type="text/javascript"> <!-- Ajax -->
		var xmlHttp;
		
		function getXMLHttpRequest(){
			xmlHttp = new XMLHttpRequest();
		}//getXMLHttpRequest()
		
		function send(){
    		var userid = document.getElementById("id").value;
    	 	getXMLHttpRequest();
    	 	
    	 	xmlHttp.onreadystatechange=xxx; //이벤트 등록(서버가 응답하는 이벤트)
    	 	
    	 	xmlHttp.open("get", "check.jsp?userid="+userid, true);//타겟
    	 	xmlHttp.send(null);
		}//send()
	
	    function xxx(){
	    	if(xmlHttp.readyState==4 && xmlHttp.status==200){
	    		var str = xmlHttp.responseText;
	    			    			    			    		
	    		document.getElementById("result").innerText=str.trim();
	    			
	    			if(document.getElementById("result").innerText=str.trim()=="사용 가능"){
	    			$(document).ready(function(){

	    				$("#result").css("color","blue");
	    				console.log("-----");
	    				console.log(document.getElementById("result").innerText=str.trim());
	    				console.log("-----");
	    			
	    			});		
	    			}else{

		    			$(document).ready(function(){

		    				$("#result").css("color","red");
		    				console.log("-----");	
		    				console.log(document.getElementById("result").innerText=str.trim());
		    				console.log("-----");
		    			
		    			});	    			
		    		}
	    	}//if
	    }//xxx()
	</script>

	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>	<!-- Angular -->
	
	<!-- 입력값 체크 -->	
	<script>
		function resultForm(){
	    	var result = true;
	    	
	    	var name = document.getElementById('name');
	    	var id = document.getElementById('id');
	    	var pwd = document.getElementById('pwd');
	    	var pwd2 = document.getElementById('pwd2');
	    	var tel = document.getElementById('tel');
	    	var answer = document.getElementById('answer');
	    	var addr = document.getElementById('addr');
	    	
	    	if(name.value.length < 1 || name.value.length > 6){
				alert("이름은 2~6자리만 입력해주세요.");
				name.value="";
				name.focus();
				result = false;
			}else if(!name.value.match(/([가-힣])/)){
	    		alert("이름은 한글로 제대로 입력해주세요.");
	    		name.value="";
	    		name.focus();
	    		result = false;
	    	}else if(id.value.length < 10 || id.value.length > 17){
				alert("아이디는 10~16자리로 입력해주세요.");
				id.value="";
				id.focus();
				result = false;
			}else if(!id.value.match(/[a-zA-Z0-9]/)){
				alert("아이디는 문자, 숫자의 조합으로 입력해주세요.");
				id.value="";
				id.focus();
				result = false;
			}else if(pwd.value.length < 8 || pwd.value.length > 12){
				alert("비밀번호는 8~12자리로 입력해주세요.");
				pwd.value="";
				pwd.focus();
				result = false;
			}else if(!pwd.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)){
				alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 입력해주세요.");
				pwd.value="";
				pwd.focus();
				result = false;
			}else if(pwd2.value.length<1){
				alert("비밀번호 확인을 입력해 주세요.");
				pwd2.value="";
				pwd2.focus();
				result = false;
			}else if(pwd.value != pwd2.value){
				alert("입력하신 비밀번호와 비밀번호 확인이 일치하지 않습니다");
				pwd2.value="";
				pwd2.focus();
				result = false;
	    	}else if(tel.value.length < 1){
		        alert("연락처를 입력해주세요.");
		        tel.value="";
				tel.focus();
		        result = false;
		    }else if(tel.value.length < 9 || tel.value.length > 11){
		    	alert("연락처는 9~11자리만 입력가능합니다.");
		        tel.value="";
				tel.focus();
		        result = false;
		    }else if(!tel.value.match(/[0-9]/)){
				alert("연락처는 숫자만 입력가능합니다.");
				tel.value="";
				tel.focus();
				result = false;
			}else if(answer.value.length<1){
		        alert("답변을 입력해 주세요.");
		        result = false;
		    }else if(answer.value.length>20){
		        alert("입력하신 답변이 너무 깁니다.");
		        result = false;
		    }else if(addr.value.length<1){
		        alert("주소을 입력해 주세요.");
		        result = false;
			}
	    	
	    	return result;
	    }//resultForm(joinform)
	</script>

</head>
<body>
    
    <jsp:include page="header.jsp"  flush="true"></jsp:include>       
    
	<div id="joinWrap">
		<div class="content-section">
	        <div class="container">
				<div class="row">
	                <div class="col-md-12 section-title">
	                    <center><h2>회원가입</h2></center>
	                </div>
	                <div align="left">
	                    <div>	<!-- class="contact-form" -->
	                        <form name="contactform" id="contactform" action="JoinAddMember" method="get" onsubmit="return resultForm()">
	                            <p>
	                                <input type="text" id="name" name="name" placeholder="성명 (한글 2~6)" style="height:40px;">                                                    
	                            </p>                          
	                            <p>
	                               	<input style="width:65%; height:40px; float:left;" name="id" type="text" id="id" placeholder="아이디(영문,숫자10~16)" 
	                               			ng-model="id" onkeyup="send()">
	                               	<div style="text-align: center; font-size: medium; line-height: 150%;">
	                               		{{ id }}　<br>
	                               		<span id="result">　</span>
	                               	</div>
	                            </p>
	                            <p>
	                               	<input name="pwd" type="password" id="pwd" placeholder="비밀번호 (영문,숫자,특수문자로 8~12)" style="height:40px;">
	                            </p>
	                            <p>
	                               	<input name="pwd2" type="password" id="pwd2" placeholder="비밀번호확인 (비밀번호와 같게)" style="height:40px;">
	                            </p>
	                            <p>
	                                <select name="gender" id="gender">
	                                	<option value="남자" default>남성</option>
	                                	<option value="여자">여성</option>
	                                </select> 
	                            </p>                                                                                        
	                            <p>
	                               	<input name="tel" type="text" id="tel" placeholder="연락처" style="height:40px;">
	                            </p>                                                                                                                                                                         
	                            <p>
	                                <select name="question" id="question">                                	
	                                	<option value="내가 다녔던 초등학교는?">내가 다녔던 초등학교는?</option>
	                                	<option value="어머니 성함은?">어머니 성함은?</option>
	                                	<option value="아버지 성함은?">아버지 성함은?</option>
	                                </select> 
	                            </p>
	                            <p>
	                                <input name="answer" type="text" id="answer" placeholder="비밀번호 찾기 답" style="height:40px;"> 
	                            </p>                            
	                            <p>
	                                <input type="text" readonly name="post1" id="post1" class="postcodify_postcode5" style="width:35%; height:40px;" > - 
	                                <input type="text" readonly name="post2" id="post2" class="postcodify_postcode5" style="width:35%; height:40px;">
	                                <input type="button" class="mainBtn" value="검색" style="width:19%; height:40px;" onclick="openDaumPostcode()">
									<span id="callbacknestsgroomtistorycom739114"
										style="width: 1px; height: 1px; float: right;"><embed width="1"
											height="1" id="bootstrappersgroomtistorycom739114"
											src="http://sgroom.tistory.com/plugin/CallBack_bootstrapperSrc?nil_profile=tistory&nil_type=copied_post"
											type="application/x-shockwave-flash" swliveconnect="true"
											flashvars="&callbackId=sgroomtistorycom739114&host=http://sgroom.tistory.com&embedCodeSrc=http%3A%2F%2Fsgroom.tistory.com%2Fplugin%2FCallBack_bootstrapper%3F%26src%3D%2F%2Fs1.daumcdn.net%2Fcfs.tistory%2Fresource%2F3771%2Fblog%2Fplugins%2FCallBack%2Fcallback%26id%3D73%26callbackId%3Dsgroomtistorycom739114%26destDocId%3Dcallbacknestsgroomtistorycom739114%26host%3Dhttp%3A%2F%2Fsgroom.tistory.com%26float%3Dleft"
											enablecontextmenu="false" wmode="transparent"
											allowscriptaccess="always"></span>
									<span style="line-height: 10%;"><br></span>
	                            </p>
	                            <p>
	                                <input readonly name="addr1" type="text" id="addr1" placeholder="도로명주소" style="height:40px;"> 
	                            </p>
	                            <p>
	                                <input name="addr2" type="text" id="addr2" placeholder="지번주소" style="height:40px;"> 
	                            </p>                                                        
	                    
	                            <input type="submit" class="mainBtn" id="submit" value="회원가입" style="height:40px;">
	                                                    
	                        </form>
	                    </div>
	                </div> 
	            </div>                  
	        </div>
	    </div>
	    <br><br><br><br>
	    <img src="../images/join/joinus.png" width="60%" height="60%">
	    
    </div> <!-- #joinWrap -->	
   
    <jsp:include page="../include/footer.jsp"></jsp:include>     
</body>
</html>