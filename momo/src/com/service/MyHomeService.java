package com.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.myhome.MyHomeDTO;
import com.entity.order.OrderDTO;

public class MyHomeService{

	private final String name = "com.momo.MyHomeMapper.";
	private final int perPage = 9;
	
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
	public HashMap<String,Object> detailMyHome(int hnum){
		SqlSession session = MySqlSessionFactory.openSession();
		MyHomeDTO myHomeDTO = null;
		HashMap<String,Object> map = new HashMap<>();
		List<OrderDTO> orderList = null;
		try{
			myHomeDTO = session.selectOne(name+"detailMyHome",hnum);
			orderList = session.selectList("com.momo.OrderMapper.detailOrderList",myHomeDTO.getOrderList().split(","));
			
			map.put("MyHomeDTO", myHomeDTO);
			map.put("orderList", orderList);
		}finally{
			session.close();
		}
		return map;
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
	
	/** 베스트 리스트 가져오는 메서드 (추천스/조회수) 조회수 10 이상*/
	public List<MyHomeDTO> bestMyHomeList(int limit){
		SqlSession session = MySqlSessionFactory.openSession();
		List<MyHomeDTO> bestMyHomeList = null;
		try{
			bestMyHomeList = session.selectList(name+"bestList",null,new RowBounds(0,limit));
		}finally{
			session.close();
		}
		
		return bestMyHomeList;
	}
	
	
	/** 페이지 리스트 가져오는 메서드 */
	public List<MyHomeDTO> myHomeList(int curPage){
		SqlSession session = MySqlSessionFactory.openSession();
		List<MyHomeDTO> myHomeList = null;
		try{
			myHomeList = session.selectList(name+"myHomeList",null,new RowBounds(0,curPage*perPage));
			
		}finally{
			session.close();
		}
		return myHomeList;
	}// end myHomeList(int curPage)
	
	/** 추가할  리스트 가져오는 메서드 */
	public List<MyHomeDTO> addList(int curPage){
		int skip = (curPage -1)*perPage;
		SqlSession session = MySqlSessionFactory.openSession();
		List<MyHomeDTO> myHomeList = null;
		try{
			myHomeList = session.selectList(name+"myHomeList",null,new RowBounds(skip,perPage));
		}finally{
			session.close();
		}
		return myHomeList;
	}// end myHomeList(int curPage)
}// end MyHomeService
