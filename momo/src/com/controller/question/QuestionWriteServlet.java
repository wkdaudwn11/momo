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
		
		String curPage = request.getParameter("curPage");
		String qnum = request.getParameter("qnum");
		String id = request.getParameter("id");
		String category = request.getParameter("category");
		String password = request.getParameter("password");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String author = request.getParameter("author");
		QuestionDTO question = new QuestionDTO();
		if(qnum != null && qnum.equals("") == false){
			question.setQnum(Integer.parseInt(qnum));
		}
		question.setId(id);
		question.setCategory(category);
		question.setTitle(title);
		question.setContent(content);
		question.setAuthor(author);
		if(password != null && password.trim().equals("") == false){
			question.setPassword(password);
		}
		
		QuestionService service = new QuestionService();
		
		service.insertQuestion(question);
		
		request.setAttribute("WriteSuccess","문의가 접수 되었습니다.");
		
		RequestDispatcher dis = request.getRequestDispatcher("QuestionListServlet?curPage="+curPage);
		dis.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
