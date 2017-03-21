package com.controller.freeBoard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.freeboard.FreeBoardDTO;
import com.entity.member.MemberDTO;
import com.exception.LoginFailException;
import com.service.FreeBoardService;

@WebServlet("/FreeBoardWriteServlet")
public class FreeBoardWriteServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		FreeBoardDTO dto = new FreeBoardDTO();
		FreeBoardService service = new FreeBoardService();
		String target ="";
		try{
			if(member == null){
				target="http://localhost:8090/momo/LoginUIServlet";
				throw new LoginFailException("로그인 후에 이용해주세요!");
			}else{
				String title =request.getParameter("title");
				String content = request.getParameter("content");
				String author = member.getId();
				dto.setTitle(title);
				dto.setContent(content);
				dto.setAuthor(author);
				
				service.boardWrite(dto);
				target ="http://localhost:8090/momo/FreeBoardListServlet";
			}
		}catch(Exception e){
			request.setAttribute("loginFail", e.getMessage());
		}
		response.sendRedirect(target);
		
	}// end Get

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
