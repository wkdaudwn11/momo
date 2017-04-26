<%@page import="com.dao.MySqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String bnum = request.getParameter("bnum");
	
	SqlSession sess = MySqlSessionFactory.openSession();
	int result = 0;
	
	try {
		result = sess.delete("com.momo.AdminMapper.productDelete", bnum);
		sess.commit();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		sess.close();
	}
	
	if (result == 0) {
		out.print("삭제 실패!");
	} else if(result > 0){
		out.print("삭제 성공!");
	} 
%>
