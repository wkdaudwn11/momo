package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.member.MemberDTO;
import com.entity.question.QuestionDTO;
import com.entity.question.QuestionPage;
import com.exception.AccessWrongException;

public class QuestionService {

	private String name = "com.momo.QuestionMapper.";
	
	/** 게시글 1개 가져오는 쿼리
	 * @throws AccessWrongException */
	public QuestionDTO questionDetail(int qnum,MemberDTO member) throws AccessWrongException{
		SqlSession session = MySqlSessionFactory.openSession();
		QuestionDTO question = null;
		try{
			question = session.selectOne(name+"questionDetail",qnum);
			if(member == null || question.getId().equals(member.getId()) == false && member.getId() != "admin"){
				throw new AccessWrongException();
			}
		}finally{
			session.close();
		}
		return question;
	}// end   questionDetail(int qnum)
	
	/** 게시글 수정
	 * @throws AccessWrongException */
	public void updateQuestion(QuestionDTO question,MemberDTO member) throws AccessWrongException{
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			if(member == null || member.getId().equals(question.getId()) == false && member.getId().equals("admin")==false){
				throw new AccessWrongException();
			}else{
				session.update(name+"questionUpdate",question);
				if(question.getQlevel() == 0 ){
					session.update(name+"repleUpdate",question);
				}
				session.commit();
			}
		}finally{
			session.close();
		}
		
	}// end UpdateQuestion(int qnum,MemberDTO member)
	
	
	
	/** 문의 게시판 글 삭제
	 * @throws AccessWrongException */
	public void deleteQuestion(int qnum,MemberDTO member) throws AccessWrongException{
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			QuestionDTO question = session.selectOne(name+"questionDetail",qnum);
			if(member == null || member.getId().equals(question.getId()) == false && member.getId().equals("admin")==false){
				throw new AccessWrongException();
			}
			session.delete(name+"deleteQuestion",qnum);
			session.commit();
		}finally{
			session.close();
		}
	}// end deleteQuestion(int qnum)
	
	/** 문의 게시판 글작성 */
	public void insertQuestion(QuestionDTO question){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			System.out.println(question.getQnum());////////////////////////////////////////////
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
