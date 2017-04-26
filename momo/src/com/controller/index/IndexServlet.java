package com.controller.index;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.myhome.MyHomeDTO;
import com.service.MyHomeService;


@WebServlet("/IndexServlet")
public class IndexServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/*HttpSession session  = request.getSession();
		session.setAttribute("prevPage", "IndexServlet");
		
		MyHomeService myHomeService = new MyHomeService();
		
		List<MyHomeDTO> bestMyHomeList = myHomeService.bestMyHomeList("IndexServlet");
		
		request.setAttribute("bestMyHomeList", bestMyHomeList);*/
		
		RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
