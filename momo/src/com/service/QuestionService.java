package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.question.QuestionDTO;
import com.entity.question.QuestionPage;

public class QuestionService {

	private String name = "com.momo.QuestionMapper.";
	
	/** 문의 게시판 글작성 */
	public void insertQuestion(QuestionDTO question){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			System.out.println(question);
			question.setQnum(totalRecord(null));
			System.out.println(question.getCategory());///////////////////////
			System.out.println(question.getPassword()); //////////////////////////
			session.insert(name+"insertQuestion",question);
			session.commit();
		}finally{
			session.close();
		}
	}// end insertQuestion(QuestionDTO question)
	
	/** 게시판 리스트 개수 가져오는 메서드*/
	private int totalRecord(HashMap<String,String> search){
		SqlSession session = MySqlSessionFactory.openSession();
		int totalRecord = 0;
		try{
			totalRecord = session.selectOne(name+"questionTotalRecord",search);
		}finally{
			session.close();
		}
		return totalRecord;
	}
	
	/** 문의 게시판 리스트 가져오는 메서드*/
	public QuestionPage questionList(HashMap<String,String> search,int curPage){
		SqlSession session = MySqlSessionFactory.openSession();
		QuestionPage questionPage = new QuestionPage();
		int skip = (curPage -1)*questionPage.getPerPage();
		List<QuestionDTO> questionList = null;
		try{
			questionList = session.selectList(name+"questionList",null,new RowBounds(skip,questionPage.getPerPage()));
		}finally{
			session.close();
		}
		questionPage.setQuestionList(questionList);
		questionPage.setCurPage(curPage);
		questionPage.setTotalRecord(totalRecord(search));
		
		return questionPage;
	}
}// end QuestionService
