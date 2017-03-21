package com.controller.freeBoard;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.exception.CommonException;
import com.service.FreeBoardService;

@WebServlet("/FreeBoardUpdateServlet")
public class FreeBoardUpdateServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String fnum = request.getParameter("fnum");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("title", title);
		map.put("content", content);
		map.put("fnum", fnum);
		
		FreeBoardService service = new FreeBoardService();
		try {
			service.boardUpdate(map);
		} catch (Exception e) {
			request.setAttribute("AccessWrong", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher("FreeBoardDetailServlet?fnum="+fnum);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
