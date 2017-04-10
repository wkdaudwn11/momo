package com.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.myhome.MyHomeDTO;
import com.entity.myhome.MyHomePage;

public class MyHomeService{

	private final String name = "com.momo.MyHomeMapper.";
	
	/** 수정  메서드 */
	public void myHomeUpdate(MyHomeDTO myHomeDTO){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			session.update(name+"myHomeUpdate",myHomeDTO);
			session.commit();
		}finally{
			session.close();
		}
	}// end myHomeUpdate(MyHomeDTO myHomeDTO)
	
	/** 삭제 하는 메서드 */
	public void myHomeDelete(int hnum){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			session.delete(name+"myHomeDelete",hnum);
			session.commit();
		}finally{
			session.close();
		}
	}// end myHomeDelete(int hnum)
	
	/** 조회수 올려주는 메서드 */
	private void readCntPlus(int hnum){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			session.update(name+"readCntPlus",hnum);
			session.commit();
		}finally{
			session.close();
		}
	}// end void readCntPlus(int hnum)
	
	/** 상세보기 */
	public MyHomeDTO detailMyHome(int hnum){
		SqlSession session = MySqlSessionFactory.openSession();
		MyHomeDTO myHomeDTO = null;
		try{
			myHomeDTO = session.selectOne(name+"detailMyHome",hnum);
			readCntPlus(hnum);
		}finally{
			session.close();
		}
		return myHomeDTO;
	} // end MyHomeDTO detailMyHome(int hnum)
	
	/** myHome 테이블에 레코드 추가하는 메서드 */
	public void myHomeInsert(MyHomeDTO myHomeDTO){
		SqlSession session  = MySqlSessionFactory.openSession();
		try{
			session.insert(name+"myHomeInsert",myHomeDTO);
			session.commit();
		}finally{
			session.close();
		}
	}// end   InsertMyHome(MyHomeDTO myHomeDTO)
	
	/** 리스트 개수 가져오는 메서드 */
	private int totalRecord(){
		SqlSession session = MySqlSessionFactory.openSession();
		int totalRecord;
		try{
			totalRecord = session.selectOne(name+"totalRecord",null);
		}finally{
			session.close();
		}
		return totalRecord;
	} // end  totalRecord()
	
	/** 페이지 리스트 가져오는 메서드 */
	public MyHomePage myHomeList(int curPage){
		SqlSession session = MySqlSessionFactory.openSession();
		MyHomePage pageDTO = new MyHomePage();
		int skip = (curPage -1)*pageDTO.getPerPage();
		List<MyHomeDTO> myHomeList = null;
		try{
			myHomeList = session.selectList(name+"myHomeList",null,new RowBounds(skip,pageDTO.getPerPage()));
		}finally{
			session.close();
		}
		pageDTO.setMyHomeList(myHomeList);
		pageDTO.setCurPage(curPage);
		pageDTO.setTotalRecord(totalRecord());
		
		return pageDTO;
	}// end myHomeList(int curPage)
}// end MyHomeService
