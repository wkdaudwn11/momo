package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.bedRoom.BedRoomDTO;
import com.entity.bedRoom.BedRoomPageDTO;
import com.exception.CommonException;

public class BedRoomService {

	String namespace = "com.momo.BedRoomMapper.";
	
	/**각 분류의 상품을 보여주는 메소드*/
	public BedRoomPageDTO bedRoomList(int curPage, HashMap<String, String> map, String sortValue) throws CommonException{
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		BedRoomPageDTO bedRoomPageDTO = new BedRoomPageDTO();
		int skip = (curPage-1) * bedRoomPageDTO.getPerPage();
		List<BedRoomDTO> bedRoomList = null;
		
		try{
			if(sortValue.equals("bnum")){ // 최신순 
				bedRoomList = session.selectList(namespace+"bedRoomListBnumDesc", map, new RowBounds(skip,bedRoomPageDTO.getPerPage()));
  			}else if(sortValue.equals("priceAsc")){ // 가격 낮은순
				bedRoomList = session.selectList(namespace+"bedRoomListPriceAsc", map, new RowBounds(skip,bedRoomPageDTO.getPerPage()));
			}else if(sortValue.equals("priceDesc")){ // 가격 높은순
				bedRoomList = session.selectList(namespace+"bedRoomListPriceDesc", map, new RowBounds(skip,bedRoomPageDTO.getPerPage()));
			}else if(sortValue.equals("buyCountDesc")){ // 판매 인기순
				bedRoomList = session.selectList(namespace+"bedRoomListBuyCountDesc", map, new RowBounds(skip,bedRoomPageDTO.getPerPage()));
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		bedRoomPageDTO.setBedRoomList(bedRoomList);
		bedRoomPageDTO.setCurPage(curPage);
		bedRoomPageDTO.setTotalRecord(totalRecord(map));
		
		
		return bedRoomPageDTO;
	}//bedRoomList(int curPage, HashMap<String, String> map, String sortValue)
	
	/** 인기상품 세 개를 반환해주는 메소드 */
	public BedRoomPageDTO bestBedRoomList() throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		BedRoomPageDTO bedRoomPageDTO = new BedRoomPageDTO();
		List<BedRoomDTO> bedRoomList = null;
		
		try{
			bedRoomList = session.selectList(namespace+"bestBedRoomList");
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		bedRoomPageDTO.setBedRoomList(bedRoomList);
		
		return bedRoomPageDTO;
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

	/** 해당 상품(bnum)의 정보를 반환해주는 메소드 */
	public BedRoomDTO bedRoomDetail(int bnum) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		BedRoomDTO dto = null;
		
		try{
			dto = session.selectOne(namespace+"bedRoomDetail", bnum);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		return dto;
	}
	
}
