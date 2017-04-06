package com.controller.myhome;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.service.MyHomeService;

@WebServlet("/MyHomeDeleteServlet")
public class MyHomeDeleteServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hnum = request.getParameter("hnum");
		String curPage = request.getParameter("curPage");
		
		MyHomeService service = new MyHomeService();
		
		service.myHomeDelete(Integer.parseInt(hnum));
		
		request.setAttribute("DeleteSuccess","게시물을 성공적으로 삭제하였습니다.");
		
		RequestDispatcher dis = request.getRequestDispatcher("MyHomeListServlet?curPage="+curPage);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
