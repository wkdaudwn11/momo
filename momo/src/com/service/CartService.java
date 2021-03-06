package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.bedRoom.BedRoomDTO;
import com.entity.cart.CartDTO;
import com.entity.cart.CartPageDTO;
import com.entity.childrenRoom.ChildrenRoomDTO;
import com.entity.kitchen.KitchenDTO;
import com.entity.livingRoom.LivingRoomDTO;
import com.exception.CommonException;

public class CartService {

	private String namespace = "com.momo.CartMapper.";
	
	/** 해당 계정에다가 장바구니 리스트에 추가 */
	public void addCart(String category, int pnum, int productCount, String id) {
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("category", category);
		map.put("count", productCount);
		
		try{
			if(category.equals("bedRoom")){
				BedRoomService service = new BedRoomService();
				BedRoomDTO bedRoomDTO = service.bedRoomDetail(pnum);
				map.put("pnum", bedRoomDTO.getBnum());
				map.put("dto", bedRoomDTO);
			}else if(category.equals("livingRoom")){
				LivingRoomService service = new LivingRoomService();
				LivingRoomDTO livingRoomDTO = service.livingRoomDetail(pnum);
				map.put("pnum", livingRoomDTO.getlnum());
				map.put("dto", livingRoomDTO);
			}else if(category.equals("kitchen")){
				KitchenService service = new KitchenService();
				KitchenDTO kitchenDTO = service.kitchenDetail(pnum);
				map.put("pnum", kitchenDTO.getKnum());
				map.put("dto", kitchenDTO);
			}else if(category.equals("childrenRoom")){
				ChildrenRoomService service = new ChildrenRoomService();
				ChildrenRoomDTO childrenRoomDTO = service.childrenRoomDetail(pnum);
				map.put("pnum", childrenRoomDTO.getCnum());
				map.put("dto", childrenRoomDTO);
			}
			
			session.insert(namespace+"addCart", map);
			session.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
	}//addCart(String category, int pnum, int productCount, String id)

	/** 해당 아이디의 장바구니 목록을 반환해주는 메소드 */
	public CartPageDTO cartList(int curPage, String userid) throws CommonException{
		SqlSession session = MySqlSessionFactory.openSession();
		
		CartPageDTO cartPageDTO = new CartPageDTO();
		int skip = (curPage-1) * cartPageDTO.getPerPage();
		List<CartDTO> cartList = null;
		
		try{
			cartList = session.selectList(namespace+"cartList", userid, new RowBounds(skip,cartPageDTO.getPerPage()));
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("장바구니 불러오기 실패");
		}finally{
			session.close();
		}
		
		cartPageDTO.setCartList(cartList);
		cartPageDTO.setCurPage(curPage);
		cartPageDTO.setTotalRecord(totalRecord(userid));
		
		return cartPageDTO;
	}//cartList(int curPage, String userid)
	
	/** 해당 아이디의 장바구니 품목 갯수를 반환해주는 메소드 */
	private int totalRecord(String userid) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		int count = -1;
		
		try{
			count = session.selectOne(namespace+"totalRecord", userid);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("장바구니 갯수 불러오기 실패");
		}finally{
			session.close();
		}
		
		return count;
	}//totalRecord(String userid)
	
	/** 해당 카트번호의 상품을 삭제하는 메소드 */
	public void deleteOne(int cnum) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		
		try{
			int n = session.delete(namespace + "deleteOne", cnum);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("장바구니 삭제 실패!");
		}
	}//deleteOne(int cnum)
	
	/** 체크 된 카트번호의 상품들을 삭제하는 메소드*/
	public void deleteCheck(List<String> list) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		try {
			int n = session.delete(namespace + "deleteCheck", list);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("장바구니 전체 삭제 실패");
		} finally {
			session.close();
		}
	}//deleteCheck(List<String> list)

	/** 장바구니에서 해당 상품의 수량을 수정하는 메소드 */
	public void updateCount(HashMap map) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		
		try{
			int n = session.update(namespace + "updateCount", map);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("장바구니 삭제 실패!");
		}
	}//updateCount(HashMap map)

}
