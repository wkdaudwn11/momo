package com.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.dao.MySqlSessionFactory;
import com.entity.freeboard.FreeBoardDTO;
import com.entity.freeboard.FreeBoardPageDTO;
import com.entity.freeboard.FreeBoardRepleDTO;
import com.exception.AccessWrongException;
import com.exception.CommonException;
import com.exception.LoginFailException;

public class FreeBoardService {
	
	private String namespace = "com.momo.BoardMapper.";
	
	/** 게시글 수정 */
	public void boardUpdate(HashMap<String,String> map) throws AccessWrongException {
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			int n = session.update(namespace+"freeBoardUpdateByNum",map);
			if(n == 0){
				throw new AccessWrongException();
			}else{
				session.commit();
			}
		}finally{
			session.close();
		}
	}//boardUpdate(HashMap<String,String> map)
	
	/** 게시글 삭제 */
	public void boardDeleteByNum(int fnum) throws CommonException{
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			int n = session.delete(namespace+"freeBoardDeleteByNum",fnum);
			if(n == 0){
				throw new CommonException("해당 글은 더이상 존재 하지 않습니다.");
			}else{
				session.commit();
			}
		}finally{
			session.close();
		}
	}//boardDeleteByNum(int fnum)
	
	/** 조회수 증가 */
	private void readCnt(int fnum){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			session.update(namespace+"freeBoardReadCnt",fnum);
			session.commit();
		}finally{
			session.close();
		}
	}//readCnt(int fnum)
	
	/** 게시글 상세 보기*/
	public FreeBoardDTO boardDetail(int fnum){
		SqlSession session = MySqlSessionFactory.openSession();
		FreeBoardDTO freeBoardDTO = null;
		try{
			readCnt(fnum);
			freeBoardDTO = session.selectOne(namespace+"freeBoardDetail",fnum);
		}finally{
			session.close();
		}
		return freeBoardDTO;
	}//boardDetail(int fnum)
	
	/** 게시글 작성*/
	public void boardWrite(FreeBoardDTO boardDTO){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			session.insert(namespace+"boardWrite",boardDTO);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
	}//boardWrite(FreeBoardDTO boardDTO)
	
	/** 레코드 수 */
	private int totalRecord(HashMap<String,String> search){
		SqlSession session = MySqlSessionFactory.openSession();
		int totalRecord= 0;
		try{
			totalRecord =session.selectOne(namespace+"freeBoardListCnt",search);
		}finally{
			session.close();
		}
		return totalRecord;
	}//totalRecord(HashMap<String,String> search)
	
	/** 자유게시판 리스트 가져온다.*/
	public FreeBoardPageDTO boardPage(HashMap<String,String> search,int curPage){
		SqlSession session = MySqlSessionFactory.openSession();
		FreeBoardPageDTO freeBoardPage = new FreeBoardPageDTO();
		
		int skip = (curPage-1)*freeBoardPage.getPerPage();
		List<FreeBoardDTO> freeBoardList = null;
		try{
			if(search == null){
				freeBoardList =session.selectList(namespace+"freeBoardList",null,new RowBounds(skip,freeBoardPage.getPerPage()));
			}else{
				freeBoardList = session.selectList(namespace+"freeBoardSearchList",search,new RowBounds(skip,freeBoardPage.getPerPage()));
			}
		}finally{
			session.close();
		}
		freeBoardPage.setFreeBoardList(freeBoardList);
		freeBoardPage.setCurPage(curPage);

		freeBoardPage.setTotalRecord(totalRecord(search));
		return freeBoardPage;
	}//boardPage(HashMap<String,String> search,int curPage)

	/** 해당 게시물의 repleCnt 재설정 해주는 메서드 */
	private void repleCountUpdate(int fnum){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			int repleCount = repleCount(fnum);
			HashMap<String,Integer> map = new HashMap<>();
			map.put("fnum", fnum);
			map.put("repleCount", repleCount);
			session.update(namespace+"repleCountUpdate",map);
			session.commit();
		}finally{
			session.close();
		}
	}//repleCountUpdate(int fnum)
	
	/** 해당 게시물의 reLevel=0 댓글 갯수를 반환해주는 메소드 detail*/
	public int repleCount(int fnum) {
		SqlSession session = MySqlSessionFactory.openSession();
		int repleCount = 0;
		try{
			repleCount = session.selectOne(namespace+"repleCount", fnum);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		return repleCount;
	}//repleCount(int fnum)
	
	
	/** 해당 게시물(fnum)의 댓글 리스트를 반환해주는 메소드 */
	public List<FreeBoardRepleDTO> repleList(int fnum) {
		SqlSession session = MySqlSessionFactory.openSession();
		List<FreeBoardRepleDTO> list = null;
		try{
			list = session.selectList(namespace+"repleList", fnum);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		return list;
	}//repleList(int fnum)
	
	/** 댓글 step update 해주는 메서드*/
	private void repleUpdate(String handle,int step){
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			HashMap<String,String> map = new HashMap<>();
			map.put("handle",handle);  // insert 또는 delete
			map.put("step", Integer.toString(step));	// insert 면 부모의 step
													// delete 면 자신의 step
			session.update(namespace+"updateStep",map); // 부모글보다 step 이 크면 step +1
			
			session.commit();
		}finally{
			session.close();
		}
		
	}
	
	/**  부모글의  정보 얻어서 저장해주는   메서드*/
	private FreeBoardRepleDTO searchReple(String handle,Integer frnum,FreeBoardRepleDTO repleDTO){
		SqlSession session = MySqlSessionFactory.openSession();
		FreeBoardRepleDTO resultReple = null;
		try{

			if(handle.equals("insert")){
				if(frnum == null){
					repleDTO.setStep(0);
					repleDTO.setReLevel(0);
				}else{
					FreeBoardRepleDTO parentReple = session.selectOne(namespace+"searchReple",repleDTO.getFrnum());

					repleDTO.setStep(parentReple.getStep());
					repleDTO.setPfrnum(parentReple.getFrnum());
					repleDTO.setRef(parentReple.getRef());
					repleDTO.setReLevel(parentReple.getReLevel());
					
					repleUpdate("insert",parentReple.getStep());	
				}
				resultReple = repleDTO;
			}else if(handle.equals("delete")){
				resultReple = session.selectOne(namespace+"searchReple",frnum);
			}
		}finally{
			session.close();
		}
		return resultReple;
	}// end searchReple(String handle,Integer frnum,FreeBoardRepleDTO repleDTO)
	
	/** 해당 게시글에 댓글을 작성하는 메소드 */
	public void repleWrite(FreeBoardRepleDTO repleDTO) {
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			repleDTO = searchReple("insert",repleDTO.getFrnum(),repleDTO);
			session.insert(namespace+"repleWrite", repleDTO);
			session.commit();

			repleCountUpdate(repleDTO.getFnum()); //댓글 갯수 update 시켜주는 메소드
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
	}//repleWrite(FreeBoardRepleDTO repleDTO)
	
	/** 댓글을 삭제하는 메소드 */
	public void repleDelete(int frnum) throws CommonException{
		SqlSession session = MySqlSessionFactory.openSession();
		try{
			FreeBoardRepleDTO reple = searchReple("delete",frnum,null);
			if(reple.getReLevel() == 0){
				repleUpdate("delete",reple.getStep());
			}
			int n = session.delete(namespace+"repleDelete", frnum);
			session.commit();

			repleCountUpdate(reple.getFnum());  // 댓글 수 update 해주는 메서드
		}catch(Exception e){
			e.printStackTrace();
			throw new CommonException("삭제 실패!");
		}finally{
			session.close();
		}
	}//repleDelete(int frnum)
	
}// end Service
