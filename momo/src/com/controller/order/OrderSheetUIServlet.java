package com.controller.order;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
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
import com.service.CartService;
import com.service.OrderService;

@WebServlet("/OrderSheetUIServlet")
public class OrderSheetUIServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		
		String[] checkCart = request.getParameterValues("checkCart");
		
		String pnum = request.getParameter("pnum");
		String category = request.getParameter("category");
		String pname = request.getParameter("pname");
		String count = request.getParameter("productCnt");
		String price = request.getParameter("price");
		String discount = request.getParameter("discount");
		String image1 = request.getParameter("image1");
		
		List<CartDTO> list = null;
		
		HttpSession session = request.getSession();
		
		try{
			if(session.getAttribute("login") != null){	// 로그인 했을 경우
				MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
				OrderService service = new OrderService();
				
				if(pnum == null){	//장바구니에서 넘어온 경우
					list = service.cartList(Arrays.asList(checkCart));
					request.setAttribute("cartList", list);
					session.setAttribute("cartList", list);
					
				}else{	//즉시구매로 넘어 온 경우
					request.setAttribute("pnum", pnum);
					request.setAttribute("category", category);
					request.setAttribute("pname", pname);
					request.setAttribute("count", count);
					request.setAttribute("price", price);
					request.setAttribute("discount", discount);
					request.setAttribute("image1", image1);
				}
				
				request.setAttribute("memberDTO", memberDTO);
				
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
