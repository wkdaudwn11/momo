package com.controller.freeBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;
import com.exception.AccessWrongException;
import com.service.FreeBoardService;

@WebServlet("/FreeBoardDeleteServlet")
public class FreeBoardDeleteServlet extends HttpServlet {

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fnum = request.getParameter("fnum");
		String curPage = request.getParameter("curPage");
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		
		FreeBoardService service = new FreeBoardService();
		String target="";
		try {
			if(fnum == null){
				throw new AccessWrongException();
			}else{
				service.boardDeleteByNum(Integer.parseInt(fnum));
				target="FreeBoardListServlet?curPage"+Integer.parseInt(curPage);
				request.setAttribute("DeleteSuccess","게시물이 삭제되었습니다!");
			}
		}catch (Exception e) {
			target="FreeBoardListServlet";
			request.setAttribute("AccessWrong",e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
