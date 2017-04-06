package com.controller.myhome;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.myhome.MyHomeDTO;
import com.service.MyHomeService;

@WebServlet("/MyHomeDetailServlet")
public class MyHomeDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hnum = request.getParameter("hnum");
		String curPage = request.getParameter("curPage");
		
		MyHomeService service = new MyHomeService();
		MyHomeDTO myHomeDTO = service.detailMyHome(Integer.parseInt(hnum));
		
		HttpSession session = request.getSession();
		session.setAttribute("prevPage", "MyHomeDetailServlet?hnum="+hnum+"&curPage="+curPage);
		
		request.setAttribute("MyHomeDTO", myHomeDTO);
		request.setAttribute("curPage",curPage);
		
		RequestDispatcher dis = request.getRequestDispatcher("myHome/myHomeDetail.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
