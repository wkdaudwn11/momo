package com.controller.question;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.question.QuestionPage;
import com.service.QuestionService;

@WebServlet("/QuestionListServlet")
public class QuestionListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String curPage = request.getParameter("curPage");
		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");
		if(curPage == null){
			curPage = "1";
		}
		HashMap<String,String> search = new HashMap<>();
		search.put("searchType", searchType);
		search.put("searchValue", searchValue);
		
		QuestionService service = new QuestionService();
		
		QuestionPage questionPage = service.questionList(search,Integer.parseInt(curPage));
		
		request.setAttribute("QuestionPage", questionPage);
		
		RequestDispatcher dis = request.getRequestDispatcher("question/questionList.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
