package com.controller.question;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.question.QuestionDTO;
import com.service.QuestionService;

@WebServlet("/QuestionWriteServlet")
public class QuestionWriteServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String reple = request.getParameter("reple");
		String category = request.getParameter("category");
		String password = request.getParameter("password");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String author = request.getParameter("author");
		if(reple == null){
			reple ="N";
		}
		System.out.println("wirteServlet category = "+category);///////////////////////////
		
		QuestionDTO question = new QuestionDTO();
		question.setReple(reple);
		question.setCategory(category);
		question.setTitle(title);
		question.setContent(content);
		question.setAuthor(author);
		if(password != null && password.trim() != ""){
			question.setPassword(password);
		}
		
		QuestionService service = new QuestionService();
		
		service.insertQuestion(question);
		
		request.setAttribute("WriteSuccess","문의가 접수 되었습니다.");
		
		RequestDispatcher dis = request.getRequestDispatcher("QuestionListServlet");
		dis.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
