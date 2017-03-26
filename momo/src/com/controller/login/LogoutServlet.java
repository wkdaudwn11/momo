package com.controller.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 HttpSession session = request.getSession();
		 
		 // 로그인 하지 않고 LogoutController 요청 가능
		 MemberDTO dto = (MemberDTO)session.getAttribute("login");
		 
		 String target = "";
		 if(dto == null){ //로그인 안됨
			 target="LoginUIServlet";
			 request.setAttribute("loginFail", "로그인 후 시도하세요");
		 }else{  // 로그인 됨.
			 if(session.getAttribute("prevPage") == null){ // 이전 페이지가 존재하지 않으면 메인페이지로 이동.
				 target = "IndexServlet";
			 }else{	// 이전 페이지가 존재한다면 이전 페이지로 이동.
				 target = (String)session.getAttribute("prevPage");
			 }
			 session.invalidate();
		 }
		 
		  RequestDispatcher dis = request.getRequestDispatcher(target);
	      dis.forward(request, response);
	        
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
