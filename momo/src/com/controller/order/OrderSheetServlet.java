package com.controller.order;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.cart.CartDTO;
import com.entity.member.MemberDTO;
import com.service.OrderService;

@WebServlet("/OrderSheetServlet")
public class OrderSheetServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		String[] checkCart = request.getParameterValues("checkCart");
		
		HttpSession session = request.getSession();
		
		try{
			if(session.getAttribute("login") != null){
				MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
				OrderService service = new OrderService();
				List<CartDTO> list = service.cartList(Arrays.asList(checkCart));
				
				request.setAttribute("memberDTO", memberDTO);
				request.setAttribute("cartList", list);
				target = "order/orderSheet.jsp";
			}else{
				request.setAttribute("message", "로그인 후에 이용해주세요!");
				target = "LoginUIServlet";
			}
		}catch(Exception e){
			
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}//doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
