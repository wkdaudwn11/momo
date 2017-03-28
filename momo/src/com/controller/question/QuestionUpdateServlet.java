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

@WebServlet("/QuestionUpdateServlet")
public class QuestionUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		
		String curPage  = request.getParameter("curPage");
		String id = request.getParameter("id");
		String qnum = request.getParameter("qnum");
		String title = request.getParameter("title");
		String category = request.getParameter("category");
		String content = request.getParameter("content");
		String password = request.getParameter("password");
		QuestionDTO question = new QuestionDTO();
		question.setId(id);
		question.setQnum(Integer.parseInt(qnum));
		question.setTitle(title);
		question.setCategory(category);
		question.setPassword(password);
		question.setContent(content);
		
		QuestionService service =  new QuestionService();
		try {
			service.updateQuestion(question,member);
			request.setAttribute("WriteSuccess","게시글 수정 완료");
		} catch (AccessWrongException e) {
			request.setAttribute("AccessWrong", e.getMessage());
		}
		RequestDispatcher dis = request.getRequestDispatcher("QuestionListServlet?curPage="+Integer.parseInt(curPage));
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
