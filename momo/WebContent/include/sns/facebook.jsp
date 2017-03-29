<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 페북로그인 -->
	<script>
		// 이것은 FB.getLoginStatus()의 결과로 호출됩니다.
		function statusChangeCallback(response) {
	    	/*	응답 객체는 상태 필드와 함께 반환되어 앱은 현재 로그인 상태를 알고 있습니다.
	    		응답 객체에 대한 전체 문서는 FB.getLoginStatus()에서 찾을 수 있습니다.*/
	    	if (response.status === 'connected') {
	    		console.log('페이스북에 정상적으로 로그인 완료했습니다.');
			} else if (response.status === 'not_authorized') {
	    		console.log('페이스북에는 로그인 되어있으나, 앱에는 로그인 되어있지 않다.');
	    	} else {
	    		console.log('페이스북에 로그인이 되어있지 않아서, 앱에 로그인 되어있는지 불명확하다.');
	    	}
		}//statusChangeCallback(response)
	
	  /*이 함수는 누군가 Login으로 끝날 때 호출됩니다. 
	  	단추. 샘플에 첨부 된 onlogin()를 참조하십시오.
	 	아래 코드를 참조하십시오. */
		function checkLoginState() {
	    	FB.getLoginStatus(function(response) {
	      		status = statusChangeCallback(response);
	    	});
	  	}//checkLoginState()
	
		window.fbAsyncInit = function() {
			FB.init({
		    	appId      : '406889729678187', // 사용자 코드
		    	cookie     : true,  // 서버가 액세스 할 수 있도록 쿠키 활성화 
		    	xfbml      : true,  // 이 페이지에서 소셜 플러그인을 분석하십시오.
		    	version    : 'v2.8' // 그래프 API 버전 2.8 사용
		  	});
		
		  /*JavaScript SDK를 초기화 했으므로 이제 FB.getLoginStatus() 이 함수는
		  	이 페이지를 방문한 사람은 다음 세 가지 상태 중 하나를 반환 할 수 있습니다.
		  	당신이 제공하는 콜백. 그들은 할 수있다: */
		  // 1. 앱에 로그인되었습니다 ( '연결됨').
		  // 2. Facebook에 로그인되었지만 앱이 아닌 경우 ( 'not_authorized')
		  // 3. Facebook에 로그인하지 않았고 앱에 로그인했는지 여부를 알 수 없습니다.
		  // 위의 세 가지 경우는 콜백 함수에서 처리됩니다.
		
		  	FB.getLoginStatus(function(response) {
		    	statusChangeCallback(response);
		  	});
	  	};
	
	  	// SDK를 비동기 적으로 로드하십시오.
	  	(function(d, s, id) {
	    	var js, fjs = d.getElementsByTagName(s)[0];
	    	
	    	if (d.getElementById(id)){ 
	    		return;
	    	}
	    	
	    	js = d.createElement(s); js.id = id;
	    	js.src = "//connect.facebook.net/en_US/sdk.js";
	    	fjs.parentNode.insertBefore(js, fjs);
	  	}(document, 'script', 'facebook-jssdk'));
	  	
	   /*여기에 로그인 후 Graph API에 대한 간단한 테스트가 실행됩니다.
		성공한. 이 호출이 발생하면 statusChangeCallback ()을 참조하십시오. */
		function loginFB() {
			FB.login(function(responseL) {
				// 로그인이 완료된 다음
				FB.api('/me', function(response) {
					var id = response.id;
		      		var name = response.name;
		      		
		      		if(name != undefined){
		      			var loginForm = document.getElementById('loginForm');
		      			loginForm.action="SNSLoginServlet?id="+id+"&name="+name+"&sns=facebook";
		      			loginForm.submit();
		      		}
				});
			});
		}
	   
		function logoutFB() {
			FB.logout();
		}
	</script>