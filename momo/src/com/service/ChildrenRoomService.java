package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.childrenRoom.ChildrenRoomDTO;
import com.entity.childrenRoom.ChildrenRoomPageDTO;
import com.exception.CommonException;

public class ChildrenRoomService {

	String namespace = "com.momo.ChildrenRoomMapper.";
	
	/**각 분류의 상품을 보여주는 메소드*/
	public ChildrenRoomPageDTO childrenRoomList(int curPage, HashMap<String, String> map, String sortValue) throws CommonException{
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		ChildrenRoomPageDTO childrenRoomPageDTO = new ChildrenRoomPageDTO();
		int skip = (curPage-1) * childrenRoomPageDTO.getPerPage();
		List<ChildrenRoomDTO> childrenRoomList = null;
		
		try{
			if(sortValue.equals("cnum")){ // 최신순 
				childrenRoomList = session.selectList(namespace+"childrenRoomListcnumDesc", map, new RowBounds(skip,childrenRoomPageDTO.getPerPage()));
  			}else if(sortValue.equals("priceAsc")){ // 가격 낮은순
  				childrenRoomList = session.selectList(namespace+"childrenRoomListPriceAsc", map, new RowBounds(skip,childrenRoomPageDTO.getPerPage()));
			}else if(sortValue.equals("priceDesc")){ // 가격 높은순
				childrenRoomList = session.selectList(namespace+"childrenRoomListPriceDesc", map, new RowBounds(skip,childrenRoomPageDTO.getPerPage()));
			}else if(sortValue.equals("buyCountDesc")){ // 판매 인기순
				childrenRoomList = session.selectList(namespace+"childrenRoomListBuyCountDesc", map, new RowBounds(skip,childrenRoomPageDTO.getPerPage()));
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		childrenRoomPageDTO.setChildrenRoomList(childrenRoomList);
		childrenRoomPageDTO.setCurPage(curPage);
		childrenRoomPageDTO.setTotalRecord(totalRecord(map));
		
		return childrenRoomPageDTO;
	}//childrenRoomList(int curPage, HashMap<String, String> map, String sortValue)
	
	/** 인기상품 세 개를 반환해주는 메소드 */
	public ChildrenRoomPageDTO bestChildrenRoomList() throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		ChildrenRoomPageDTO childrenRoomPageDTO = new ChildrenRoomPageDTO();
		List<ChildrenRoomDTO> childrenRoomList = null;
		
		try{
			childrenRoomList = session.selectList(namespace+"bestChildrenRoomList");
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		childrenRoomPageDTO.setChildrenRoomList(childrenRoomList);
		
		return childrenRoomPageDTO;
	}//bestChildrneRoomList()
	
	/** 각 분류의 전체 상품 갯수를 반환해주는 메소드. */
	private int totalRecord(HashMap<String, String> map) {
		
		SqlSession session = MySqlSessionFactory.openSession();
		int count = -1;
		
		try{
			if(map.get("category").equals("0")){
				count = session.selectOne(namespace+"totalRecordAll");
			}else{
				count = session.selectOne(namespace+"totalRecord", map);
			}
		}catch(Exception e){
			
		}finally{
			session.close();
		}
		
		return count;
	}//totalRecord(HashMap<String, String> map)

	/**모든 분류의 상품을 갯수를 반환해주는 메소드*/
	public int listAllCount(){
		SqlSession session = MySqlSessionFactory.openSession();
		int count = 0;
		try{
			count = session.selectOne(namespace+"listAllCount");
		}finally{
			session.close();
		}
		return count;
	}//listAllCount()

	/** 해당 상품(cnum)의 정보를 반환해주는 메소드 */
	public ChildrenRoomDTO childrenRoomDetail(int cnum) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		ChildrenRoomDTO dto = null;
		
		try{
			dto = session.selectOne(namespace+"childrenRoomDetail", cnum);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		return dto;
	}
	
}
