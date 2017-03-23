package com.controller.order;

import java.io.IOException;
import java.util.ArrayList;
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

@WebServlet("/OrderSheetServlet")
public class OrderSheetServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String target = "";
		
		List<CartDTO> list = (List<CartDTO>)session.getAttribute("cartList");
		
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
		String pnum = request.getParameter("pnum");
		String category = request.getParameter("category");
		String pname = request.getParameter("pname");
		String count = request.getParameter("count");
		String price = request.getParameter("price");
		String discount = request.getParameter("discount");
		String image1 = request.getParameter("image1");
		String orderMessage = request.getParameter("orderMessage");
		
		try{
			if(memberDTO != null){
				OrderService service = new OrderService();
				if(list != null){ // 카트에서 주문을 한 경우 (여러 개) 
					service.orderInsertAll(list);
					
					//주문을 하고 나면 카트에 있던 물품들을 삭제해준다.
					CartService cartService = new CartService();
					List<String> list2 = new ArrayList<>();
					for(int i=0; i<list.size(); i++){
						list2.add(""+list.get(i).getCnum());
					}
					cartService.deleteCheck(list2);
					
				}else{ // 즉시구매로 주문을 한 경우 (한 개)
					HashMap map = new HashMap();
					map.put("id", memberDTO.getId());
					map.put("pnum", pnum);
					map.put("category", category);
					map.put("pname", pname);
					map.put("count", count);
					map.put("price", price);
					map.put("discount", discount);
					map.put("image1", image1);
					map.put("orderMessage", orderMessage);
					
					service.orderInsertOne(map);
				}
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
