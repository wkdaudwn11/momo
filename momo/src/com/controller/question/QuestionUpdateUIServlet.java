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
import com.entity.question.QuestionDTO;
import com.exception.AccessWrongException;
import com.service.QuestionService;

@WebServlet("/QuestionUpdateUIServlet")
public class QuestionUpdateUIServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String qnum = request.getParameter("qnum");
		String curPage = request.getParameter("curPage");
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		
		QuestionService service = new QuestionService();
		QuestionDTO question = null;
		String target = "";
		try {
			if(qnum == null){ throw new AccessWrongException();}
			question = service.questionDetail(Integer.parseInt(qnum),member);
			request.setAttribute("QuestionDTO", question);
			request.setAttribute("curPage", curPage);
			target = "question/questionUpdate.jsp";
		} catch (AccessWrongException e) {
			request.setAttribute("AccessWrong", e.getMessage());
			target="QuestionListServlet?curPage="+curPage;
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
