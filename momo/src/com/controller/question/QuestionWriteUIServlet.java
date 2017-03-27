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

		String reple = request.getParameter("reple");
		String qnum = request.getParameter("qnum");
		if(reple == null){
			response.sendRedirect("http://localhost:8090/momo/question/questionWrite.jsp");
		}else{
			request.setAttribute("reple", reple);
			request.setAttribute("qnum", qnum);
			
			RequestDispatcher dis = request.getRequestDispatcher("question/questionWrite.jsp");
			dis.forward(request,response);
		}
		
		
	}// end doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
