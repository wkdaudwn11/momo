<%@page import="com.entity.member.MemberDTO"%>
<%@page import="com.exception.CommonException"%>
<%@page import="com.entity.freeboard.FreeBoardDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String fnum = request.getParameter("fnum");
	MemberDTO login = (MemberDTO)session.getAttribute("login");	

	SqlSession sess = MySqlSessionFactory.openSession();
	try{
		HashMap<String,String> map = new HashMap<>();
		map.put("fnum",fnum);
		map.put("id",login.getId());
		int result = sess.selectOne("com.momo.BoardMapper.selectRecommendRecord",map);
		
		if(result == 0){
			int	n = sess.update("com.momo.BoardMapper.updateGoodCount",Integer.parseInt(fnum));
			int n2 = sess.insert("com.momo.BoardMapper.insertRecommendRecord",map);
			
			FreeBoardDTO freeBoard = sess.selectOne("com.momo.BoardMapper.freeBoardDetail",Integer.parseInt(fnum));
			sess.commit();

			out.print(freeBoard.getGoodCnt());
		}else{
			out.println("false");
		}
	}finally{
		sess.close();
	}
%>