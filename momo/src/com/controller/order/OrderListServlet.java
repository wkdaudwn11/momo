package com.controller.order;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;
import com.entity.order.OrderPageDTO;
import com.service.OrderService;

@WebServlet("/OrderListServlet")
public class OrderListServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		String myHome = request.getParameter("myHome");
		
		String curPage = request.getParameter("curpage");
		if(curPage == null) curPage = "1"; 
		
		HttpSession session = request.getSession();
		
		try{
			if(session.getAttribute("login") != null){	// 로그인 했을 경우
				MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
				
				OrderService service = new OrderService();
				OrderPageDTO orderPageDTO = null;
				
				if(myHome == null){
					orderPageDTO = service.orderList(memberDTO.getId(), Integer.parseInt(curPage));
					target = "order/orderList.jsp";
				}else{
					orderPageDTO = service.myHomeOrderList(memberDTO.getId(), Integer.parseInt(curPage));
					
					String title = request.getParameter("title");
					String content = request.getParameter("content");
					request.setAttribute("title", title);
					request.setAttribute("content", content);
					target = "myHome/selectOrderList.jsp";
				}
				request.setAttribute("orderPageDTO", orderPageDTO);
			}else{
				request.setAttribute("message", "로그인 후에 이용해주세요!");
				target = "LoginUIServlet";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}//doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
