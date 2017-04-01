package com.controller.order;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exception.CommonException;
import com.service.OrderService;

@WebServlet("/OrderDeleteServlet")
public class OrderDeleteServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String groupnum = request.getParameter("groupnum");
		
		System.out.println("groupnum");
		
		String[] checkOrder = request.getParameterValues("checkOrder");
		
		HttpSession session = request.getSession();
		
		try{
			if(session.getAttribute("login") != null){
				OrderService service = new OrderService();
				if(checkOrder != null){
					service.deleteCheck(Arrays.asList(checkOrder));
				}else{
					service.deleteOne(Integer.parseInt(groupnum));
				}
			
			}else{
				request.setAttribute("AccessWrong", "로그인 후 이용해주세요!!");
			}
		}catch (CommonException e) {
			request.setAttribute("AccessWrong", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher("OrderListServlet");
		dis.forward(request, response);
		
	}//doGet
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
