<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type='text/javascript'>

	//<![CDATA[
	// 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('52c7a2908466f7b1babc402d0c1891d8');
	
	// 카카오 로그인 버튼을 생성합니다.
	Kakao.Auth.createLoginButton({
		container : '#kakao-login-btn',
		success : function(authObj) {
				// 로그인완료.
				Kakao.API.request({
						url: '/v1/user/me',
						success: function(res) {
							Kakao.Auth.logout(
								function(res){
									if(res==true){
										_getStatus();
									}
								}		
							);
							
							var loginForm = document.getElementById('loginForm');
				      		loginForm.action="SNSLoginServlet?id="+res.id+"&name="+res.properties.nickname+"&sns=kakaotalk";
				      		loginForm.submit();
						},
						fail: function(error) {
							alert('정보를 불러 올 수 없습니다.');
						}
					});
		},
		fail : function(err) {
			alert('카카오톡 서버와 연결 할 수 없습니다.');
		}
	});
	//]]>
	
	function kakaoLogOut(){
		Kakao.Auth.logout();
		Kakao.cleanup();
	}
	
</script>
