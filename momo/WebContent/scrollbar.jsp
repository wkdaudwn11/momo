<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example123123</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css_momo/bootstrap.min.css">
  <script src="js/jquery-1.12.2.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
</head>
<body>

<c:set var="mj" value="20" />
${mj}
<%String mj2 = "80"; %>

<div class="container">
  <h2>Basic Progress Bar</h2>
  <div class="progress">
    <div class="progress-bar" role="progressbar" aria-valuenow="${mj}" aria-valuemin="0" aria-valuemax="100" style="width:${mj}%">
      <span class="sr-only">70% Complete</span>
    </div>
  </div>
</div>

</body>
</html>