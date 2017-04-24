package com.service;

import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.bedRoom.BedRoomDTO;

public class AdminService {

	String namespace = "com.momo.AdminMapper.";

	// 현재 bedroom 테이블의 시퀀스 번호를 반환하는 메소드
	public int getPolderNum() {

		int bnum;

		SqlSession session = MySqlSessionFactory.openSession();

		try {
			bnum = session.selectOne(namespace + "getPolderNum");
		} finally {
			session.close();
		}

		return bnum;
	}//getPolderNum()
	
	/** 상품 등록 */
	public void productInsert(BedRoomDTO dto) {
		
		SqlSession session = MySqlSessionFactory.openSession();

		try {
			session.insert(namespace + "productInsert", dto);
			session.commit();
		} finally {
			session.close();
		}
	}//productInsert(BedRoomDTO dto)

}
