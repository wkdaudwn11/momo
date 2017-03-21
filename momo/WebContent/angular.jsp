<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app>
  <head>
    <title>앵귤러</title>
    <!--cdn을 이용할경우 위의 스크립트 태그를 지우고 아래를 붙여넣으면 됩니다. -->
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>
  </head>
  <body>
  	<form>
	    <input type="text" ng-model="x"><br>
	    <span>{{ x }}</span>
    </form>
  </body>
</html>