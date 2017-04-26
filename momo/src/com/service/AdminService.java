package com.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.banWord.BanWordDTO;
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

	/** 금지어 등록 */
	public void banWordInsert(String banWord) {
		SqlSession session = MySqlSessionFactory.openSession();

		try {
			session.insert(namespace + "banWordInsert", banWord);
			session.commit();
		} finally {
			session.close();
		}
	}//banWordInsert(String banWord)

	/** 금지어 목록 */
	public List<BanWordDTO> banWordList() {
		
		List<BanWordDTO> list = null;
		
		SqlSession session = MySqlSessionFactory.openSession();

		try {
			list = session.selectList(namespace + "banWordList");
		} finally {
			session.close();
		}
		
		return list;
	}//List<BanWordDTO> banWordList()

	/** 금지어 삭제 */
	public void banWordDelete(int bwnum) {
		SqlSession session = MySqlSessionFactory.openSession();
		
		try {
			session.delete(namespace + "banWordDelete", bwnum);
			session.commit();
		} finally {
			session.close();
		}
	}//banWordDelete(int parseInt)

}
