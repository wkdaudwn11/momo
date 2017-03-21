package com.controller.freeBoard;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.freeboard.FreeBoardPageDTO;
import com.service.FreeBoardService;


@WebServlet("/FreeBoardListServlet")
public class FreeBoardListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		FreeBoardService service = new FreeBoardService();
		HashMap<String,String> search = new HashMap<>();
		
		String searchType = request.getParameter("searchType");
		String searchValue= request.getParameter("searchValue");
		
		String curPage = request.getParameter("curPage");
		if(curPage == null){curPage="1";}
		
		search.put("searchType",searchType); 
		search.put("searchValue", searchValue);
		
		FreeBoardPageDTO freeBoardPage = service.boardPage(search,Integer.parseInt(curPage));
		
		request.setAttribute("freeBoardPage", freeBoardPage);
		request.setAttribute("search", search);
		
		HttpSession session = request.getSession();
		session.setAttribute("prevPage", "FreeBoardListServlet?curPage="+curPage);
		
		RequestDispatcher dis = request.getRequestDispatcher("freeBoard/freeBoardList.jsp");
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
