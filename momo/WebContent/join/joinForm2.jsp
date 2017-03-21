<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" ng-app> <!--<![endif]-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원가입</title>
	
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
    	//Ajax 시작
		var xmlHttp;
		
		function getXMLHttpRequest(){
			xmlHttp = new XMLHttpRequest();
		}//getXMLHttpRequest()
		
		function send(){
    		var userid = document.getElementById("id").value;
    		//alert(userid);
    	 	getXMLHttpRequest();
    	 	
    	 	xmlHttp.onreadystatechange=xxx; //이벤트 등록(서버가 응답하는 이벤트)
    	 	
    	 	xmlHttp.open("get", "check.jsp?userid="+userid, true);//타겟
    	 	xmlHttp.send(null);
		}//end send
	
	    function xxx(){
	    	if(xmlHttp.readyState==4 && xmlHttp.status==200){
	    		var str = xmlHttp.responseText;
	    		document.getElementById("result").innerText=str.trim();
	    	}//end 
	    }//end xxx
		//Ajax 끝
		
		function result(){
	    	
	    }
		
	</script>

	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>

</head>
<body>
    <!--[if lt IE 7]>
    <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
    <![endif]-->
    
    <jsp:include page="../include/header.jsp"  flush="true"></jsp:include>       
    
	<div id="joinWrap">
		<div class="content-section">    <!-- class="content-section" -->
	        <div class="container">	<!-- class="container" -->
				<div class="row">	<!-- class="row" -->
	                <div class="col-md-12 section-title">
	                    <center><h2>회원가입</h2></center>
	                </div> <!-- /.section -->
	                <div align="left"> <!-- class="col-md-5 col-sm-6" -->
	                    <div>	<!-- class="contact-form" -->
	                        <form name="contactform" id="contactform" action="JoinAddMember" method="get">
	                            <p>
	                                <input name="name" type="text" id="name" placeholder="성명" style="height:40px;">                                                    
	                            </p>                          
	                            <p>
	                               	<input style="width:65%; height:40px; float:left;" name="id" type="text" id="id" placeholder="아이디" 
	                               			ng-model="id" onkeyup="send()">
	                               	<div style="text-align: center; font-size: medium; line-height: 150%;">
	                               		{{ id }}　<br>
	                               		<span id="result">　</span>
	                               	</div>
	                            </p>
	                            <p>
	                               	<input name="pwd" type="password" id="pwd" placeholder="비밀번호" style="height:40px;">
	                            </p>
	                            <p>
	                               	<input name="pwd2" type="password" id="pwd2" placeholder="비밀번호확인" style="height:40px;">
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
	                    </div> <!-- /.contact-form -->
	                </div> 
	            </div>                  
	        </div> <!-- /.container -->
	    </div> <!-- /.content-section -->
	    <br><br><br><br><br>
	    <img src="http://localhost:8090/momo/images/join/joinus.png" width="60%" height="60%">
	    
    </div> <!-- #joinWrap -->	
   
    <jsp:include page="../include/footer.jsp"></jsp:include>     
</body>
</html>