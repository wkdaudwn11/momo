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
import com.exception.LoginFailException;

@WebServlet("/QuestionWriteUIServlet")
public class QuestionWriteUIServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String curPage = request.getParameter("curPage");
		String qnum = request.getParameter("qnum");
		String password = request.getParameter("password");
		String category = request.getParameter("category");
		request.setAttribute("qnum", qnum);
		request.setAttribute("password", password);
		request.setAttribute("category", category);
		request.setAttribute("curPage", curPage);
		
		RequestDispatcher dis = request.getRequestDispatcher("question/questionWrite.jsp");
		dis.forward(request, response);
	}// end doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
