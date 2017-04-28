<%@page import="com.exception.LoginFailException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setContentType("text/event-stream;charset=UTF-8"); 
 
	response.setHeader("Cache-Control","no-cache"); 

	response.setHeader("Connection","keep-alive");  // 연결을 계속 유지한다는 설정.
	
	if(session.getAttribute("login") == null){
		out.print("data:fail\n\n");
	}
%>