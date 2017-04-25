<%@page import="com.entity.banWord.BanWordDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.StringTokenizer"%>

<%@page import="com.dao.MySqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	List<BanWordDTO> list = null; // 금지어 목록을 담을 list
	
	String word = "성공"; // 걸린 금지어.
	
	SqlSession sess = MySqlSessionFactory.openSession();
	
	try {
		list = sess.selectList("com.momo.AdminMapper.banWordList");
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		sess.close();
	}
	
	//유저가 입력한 제목, 내용을 스트링토크나이저로 각각 만듬.
	StringTokenizer titleSt = new StringTokenizer(title);
	StringTokenizer contentSt = new StringTokenizer(content);
	
	//금지어 목록만큼 반복문을 돌리고, 제목이랑 내용의 토큰 갯수만큼 또 반복문을 돌려서 하나하나 비교를 함.
	//제목 검사
	while(titleSt.hasMoreTokens()){
		String x = titleSt.nextToken();
		for(BanWordDTO dto : list){
			if(x.equals(dto.getWord())){
				word = "제목에서 \'"+dto.getWord()+"\' 금지어가 사용되어서 글 작성을 할 수 없습니다.";
				break;
			}
		}
	}
	
	//내용 검사
	if(word.equals("성공")){ // 제목에서 금지어가 걸린 게 없다면 실행
		while(contentSt.hasMoreTokens()){
			String y = contentSt.nextToken();
			for(BanWordDTO dto : list){
				if(y.equals(dto.getWord())){
					word = "내용에서 \'"+dto.getWord()+"\' 금지어가 사용되어서 글 작성을 할 수 없습니다.";
					break;
				}
			}
		}
	}
	
	out.print(word);
	
%>