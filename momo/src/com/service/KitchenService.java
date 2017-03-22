package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.kitchen.KitchenDTO;
import com.entity.kitchen.KitchenPageDTO;
import com.exception.CommonException;

public class KitchenService {

	String namespace = "com.momo.KitchenMapper.";
	
	/**각 분류의 상품을 보여주는 메소드*/
	public KitchenPageDTO kitchenList(int curPage, HashMap<String, String> map, String sortValue) throws CommonException{
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		KitchenPageDTO kitchenPageDTO = new KitchenPageDTO();
		int skip = (curPage-1) * kitchenPageDTO.getPerPage();
		List<KitchenDTO> kitchenList = null;
		
		try{
			if(sortValue.equals("bnum")){ // 최신순 
				kitchenList = session.selectList(namespace+"kitchenListknumDesc", map, new RowBounds(skip,kitchenPageDTO.getPerPage()));
  			}else if(sortValue.equals("priceAsc")){ // 가격 낮은순
  				kitchenList = session.selectList(namespace+"kitchenListPriceAsc", map, new RowBounds(skip,kitchenPageDTO.getPerPage()));
			}else if(sortValue.equals("priceDesc")){ // 가격 높은순
				kitchenList = session.selectList(namespace+"kitchenListPriceDesc", map, new RowBounds(skip,kitchenPageDTO.getPerPage()));
			}else if(sortValue.equals("buyCountDesc")){ // 판매 인기순
				kitchenList = session.selectList(namespace+"kitchenListBuyCountDesc", map, new RowBounds(skip,kitchenPageDTO.getPerPage()));
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		kitchenPageDTO.setKitchenList(kitchenList);
		kitchenPageDTO.setCurPage(curPage);
		kitchenPageDTO.setTotalRecord(totalRecord(map));
		
		
		return kitchenPageDTO;
	}//kitchenList(int curPage, HashMap<String, String> map, String sortValue)
	
	/** 인기상품 세 개를 반환해주는 메소드 */
	public KitchenPageDTO bestKitchenList() throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		KitchenPageDTO kitchenPageDTO = new KitchenPageDTO();
		List<KitchenDTO> kitchenList = null;
		
		try{
			kitchenList = session.selectList(namespace+"bestKitchenList");
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		kitchenPageDTO.setKitchenList(kitchenList);
		
		return kitchenPageDTO;
	}//bestKitchenList()
	
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

	/** 해당 상품(knum)의 정보를 반환해주는 메소드 */
	public KitchenDTO kitchenDetail(int knum) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		KitchenDTO dto = null;
		
		try{
			dto = session.selectOne(namespace+"kitchenDetail", knum);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("상품 불러오기 실패");
		}finally{
			session.close();
		}
		
		return dto;
	}
	
}
