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
import com.exception.CommonException;
import com.service.FreeBoardService;

@WebServlet("/FreeBoardRepleDelete")
public class FreeBoardRepleDelete extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String frnum = request.getParameter("frnum");
		String fnum = request.getParameter("fnum");
		String curPage = request.getParameter("curPage");
		String target = "";
		
		FreeBoardService service = new FreeBoardService();
		try {
			HttpSession session = request.getSession();
			MemberDTO login = (MemberDTO)session.getAttribute("login");
			
			if(login != null){
				service.repleDelete(Integer.parseInt(frnum));
				request.setAttribute("repleDel", "댓글이 삭제되었습니다.");
				target = "FreeBoardDetailServlet?fnum="+fnum+"&curPage="+curPage;
			}else{
				request.setAttribute("repleDel", "로그인 후에 삭제를 해주세요!");
				target = "IndexServlet";
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (CommonException e) {
			target = "FreeBoardDetailServlet?fnum="+fnum+"&curPage="+curPage;;
			request.setAttribute("repleDel", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
