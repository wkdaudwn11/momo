<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>
<%
	request.setCharacterEncoding("UTF-8");

	String qnum = request.getParameter("qnum");
	SqlSession sess = MySqlSessionFactory.openSession();
	int readCnt = 0;
	try{
		sess.update("com.momo.QuestionMapper.readCntPlus",Integer.parseInt(qnum));
		sess.commit();
		readCnt = sess.selectOne("com.momo.QuestionMapper.getReadCnt",Integer.parseInt(qnum));
	}finally{
		sess.close();
	}
	out.print(readCnt);
%>