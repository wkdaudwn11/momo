<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.order.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>

<%
	request.setCharacterEncoding("UTF-8");

	String inputNum = request.getParameter("inputNum");
	
	HttpSession session123 = request.getSession();
	String confirmNumber = (String)session123.getAttribute("confirmNumber");
	
	if(inputNum.equals(confirmNumber)){
		out.print("인증번호가 일치합니다.");
	}else if(inputNum.equals("")){
		out.print("");
	}else{
		out.print("인증번호가 불일치합니다.");
	}
%>