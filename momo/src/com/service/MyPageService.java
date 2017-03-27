package com.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.member.MemberDTO;
import com.exception.CommonException;

public class MyPageService {
	
	private String namespace = "com.momo.MyPageMapper.";
	
	/** 입력한 비밀번호가 로그인 한 회원의 비밀번호와 일치하는지 검사하는 메소드 */
	public int checkPwd(String id, String pwd) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("pwd", pwd);
		
		int n = 0;
		
		try{
			n = session.selectOne(namespace + "checkPwd", map);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("비밀번호 체크 실패");
		}finally{
			session.close();
		}
		
		return n;
	}//checkPwd(String id, String pwd)

	public void updateMember(MemberDTO memberDTO2) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		
		try{
			int n = session.update(namespace + "updateMember", memberDTO2);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("회원 정보 수정 실패!");
		}finally{
			session.close();
		}
		
	}//UpdateMember(MemberDTO memberDTO2)
	
}
