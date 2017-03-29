<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(document).ready(function(event){
		
		var id = '${sessionScope.login.id}';
		
		var iconDataURI = "images/notification/momo.jpg";	//notification의 프로필 사진?
		var notificationTitle = '${notificationTitle}';		//제목
		var notificationMessage = '${notificationMessage}';	//내용
		var notificationID = '${notificationID}';	//게시판 글 작성자의 아이디
		
		//notificationTitle에 값이 존재하면 notification을 띄어준다.
		if(notificationTitle != ""){
		    if(notificationID == ""){	// 게시글이 아닐 경우
		    	var options = {
			        body: notificationMessage,
			        icon: iconDataURI
			    }
			     
			    //데스크탑 알림 요청
			    var notification = new Notification(notificationTitle, options);
			     
			    //알림 후 5초 뒤 사라짐
			    setTimeout(function () {
			        notification.close();
			    }, 5000);
		    }else if(notificationID != ""){
		    	if(id == notificationID){
		    		var options = {
				        body: notificationMessage,
				        icon: iconDataURI
				    }
				     
				    //데스크탑 알림 요청
				    var notification = new Notification(notificationTitle, options);
				     
				    //알림 후 5초 뒤 사라짐
				    setTimeout(function () {
				        notification.close();
				    }, 5000);
		    	}
		    }
		}
		//});
	});
</script>