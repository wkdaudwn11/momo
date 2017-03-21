package com.controller.cart;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;
import com.exception.LoginFailException;
import com.service.CartService;


@WebServlet("/CartAddServlet")
public class CartAddServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		
		String category = request.getParameter("category");
		String pnum = request.getParameter("pnum");	//상품번호
		String productCount = request.getParameter("productCount");
		
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
		
		if(memberDTO != null){
			CartService service = new CartService();
			service.addCart(category, Integer.parseInt(pnum), Integer.parseInt(productCount), memberDTO.getId());
			target = "BedRoomDetailServlet?bnum="+pnum;
			request.setAttribute("addCartSuccess", "장바구니에 담겼습니다! 장바구니로 이동하시겠습니까?");
		}else{
			session.setAttribute("prevPage", "BedRoomDetailServlet?bnum="+pnum);
			request.setAttribute("loginFail", "로그인을 하시고 장바구니에 담아주세요!");
			target = "LoginUIServlet";
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
