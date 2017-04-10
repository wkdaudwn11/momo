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
    	
    	#joinWrap {width:80%; margin:0 auto;}
    	
    	.content-section {width:45%; float: left; padding-right: 40px; }
    	
    	.displayNone {display: none;}
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
	    			if(document.getElementById("result").innerText=str.trim()=="은(는) 사용 가능한 아이디입니다."){
	    				document.getElementById('idCheck').value = "o";
	    				$("#result").css("color","green");
	    			}else if(document.getElementById("result").innerText=str.trim()=="은(는) 중복되는 아이디입니다."){
	    				document.getElementById('idCheck').value = "x";
	    				$("#result").css("color","red");
		    		}
	    			else if(document.getElementById("result").innerText=str.trim()=="은(는) 사용 불가능한 아이디입니다."){
	    				document.getElementById('idCheck').value = "x";
	    				$("#result").css("color","red");
		    		}
	    			document.getElementById("result").innerText=str.trim();
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
	    	var idCheck = document.getElementById('idCheck');
	    	var pwd = document.getElementById('pwd');
	    	var pwd2 = document.getElementById('pwd2');
	    	var tel = document.getElementById('tel');
	    	var answer = document.getElementById('answer');
	    	var addr = document.getElementById('addr1');
	    	var isTelComfirm = document.getElementById('isTelComfirm');
	    	
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
	    	}else if(id.value.length < 6 || id.value.length > 12){
				alert("아이디는 6~12자리로 입력해주세요.");
				id.value="";
				id.focus();
				result = false;
			}else if(!id.value.match(/[a-zA-Z].*[0-9]/)){
				alert("아이디는 문자, 숫자의 조합으로 입력해주세요.");
				id.value="";
				id.focus();
				result = false;
			}else if(idCheck.value == 'x'){
				alert("아이디가 중복됩니다. 다른 아이디를 입력해주세요.");
				id.value="";
				id.focus();
				result = false;
			}else if(pwd.value.length < 6 || pwd.value.length > 12){
				alert("비밀번호는 6~12자리로 입력해주세요.");
				pwd.value="";
				pwd.focus();
				result = false;
			}else if(!pwd.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)){
				alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 입력해주세요.");
				pwd.value="";
				pwd.focus();
				result = false;
			}else if(pwd.value != pwd2.value){
				alert("입력하신 비밀번호와 비밀번호 확인이 일치하지 않습니다");
				pwd2.value="";
				pwd2.focus();
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
			}else if(answer.value.length>20){
		        alert("입력하신 답변이 너무 깁니다.");
		        result = false;
		    }else if(addr.value.length < 1){
		        alert("주소을 입력해 주세요.");
		        result = false;
			}else if(isTelComfirm.value == 'x'){
				alert('인증번호가 틀렸습니다. 다시 입력해주세요.');
				telConfirm.focus();
				telConfirm.value="";
				result = false;
			}else if(isTelComfirm.value == 'no'){
				alert('핸드폰 인증을 하셔야 회원가입을 할 수 있습니다.');
				telConfirm.focus();
				telConfirm.value="";
				result = false;
			}
	    	
	    	return result;
	    }//resultForm(joinform)
	    
	    function confirmNumber(tel){
	    	var telComfirmNumber = 0;
	    	
	    	if(tel.value == null || tel.value == ""){
	    		alert('연락처를 입력해주세요.');
	    		tel.focus();
	    	}else if(tel.value.length < 9 || tel.value.length > 11){
	    		alert('연락처는 9자리 이상 입력하셔야 합니다.');
	    		tel.focus();
	    	}else if(!tel.value.match(/[0-9].*[0-9]/)){
				alert("연락처는 숫자만 입력가능합니다.");
				tel.focus();
			}else{
				if(confirm(tel.value+'(으)로 인증번호를 받으시겠습니까?')){
					$.ajax({
						type:"post",
						url:"randomNumberAjax.jsp",
						dataType:"text",
						data:{
							usertel : tel.value
						},
						success:function(responseData,status,xhr){
							$("#telConfirm").removeClass("displayNone");
							$("#telConfirm").focus();
						},//success
						error:function(error){
							alert('인증번호 불러오기 실패!');
						}//error
					});//ajax
				}//confirm(tel.value+'(으)로 인증번호를 받으시겠습니까?')
			}//tel.value == null || tel.value == ""
	    }//confirmNumber(tel)
	    
	    function telConfirmCheck(telConfirm){
	    	$.ajax({
				type:"post",
				url:"telConfirmAjax.jsp",
				dataType:"text",
				data:{
					inputNum : telConfirm.value
				},
				success:function(responseData,status,xhr){
					if(document.getElementById("telConfrimResult").innerText=responseData.trim()=="인증번호가 일치합니다."){
	    				document.getElementById('isTelComfirm').value = "o";
	    				$("#telConfrimResult").css("color","green");
	    			}else if(document.getElementById("telConfrimResult").innerText=responseData.trim()=="인증번호가 불일치합니다."){
	    				document.getElementById('isTelComfirm').value = "x";
	    				$("#telConfrimResult").css("color","red");
	    			}
					$("#telConfrimResult").text(responseData.trim());
				},//success
				error:function(error){
					alert('인증번호 불러오기 실패!');
				}//error
			});//ajax
	    }//telConfirmCheck(telConfirm)
	    
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
	                        <form name="contactform" id="contactform" action="../JoinAddMember" method="get" onsubmit="return resultForm()">
	                        	<input type="hidden" id="idCheck" value="x">
	                        	<input type="hidden" name="isTelComfirm" id="isTelComfirm" value="no">
	                            <p>
	                                <input type="text" id="name" name="name" maxlength="6" placeholder="성명 (한글)" style="height:40px;" required>                                                    
	                            </p>                          
	                            <p>
	                               	<input name="id" type="text" id="id" maxlength="12" placeholder="아이디 (영문,숫자로 6~12)" 
	                               			ng-model="id" onkeyup="send()" style="height:40px;" required>
	                               	<font color="#13132f" size="3">
	                               		<b>{{id}}</b>
                               			<span id="result"></span>
                               		</font>
	                            </p>
	                            <p>
	                               	<input name="pwd" type="password" id="pwd" maxlength="12" placeholder="비밀번호 (영문,숫자,특수문자로 6~12)" style="height:40px;" required>
	                            </p>
	                            <p>
	                               	<input name="pwd2" type="password" id="pwd2" maxlength="12" placeholder="비밀번호확인 (비밀번호와 같게)" style="height:40px;" required>
	                            </p>
	                            <p>
	                                <select name="gender" id="gender">
	                                	<option value="남자" default>남성</option>
	                                	<option value="여자">여성</option>
	                                </select> 
	                            </p>                                                                                        
	                            <p>
	                               	<input type="text" name="tel" id="tel" maxlength="11" placeholder="연락처" style="height:40px; width: 65%;" required>
	                               	<input type="button" class="mainBtn" value="인증번호 받기" style="width: 33%;" onclick="confirmNumber(tel)">
	                            </p>
	                            <p	id="telConfirmP">
	                               	<input type="text" name="telConfirm" id="telConfirm" class="displayNone" maxlength="6" placeholder="연락처 인증번호 6자리" style="height:40px;"
	                               		onkeyup="telConfirmCheck(telConfirm)" required>
	                               	<font color="#13132f" size="3">
                               			<span id="telConfrimResult"></span>
                               		</font>
	                            </p>
	                            <p>
	                            	<font color=blue size="3">이메일은 필수 입력이 아니므로, 없으시다면 패스하셔도 됩니다.</font> <br />
	                               	<input type="text" name="email1" id="email1" maxlength="15" placeholder="이메일" style="height:40px; width: 48%;">@
	                               	<input type="text" name="email2" id="email2" maxlength="15" style="height:40px; width: 48%;">
	                            </p>                                                                                                                                                                           
	                            <p>
	                                <select name="question" id="question">                                	
	                                	<option value="내가 다녔던 초등학교는?">내가 다녔던 초등학교는?</option>
	                                	<option value="어머니 성함은?">어머니 성함은?</option>
	                                	<option value="아버지 성함은?">아버지 성함은?</option>
	                                </select> 
	                            </p>
	                            <p>
	                                <input name="answer" type="text" id="answer" placeholder="비밀번호 찾기 답" style="height:40px;" required> 
	                            </p>                            
	                            <p>
	                                <input type="text" readonly name="post1" id="post1" class="postcodify_postcode5" style="width:35%; height:40px;"> - 
	                                <input type="text" readonly name="post2" id="post2" class="postcodify_postcode5" style="width:35%; height:40px;">
	                                <input type="button" class="mainBtn" value="검색" style="width:22%" onclick="openDaumPostcode()">
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
	                                <input name="addr1" type="text" id="addr1" placeholder="도로명주소" style="height:40px;" readonly> 
	                            </p>
	                            <p>
	                                <input name="addr2" type="text" id="addr2" placeholder="지번주소" style="height:40px;" readonly> 
	                            </p>                                                        
	                    
	                            <input type="submit" class="mainBtn" id="submit" value="회원가입">
	                                                    
	                        </form>
	                    </div>
	                </div> 
	            </div>                  
	        </div>
	    </div>
	    <br><br><br><br>
	    <img src="../images/join/joinus.png" width="55%">
	    
    </div> <!-- #joinWrap -->	
   
    <jsp:include page="../include/footer.jsp"></jsp:include>     
</body>
</html>