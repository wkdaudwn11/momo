package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.bedRoom.BedRoomDTO;
import com.entity.livingRoom.LivingRoomDTO;
import com.entity.livingRoom.LivingRoomPageDTO;
import com.exception.CommonException;

public class LivingRoomService {

	String namespace = "com.momo.LivingRoomMapper.";
	
	/**각 분류의 상품을 보여주는 메소드*/
	public LivingRoomPageDTO livingRoomList(int curPage, HashMap<String, String> map, String sortValue) throws CommonException{
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		LivingRoomPageDTO livingRoomPageDTO = new LivingRoomPageDTO();
		int skip = (curPage-1) * livingRoomPageDTO.getPerPage();
		List<LivingRoomDTO> livingRoomList = null;
		
		try{
			if(sortValue.equals("lnum")){ // 최신순 
				livingRoomList = session.selectList(namespace+"livingRoomListLnumDesc", map, new RowBounds(skip,livingRoomPageDTO.getPerPage()));
  			}else if(sortValue.equals("priceAsc")){ // 가격 낮은순
				livingRoomList = session.selectList(namespace+"livingRoomListPriceAsc", map, new RowBounds(skip,livingRoomPageDTO.getPerPage()));
			}else if(sortValue.equals("priceDesc")){ // 가격 높은순
				livingRoomList = session.selectList(namespace+"livingRoomListPriceDesc", map, new RowBounds(skip,livingRoomPageDTO.getPerPage()));
			}else if(sortValue.equals("buyCountDesc")){ // 판매 인기순
				livingRoomList = session.selectList(namespace+"livingRoomListBuyCountDesc", map, new RowBounds(skip,livingRoomPageDTO.getPerPage()));
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		livingRoomPageDTO.setLivingRoomList(livingRoomList);
		livingRoomPageDTO.setCurPage(curPage);
		livingRoomPageDTO.setTotalRecord(totalRecord(map));
		
		
		return livingRoomPageDTO;
	}//bedRoomList(int curPage, HashMap<String, String> map, String sortValue)
	
	/** 인기상품 세 개를 반환해주는 메소드 */
	public LivingRoomPageDTO bestLivingRoomList() throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		LivingRoomPageDTO livingRoomPageDTO = new LivingRoomPageDTO();
		List<LivingRoomDTO> livingRoomList = null;
		
		try{
			livingRoomList = session.selectList(namespace+"bestLivingRoomList");
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		livingRoomPageDTO.setLivingRoomList(livingRoomList);
		
		return livingRoomPageDTO;
	}//bestBedRoomList()
	
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

	/** 해당 상품(lnum)의 정보를 반환해주는 메소드 */
	public LivingRoomDTO livingRoomDetail(int lnum) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		LivingRoomDTO dto = null;
		
		try{
			dto = session.selectOne(namespace+"livingRoomDetail", lnum);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		return dto;
	}
	
}
