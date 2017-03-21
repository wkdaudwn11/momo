package com.controller.freeBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.freeboard.FreeBoardDTO;
import com.entity.member.MemberDTO;

@WebServlet("/FreeBoardUpdateUIServlet")
public class FreeBoardUpdateUIServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fnum = request.getParameter("fnum");
		String curPage = request.getParameter("curPage");
		String author = request.getParameter("author");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writeday = request.getParameter("writeday");

		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		FreeBoardDTO freeBoardDTO = new FreeBoardDTO();	

		String target = "";
		try{
			if(fnum == null){
				//throw new AccessWrongException();
			}else{
				target = "freeBoard/freeBoardUpdate.jsp";
				freeBoardDTO.setAuthor(author);
				freeBoardDTO.setContent(content);
				freeBoardDTO.setFnum(Integer.parseInt(fnum));
				freeBoardDTO.setWriteday(writeday);
				freeBoardDTO.setTitle(title);
			}
		}catch(Exception e){
			request.setAttribute("AccessWrong",e.getMessage());
			target = "FreeBoardListServlet";
		}
		
		request.setAttribute("curPage",curPage);
		request.setAttribute("FreeBoardDTO",freeBoardDTO);
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
