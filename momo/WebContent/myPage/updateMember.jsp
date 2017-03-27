<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html class="no-js" ng-app> <!--<![endif]-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원정보수정</title>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	
	<!-- DAUM 주소 라이브러리 시작 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="js/daum.js"></script>
	<!-- DAUM 주소 라이브러리 끝 -->

    <style>
    	button, select {padding : 12px 15px; width : 100%;}
    	
    	button {background : #000000;}    
    		
    	.postcodify_controls{background : #000000;} 
    	
    	.search_button{padding : 0px 0px;}
    	
    	.close_button{padding : 0px 0px;}
    	
    	#insert_img{width:730px; height:779px; margin-top:10px; margin-left:30px;}
    	
    	#joinWrap {width:70%; margin:0 auto;}
    	
    	.content-section {width:40%; float: left; padding-right: 40px;}
    </style>
    
    <script type="text/javascript">
		 function resultForm(){
	    	var result = true;
	    	var pwd = document.getElementById('pwd');
	    	var pwd2 = document.getElementById('pwd2');
	    	var tel = document.getElementById('tel');
	    	var answer = document.getElementById('answer');
	    	var addr = document.getElementById('addr');
	    	
	    	if(pwd.value.length < 8 || pwd.value.length > 12){
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

	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>

</head>
<body>
    <jsp:include page="../include/header.jsp"  flush="true"></jsp:include>       
    
	<div id="joinWrap">
		<div class="content-section">
	        <div class="container">
				<div class="row">
	                <div class="col-md-12 section-title">
	                    <center><h2>회원정보수정</h2></center>
	                </div> <!-- /.section -->
	                
	                <div align="left">
	                    <div>	<!-- class="contact-form" -->
	                        <form method="post" action="UpdateMemberServlet" name="contactform" id="contactform" onsubmit="return resultForm()">
	                            <p>
	                                <input name="name" type="text" id="name" value="${myPage.name }" style="height:40px; border-color:#d2d2d2; background-color:#e5e5e5;" onfocus="javascript:blur();	">                                                    
	                            </p>                          
	                            <p>
	                               	<input style="height:40px; border-color:#d2d2d2; background-color:#e5e5e5;" name="id" type="text" id="id" value="${myPage.id }"  onfocus="javascript:blur();" >
	                            </p>
	                            <p>
	                               	<input name="pwd" type="password" id="pwd"  style="height:40px;" value="${myPage.pwd }">
	                            </p>
	                            <p>
	                               	<input name="pwd2" type="password" id="pwd2" value="${myPage.pwd2 }" style="height:40px;" >
	                            </p>
	                            <p>
	                                <select name="gender" id="gender" value ="${myPage.gender}" disabled="disabled" style="border-color:#d2d2d2; background-color:#e5e5e5;">
	                                	<option value="남자" default>남성</option>
	                                	<option value="여자">여성</option>
	                                </select> 
	                            </p>                                                                                        
	                            <p>
	                               	<input name="tel" type="text" id="tel" value="${myPage.tel}" style="height:40px;">
	                            </p>                                                                                                                                                                         
	                            <p>
	                                <select name="question" id="question">                                	
	                                	<option value="내가 다녔던 초등학교는?">내가 다녔던 초등학교는?</option>
	                                	<option value="어머니 성함은?">어머니 성함은?</option>
	                                	<option value="아버지 성함은?">아버지 성함은?</option>
	                                </select> 
	                            </p>
	                            <p>
	                                <input name="answer" type="text" id="answer" value="${myPage.answer }" style="height:40px;"> 
	                            </p>                            
	                            <p>
	                                <input type="text" readonly name="post1" id="post1"  value="${myPage.post1}"  class="postcodify_postcode5" style="width:35%; height:40px;" > - 
	                                <input type="text" readonly name="post2" id="post2"  value="${myPage.post2}" class="postcodify_postcode5" style="width:35%; height:40px;">
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
	                                <input readonly name="addr1" type="text" id="addr1" value="${myPage.addr1}" placeholder="도로명주소" style="height:40px;"> 
	                            </p>
	                            <p>
	                                <input name="addr2" type="text" id="addr2" value="${myPage.addr2}"  placeholder="지번주소" style="height:40px;"> 
	                            </p>                                                        
	                    
	                            <input type="submit" class="mainBtn" id="submit" value="정보수정" style="height:40px;">
	                                                    
	                        </form>
	                    </div> <!-- /.contact-form -->
	                </div> 
	            </div>                  
	        </div> <!-- /.container -->
	    </div> <!-- /.content-section -->
	    <br><br><br><br><br>
	    <img src="http://localhost:8090/momo/images/myPage/update.png" width="60%" height="60%">
	    
    </div> <!-- #joinWrap -->	
   
    <jsp:include page="../include/footer.jsp"></jsp:include>     
</body>
</html>