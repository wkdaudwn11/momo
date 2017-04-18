<%@page import="java.util.HashMap"%>
<%@page import="com.entity.member.MemberDTO"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.dao.MySqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	HashMap<String, String> map = new HashMap<>();
	map.put("id", id);
	map.put("pwd", pwd);
	
	SqlSession sess = MySqlSessionFactory.openSession();
	MemberDTO result = null;
	
	try {
		result = sess.selectOne("com.momo.MemberMapper.loginCheck", map);
	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		sess.close();
	}
	
	if (result != null) {
		out.print("성공");
	} else if(result == null){
		out.print("실패");
	} else {
		out.println("에러");
	}
%>
