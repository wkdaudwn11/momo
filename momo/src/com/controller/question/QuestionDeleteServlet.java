package com.controller.question;

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
import com.service.QuestionService;

@WebServlet("/QuestionDeleteServlet")
public class QuestionDeleteServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String qnum = request.getParameter("qnum");
		String curPage = request.getParameter("curPage");
		MemberDTO member = (MemberDTO)session.getAttribute("login"); 
		QuestionService service = new QuestionService();
		try{
			if(qnum == null){ throw new AccessWrongException();}
			service.deleteQuestion(Integer.parseInt(qnum),member);
			request.setAttribute("DeleteSuccess", "게시물이 삭제 되었습니다.");
		}catch(Exception e){
			request.setAttribute("AccessWrong", e.getMessage());
		}
		RequestDispatcher dis = request.getRequestDispatcher("QuestionListServlet?curPage="+Integer.parseInt(curPage));
		dis.forward(request, response);
	}// end doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
