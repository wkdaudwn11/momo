package com.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.cart.CartDTO;
import com.entity.order.OrderDTO;
import com.entity.order.OrderPageDTO;
import com.exception.CommonException;

public class OrderService {

	String namespace = "com.momo.OrderMapper.";
	
	/** 장바구니에서 체크된 물품들의 정보를 가져오는 메소드 */
	public List<CartDTO> cartList(List<String> nums) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		List<CartDTO> list = null;
		try {
			list = session.selectList(namespace + "cartList", nums);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("장바구니에서 가져오기 실패");
		} finally {
			session.close();
		}
		
		return list;
	}//cartList(List<String> nums)
	
	/** 카트에서 주문을 했을 경우 (주문하는 물품이 여러 개(혹은 한 개)일 경우 (수량(count)을 말하는 것이 아님)) */
	public void orderInsertAll(List<CartDTO> list) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		HashMap map = new HashMap();
		double equalGroupTotalPrice = 0;
		int equalGroupTotalCount = 0;
		
		try {
			
			/* seqNextVal는 groupnum의 시퀀스를 nextval해주는 쿼리다.
			 * 이유는 2가지가 있음.
			 * 1. groupnum 속성에다가 시퀀스.currval 해주기 위해선, 처음에 nextval을 해줘야함. (맨처음에만, 안하면 currval 할 수가 없음.)
			 * 2. 1번의 이유가 아니더라도, groupnum은 동시에 같이 여러개를 구매한 것들을(혹은 한개라도) 그룹을 지어주기 위한 속성인데
			 * 		insert할 때 currval로 해서 그룹번호를 매겨주기 때문에, insert하기 전에
			 * 		이 전에 구매했던 그루핑 번호보다 +1 증가시켜줘야 중복이 안되기 때문에 nextval을 한 번 해줘야한다. */
			int n2 = session.selectOne(namespace + "seqNextVal"); 
			
			//그룹의 총 가격은 할인율이 적용된 가격을 집어 넣는다.
			//그룹의 총 갯수도 적용.
			for(int i=0; i<list.size(); i++){
				int price = list.get(i).getPrice();
				double discount = list.get(i).getDiscount();
				equalGroupTotalPrice += price * (1.0 - (discount/100));
				
				int count = list.get(i).getCount();
				equalGroupTotalCount += count;
			}
			
			//리스트만큼 반복문을 돌려서, i번째 값을 맵에 저장 후, mapper에다가 map을 넘김.
			for(int i=0; i<list.size(); i++){
				map.put("id", list.get(i).getId());
				map.put("pnum", list.get(i).getPnum());
				map.put("category", list.get(i).getCategory());
				map.put("pname", list.get(i).getName());
				map.put("count", list.get(i).getCount());
				map.put("price", list.get(i).getPrice());
				map.put("discount", list.get(i).getDiscount());
				map.put("image1", list.get(i).getImage1());
				map.put("equalGroupCount", list.size());
				map.put("equalGroupTotalPrice", equalGroupTotalPrice);
				map.put("equalGroupTotalCount", equalGroupTotalCount);
				int n = session.insert(namespace + "orderInsertAll", map);
			}
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("카트 주문 실패");
		} finally {
			session.close();
		}
	}

	/** 즉시 주문을 했을 경우 (주문하는 물품이 무조건 한 개일 경우 (수량(count)을 말하는 것이 아님)) */
	public void orderInsertOne(HashMap map) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		try {
			int n2 = session.selectOne(namespace + "seqNextVal"); 
			int n = session.insert(namespace + "orderInsertOne", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("직접 주문 실패");
		} finally {
			session.close();
		}
	}//orderInsertOne(HashMap map)
	
	/** 가져온 주문리스트의 Group개수 새서 반환해주는 메서드*/
	private int totalGroupRecord(List<OrderDTO> orderList){
		HashSet<Integer> groupList = new HashSet<>();
		for(OrderDTO dto : orderList){
			groupList.add(dto.getGroupnum());
		}
		return groupList.size();
	}//int totalGroupRecord(List<OrderDTO> orderList)
	
	/** 해당아이디의 주문내역상태가 '배송완료' 인 list 를 가져오는 메서드 */
	public OrderPageDTO myHomeOrderList(String id,int curPage) throws CommonException{
		SqlSession session = MySqlSessionFactory.openSession();
		List<OrderDTO> orderList = null;
		OrderPageDTO orderPageDTO = new OrderPageDTO();
		int skip = (curPage-1) * orderPageDTO.getPerPage();
		
		try{
			orderList = session.selectList(namespace+"myHomeOrderList", id, new RowBounds(skip, orderPageDTO.getPerPage()));
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("주문내역 불러오기 실패!");
		}finally{
			session.close();
		}
		orderPageDTO.setOrderList(orderList);
		orderPageDTO.setCurPage(curPage);
		orderPageDTO.setTotalRecord(orderList.size());
		orderPageDTO.setTotalRecordDistinct(totalGroupRecord(orderList));
		return orderPageDTO;
	}
	
	/** 해당 아이디의 주문내역을 orderDTO로 반환해주는 메소드 */
	public OrderPageDTO orderList(String id, int curPage) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		List<OrderDTO> orderlist = null;
		OrderPageDTO orderPageDTO = new OrderPageDTO();
		int equalGroupTotalPrice = 0;
		
		int skip = (curPage-1) * orderPageDTO.getPerPage();
		
		try{
			orderlist = session.selectList(namespace+"orderList", id, new RowBounds(skip, orderPageDTO.getPerPage()));
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("주문내역 불러오기 실패!");
		}finally{
			session.close();
		}
		
		orderPageDTO.setOrderList(orderlist);
		orderPageDTO.setCurPage(curPage);
		orderPageDTO.setTotalRecord(totalRecord(id));
		orderPageDTO.setTotalRecordDistinct(totalRecordDistinct(id));
		
		return orderPageDTO;
		
	}//orderList(String id)
	
	/** 해당 id의 주문내역 총 갯수를 반환해주는 메소드 */
	private int totalRecord(String id) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		int count = -1;
		
		try{
			count = session.selectOne(namespace+"totalRecord", id);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("주문내역 갯수 불러오기 실패!");
		}finally{
			session.close();
		}
		
		return count;
	}//totalRecord(HashMap<String, String> map)
	
	/** 해당 id의 groupnum 중복값을 제거한 주문내역 총 갯수를 반환해주는 메소드 */
	private int totalRecordDistinct(String id) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		int count = -1;
		
		try{
			count = session.selectOne(namespace+"totalRecordDistinct", id);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("주문내역 갯수 불러오기 실패!");
		}finally{
			session.close();
		}
		
		return count;
	}//totalRecord(HashMap<String, String> map)
	
	/** 해당 주문 그룹번호의 상품을 삭제하는 메소드 */
	public void deleteOne(int groupnum) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		
		try{
			int n = session.delete(namespace + "deleteOne", groupnum);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("주문내역 삭제 실패!");
		}
	}//deleteOne(int cnum)
	
	/** 체크 된 주문내역의 상품들을 삭제하는 메소드*/
	public void deleteCheck(List<String> list) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		try {
			int n = session.delete(namespace + "deleteCheck", list);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("주문내역 전체 삭제 실패");
		} finally {
			session.close();
		}
	}//deleteCheck(List<String> list)

}
