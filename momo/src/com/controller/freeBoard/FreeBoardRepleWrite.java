package com.controller.freeBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.freeboard.FreeBoardDTO;
import com.entity.freeboard.FreeBoardRepleDTO;
import com.service.FreeBoardService;

@WebServlet("/FreeBoardRepleWrite")
public class FreeBoardRepleWrite extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String fnum = request.getParameter("fnum");
		String id = request.getParameter("id");
		String author = request.getParameter("author");
		String content = request.getParameter("content");
		String curPage = request.getParameter("curPage"); // 이전 페이지로 돌아가기 위한 변수
		String frnum = request.getParameter("frnum"); //댓글의 답변을 달았을 때 필요한 변수
		
		FreeBoardRepleDTO repleDTO = new FreeBoardRepleDTO();
		if(frnum != null ) repleDTO.setFrnum(Integer.parseInt(frnum));
		repleDTO.setFnum(Integer.parseInt(fnum)); // 어느게시판에 속해있는 댓글인지 알기위해 사용됨.
		repleDTO.setId(id);
		repleDTO.setAuthor(author);
		repleDTO.setContent(content);
		
		FreeBoardService service = new FreeBoardService();
		
		service.repleWrite(repleDTO);
		
		// 해당 게시글의 작성자를 가져오기 위해서 boardDetail()을 호출.
		FreeBoardDTO freeBoardDTO = service.boardDetail(Integer.parseInt(fnum));
		
		// 작성자를 리퀘스트에 저장. (헤더에서 로그인 아이디와 작성자를 비교하여 같으면 notification을 보여줌)
		request.setAttribute("notificationID", freeBoardDTO.getId());
		
		request.setAttribute("notificationTitle", author+"님이 댓글을 달았습니다.");
		request.setAttribute("notificationMessage", content);
		
		String target = "FreeBoardDetailServlet?fnum="+fnum+"&curPage="+curPage;
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
