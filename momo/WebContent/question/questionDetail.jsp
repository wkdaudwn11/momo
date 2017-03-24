<%@page import="com.entity.question.QuestionDTO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>
<%
	request.setCharacterEncoding("UTF-8");
	String qnum = request.getParameter("qnum");
	String password = request.getParameter("password");
	
	SqlSession sess = MySqlSessionFactory.openSession();
	QuestionDTO questionDTO = null;
	try{
		questionDTO = sess.selectOne("com.momo.QuestionMapper.questionDetail",Integer.parseInt(qnum));
		if(questionDTO.getPassword().equals(password)){
			out.println(questionDTO.getContent());
		}else{ out.println("thraw");}
	}finally{
		sess.close();
	}
%>