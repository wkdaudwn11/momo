<%@page import="com.entity.myhome.MyHomeDTO"%>
<%@page import="com.exception.RecommendRecordException"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>
<%@page import="com.service.MyHomeService"%>
<%@page import="com.entity.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String hnum = request.getParameter("hnum");
	MemberDTO member = (MemberDTO)session.getAttribute("login");
	
	SqlSession sess = MySqlSessionFactory.openSession();
	MyHomeService service = new MyHomeService();
	
	try{
		HashMap<String,String> map = new HashMap<>();
		map.put("num", hnum);
		map.put("id", member.getId());
		map.put("category","myHome");
	
		int result = sess.selectOne("com.momo.BoardMapper.selectRecommendRecord",map);
		if(result == 0){
			int n = sess.update("com.momo.MyHomeMapper.updateGoodCount",Integer.parseInt(hnum));
			int n2 = sess.insert("com.momo.BoardMapper.insertRecommendRecord",map);
			if(n+n2 == 2){
				sess.commit();
				MyHomeDTO myhome = sess.selectOne("com.momo.MyHomeMapper.detailMyHome",Integer.parseInt(hnum));
				out.print(myhome.getGoodCnt());
			}else{
				sess.rollback();
				throw new RecommendRecordException();
			}
		}else{
			out.print("false");
		}
	}finally{
		sess.close();
	}
	
%>