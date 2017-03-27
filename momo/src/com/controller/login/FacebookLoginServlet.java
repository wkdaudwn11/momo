package com.controller.login;

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
import com.service.MemberService;

@WebServlet("/FacebookLoginServlet")
public class FacebookLoginServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		if(tel == null) tel = "facebook";
		
		MemberService service = new MemberService();
		
		try{
			MemberDTO memberDTO = service.facebookLogin(id, name, tel);
			HttpSession session = request.getSession();
			session.setAttribute("login", memberDTO);
			request.setAttribute("loginMessage", memberDTO.getName()+"님 환영합니다!");
			
			if(session.getAttribute("prevPage") == null){
				target = "IndexServlet";
			}else{
				target = (String)session.getAttribute("prevPage");
			}
		}catch(Exception e){
			System.out.println("페이스북 로그인 실패");
			target="LoginUIServlet";
			request.setAttribute("message", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}//doGet()

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
