<%@page import="com.dao.MySqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%
    	System.out.println("idCheck");

    	String userid = request.getParameter("userid");
    	
    	System.out.println("idcheck.jsp.userid: "+userid);
    	
    	SqlSession sess = MySqlSessionFactory.openSession();
    	int result = 0;
    	
    	try {
    		result = sess.selectOne("com.momo.MemberMapper.idCheck", userid);
    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally {
    		sess.close();
    	}
    	
    	System.out.println("result:" + result);
    	
    	if (result == 0) {
   	 		out.print(" zzzz사용 가능!");
    	} else {
    		out.print(" zzzz사용 불가능!");
    	}
    %>