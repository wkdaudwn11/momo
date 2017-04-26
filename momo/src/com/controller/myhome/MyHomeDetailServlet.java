package com.controller.myhome;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.myhome.MyHomeDTO;
import com.entity.order.OrderDTO;
import com.service.MyHomeService;

@WebServlet("/MyHomeDetailServlet")
public class MyHomeDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hnum = request.getParameter("hnum");
		String curPage = request.getParameter("curPage");
		
		MyHomeService service = new MyHomeService();
		HashMap<String,Object> map = service.detailMyHome(Integer.parseInt(hnum));
		
		HttpSession session = request.getSession();
		session.setAttribute("prevPage", "MyHomeDetailServlet?hnum="+hnum+"&curPage="+curPage);
		
		request.setAttribute("orderList", (List<OrderDTO>)map.get("orderList"));
		request.setAttribute("MyHomeDTO", (MyHomeDTO)map.get("MyHomeDTO"));
		request.setAttribute("curPage",curPage);
		
		RequestDispatcher dis = request.getRequestDispatcher("myHome/myHomeDetail.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
