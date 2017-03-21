package com.controller.cart;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.cart.CartPageDTO;
import com.entity.member.MemberDTO;
import com.exception.LoginFailException;
import com.service.CartService;


@WebServlet("/CartListServlet")
public class CartListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target="cart/cartList.jsp";
		
		HttpSession session = request.getSession();
		
		String curPage = request.getParameter("curPage");
		if(curPage == null) curPage="1";
		
		CartService service = new CartService();
		
		try{
			if(session.getAttribute("login") != null){
				MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
				target = "cart/cartList.jsp";
				CartPageDTO cartPageDTO = service.cartList(Integer.parseInt(curPage), memberDTO.getId());
				request.setAttribute("cartPageDTO", cartPageDTO);	//상품 리스트
				
				//session.setAttribute("prevPage", "CartListServlet");
				
			}else{
				target = "LoginUIServlet";
				throw new LoginFailException("로그인 후에 이용해주세요!");
			}
		}catch(Exception e){
			request.setAttribute("loginFail", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
