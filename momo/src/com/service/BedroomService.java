package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.bedroom.BedroomDTO;
import com.entity.bedroom.BedroomPageDTO;
import com.exception.CommonException;

public class BedroomService {

	String namespace = "com.momo.BedroomMapper.";
	
	/**각 분류의 상품을 보여주는 메소드*/
	public BedroomPageDTO bedroomList(int curPage, HashMap<String, String> map, String sortValue) throws CommonException{
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		BedroomPageDTO bedroomPageDTO = new BedroomPageDTO();
		int skip = (curPage-1) * bedroomPageDTO.getPerPage();
		List<BedroomDTO> bedroomList = null;
		
		try{
			if(sortValue.equals("bnum")){ // 최신순 
				bedroomList = session.selectList(namespace+"bedroomListBnumDesc", map, new RowBounds(skip,bedroomPageDTO.getPerPage()));
  			}else if(sortValue.equals("priceAsc")){ // 가격 낮은순
				bedroomList = session.selectList(namespace+"bedroomListPriceAsc", map, new RowBounds(skip,bedroomPageDTO.getPerPage()));
			}else if(sortValue.equals("priceDesc")){ // 가격 높은순
				bedroomList = session.selectList(namespace+"bedroomListPriceDesc", map, new RowBounds(skip,bedroomPageDTO.getPerPage()));
			}else if(sortValue.equals("buyCountDesc")){ // 판매 인기순
				bedroomList = session.selectList(namespace+"bedroomListBuyCountDesc", map, new RowBounds(skip,bedroomPageDTO.getPerPage()));
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		bedroomPageDTO.setBedroomList(bedroomList);
		bedroomPageDTO.setCurPage(curPage);
		bedroomPageDTO.setTotalRecord(totalRecord(map));
		
		
		return bedroomPageDTO;
	}//bedroomList(int curPage, HashMap<String, String> map, String sortValue)
	
	/** 인기상품 세 개를 반환해주는 메소드 */
	public BedroomPageDTO bestBedroomList() throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		BedroomPageDTO bedroomPageDTO = new BedroomPageDTO();
		List<BedroomDTO> bedroomList = null;
		
		try{
			bedroomList = session.selectList(namespace+"bestBedroomList");
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		bedroomPageDTO.setBedroomList(bedroomList);
		
		return bedroomPageDTO;
	}//bestBedroomList()
	
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
	public BedroomDTO bedroomDetail(int bnum) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		BedroomDTO dto = null;
		
		try{
			dto = session.selectOne(namespace+"bedroomDetail", bnum);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		return dto;
	}
	
}
