package com.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.member.MemberDTO;
import com.exception.CommonException;

public class MemberService {

	String namespace = "com.momo.MemberMapper.";
	
	/** 로그인 메소드 */
	public MemberDTO loginCheck(HashMap<String, String> map) throws CommonException {
		
		MemberDTO dto = null;
    	SqlSession session = MySqlSessionFactory.openSession();
		try{
			dto = session.selectOne(namespace+"loginCheck", map);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("로그인 실패");
		}finally {
			session.close();
		}
		return dto;
		
	}// loginCheck(HashMap<String, String> map)
	
	/** 회원 등록 메소드 */
	public void addMember(MemberDTO dto) throws CommonException{
		SqlSession session =MySqlSessionFactory.openSession();
		
		try {
			int n =session.insert(namespace+"addMember", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("회원가입에 실패하였습니다! 다시 시도해주세요. ");
		} finally {
			session.close();
		}
	}// add member
	
	/** 아이디/패스워드 찾는 메소드 */
	public MemberDTO findMember(HashMap<String, String> map) throws CommonException{
		
		MemberDTO dto = null;
		SqlSession session = MySqlSessionFactory.openSession();
		
		try {
			if(map.get("findValue").equals("id")){
				dto = (MemberDTO) session.selectOne(namespace+"FindMemberId",map);
			}else if(map.get("findValue").equals("pwd")){
				dto = (MemberDTO)session.selectOne(namespace+"FindMemberPwd",map);					
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("잘못된 정보입니다.");
		}finally{
			session.close();
		}
		return dto;
	}//findMember(HashMap<String, String> map)
}
