<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.io.File" %>
<%@page import="java.io.FileWriter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사진 미리보기</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#blah').attr('src', e.target.result);
				$('#blah').show();
			}

			reader.readAsDataURL(input.files[0]);
		}
	}//readURL(input)

	$("#imgInp").on("change", function() {
		readURL(this);
	});
</script>

</head>
<body>

	<form id="form1" runat="server">
		<input type='file' id="imgInp" onchange="readURL(this)" /> 
		<img id="blah" src="#" alt="your image" />
	</form>
	
</body>
</html>