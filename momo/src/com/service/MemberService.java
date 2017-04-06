package com.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.member.MemberDTO;
import com.exception.CommonException;

public class MemberService {

	String namespace = "com.momo.MemberMapper.";
	
	
	/** 해당 유저의 로그인 날짜를 방금 로그인 한 날짜로 업데이트 하는 메소드 */
	private void updateLoginDate(String id) throws CommonException {
		SqlSession session = MySqlSessionFactory.openSession();
		
		try{
			int n = session.update(namespace + "updateLoginDate", id);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("로그인 날짜 수정 실패!");
		}finally{
			session.close();
		}
	}//updateLoginDate(HashMap map)
	
	/** 로그인 메소드 */
	public MemberDTO loginCheck(HashMap<String, String> map) throws CommonException {
		
		MemberDTO dto = null;
    	SqlSession session = MySqlSessionFactory.openSession();
		try{
			updateLoginDate(map.get("id"));
			dto = session.selectOne(namespace+"loginCheck", map);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("로그인 실패");
		}finally {
			session.close();
		}
		return dto;
		
	}// loginCheck(HashMap<String, String> map)
	
	/** sns 아이디(고유번호)가 이미 member테이블에 존재하는지 체크하는 메소드 */
	private int SNSMemberCheck(String id){
		SqlSession session = MySqlSessionFactory.openSession();
		int num = 0;
		
		try{
			num = session.selectOne(namespace + "SNSMemberCheck", id);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		return num;
	}//MemberDTO SNSMemberCheck(MemberDTO memberDTO)
		
	/** sns 정보를 member테이블에 저장 */
	private void addSNSMember(HashMap map) {
		SqlSession session = MySqlSessionFactory.openSession();
		
		try{
			int n = session.insert(namespace + "addSNSMember", map);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
	}//addSNSMember(MemberDTO memberDTO)
	
	/** sns 로그인 메소드 */
	public MemberDTO SNSLogin(String id, String name, String sns) throws CommonException {
		
		SqlSession session = MySqlSessionFactory.openSession();
		MemberDTO memberDTO = null; 
		
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("name", name);
		map.put("sns", sns);
		
		try{
			if(SNSMemberCheck(id) == 0){
				addSNSMember(map);
			}
			updateLoginDate(id);
			
			memberDTO = session.selectOne(namespace + "SNSLogin", id);
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("SNS 로그인 실패!");
		}finally{
			session.close();
		}
		
		//System.out.println("MemberService: " + memberDTO.getId());
		
		return memberDTO;
	}//addSNSMember(MemberDTO memberDTO)
	
	/** 회원 등록 메소드 */
	public void addMember(MemberDTO dto) throws CommonException{
		
		SqlSession session =MySqlSessionFactory.openSession();
		
		try {
			session.insert(namespace+"addMember", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("회원가입에 실패!");
		} finally {
			session.close();
		}
	}//addMember(MemberDTO dto)
	
	/** 아이디/패스워드 찾는 메소드 */
	public MemberDTO findMember(HashMap<String, String> map) throws CommonException{
		
		MemberDTO dto = null;
		SqlSession session = MySqlSessionFactory.openSession();
		
		try {
			if(map.get("userid")==null || map.get("userid").equals("")){
				
				if(map.get("tel")==null&&map.get("email")==null){
					dto = (MemberDTO) session.selectOne(namespace+"FindMemberId",map);	
				}else if(map.get("question")==null&&map.get("email")==null){
					dto = (MemberDTO) session.selectOne(namespace+"FindMemberIdTel",map);	
				}else{	
					dto = (MemberDTO) session.selectOne(namespace+"FindMemberIdEmail",map);
				}
			
			}else {
				
				if(map.get("tel")==null&&map.get("email")==null){
					dto = (MemberDTO) session.selectOne(namespace+"FindMemberPwd",map);	
				}else if(map.get("question")==null&&map.get("email")==null){
					dto = (MemberDTO) session.selectOne(namespace+"FindMemberPwdTel",map);	
				}else{	
					dto = (MemberDTO) session.selectOne(namespace+"FindMemberPwdEmail",map);
				}
									
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException("잘못된 정보입니다.");
		}finally{
			session.close();
		}
		return dto;
	}//findMember(HashMap<String, String> map)

	/** 페이스북 유저가 주문을 할 때, 입력한 배송지 정보를 회원 정보에 등록할 때 update해주는 메소드 */
	public void updateSNSMemberAddr(String id, String tel, String post1, String post2, String addr1, String addr2) {
		
		SqlSession session = MySqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("tel", tel);
		map.put("post1", post1);
		map.put("post2", post2);
		map.put("addr1", addr1);
		map.put("addr2", addr2);
		
		try{
			int n = session.update(namespace + "updateSNSMemberAddr", map);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
		
	}

}
