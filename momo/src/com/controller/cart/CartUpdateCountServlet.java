package com.controller.cart;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exception.CommonException;
import com.service.CartService;

@WebServlet("/CartUpdateCountServlet")
public class CartUpdateCountServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String cnum = request.getParameter("cnum");
		String count = request.getParameter("count");
		
		HashMap map = new HashMap();
		map.put("cnum", cnum);
		map.put("count", count);
		
		HttpSession session = request.getSession();
		
		try{
			if(session.getAttribute("login") != null){
				CartService service = new CartService();
				service.updateCount(map);
			}else{
				request.setAttribute("AccessWrong", "로그인 후 이용해주세요!!");
			}
		}catch (CommonException e) {
			request.setAttribute("AccessWrong", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher("CartListServlet");
		dis.forward(request, response);
		
	}//doGet
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
