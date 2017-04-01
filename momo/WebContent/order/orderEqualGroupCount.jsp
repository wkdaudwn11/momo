<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.order.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>

<%
	request.setCharacterEncoding("UTF-8");

	System.out.println("orderEqualGroupCount.jsp 입장");

	String groupnum = request.getParameter("groupnum");
	
	SqlSession sess = MySqlSessionFactory.openSession();
	int count = 0;
	try{
		count = sess.selectOne("com.momo.OrderMapper.orderEqualGroupCount",Integer.parseInt(groupnum));
		
		out.println(count);
		
	}finally{
		sess.close();
	}
%>