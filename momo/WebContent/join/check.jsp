<%@page import="java.util.regex.Pattern"%>
<%@page import="com.dao.MySqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String userid = request.getParameter("userid");
	
	String able = "사용 가능";
	String disable ="사용 불가";
	
	SqlSession sess = MySqlSessionFactory.openSession();
	int result = 0;
	
	try {
		result = sess.selectOne("com.momo.MemberMapper.idCheck", userid);
		
		if(userid.length() < 10 || userid.length() > 17){
			result = 1;
		}else if(!Pattern.matches("^[a-zA-Z0-9]*$", userid)){
			result = 1;
		}
	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		sess.close();
	}
	
	if (result == 0) {
		out.print(able);
	} else {
		out.print(disable);
	}
%>
