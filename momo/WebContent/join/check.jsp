<%@page import="java.util.regex.Pattern"%>
<%@page import="com.dao.MySqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String userid = request.getParameter("userid");
	
	SqlSession sess = MySqlSessionFactory.openSession();
	int result = 0;
	
	try {
		result = sess.selectOne("com.momo.MemberMapper.idCheck", userid);
		
		if(userid.length() == 0){
			result = 3;
		}else if(userid.length() < 6 || userid.length() > 12){
			result = 2;
		}else if(Pattern.matches("^[a-zA-Z]{6,12}$", userid)){
			result = 2;
		}else if(Pattern.matches("^[0-9]{6,12}$", userid)){
			result = 2;
		}else if(!Pattern.matches("^[a-zA-Z0-9]{6,12}$", userid)){
			result = 2;
		}
	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		sess.close();
	}
	
	if (result == 0) {
		out.print("은(는) 사용 가능한 아이디입니다.");
	} else if(result == 1){
		out.print("은(는) 중복되는 아이디입니다.");
	} else if(result == 2){
		out.println("은(는) 사용 불가능한 아이디입니다.");
	}
%>
