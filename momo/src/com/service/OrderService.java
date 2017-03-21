package com.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.cart.CartDTO;
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
			throw new CommonException("전체 주문 실패");
		} finally {
			session.close();
		}
		
		return list;
	}
	
}
