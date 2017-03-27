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
import com.exception.CommonException;
import com.service.MemberService;


@WebServlet("/LoginCheckServlet")
public class LoginCheckServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		HashMap<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pwd", pwd);
		
		MemberService memberService = new MemberService();
		
		String target = "";
		MemberDTO memberDTO = null;
		try {
			memberDTO = memberService.loginCheck(map);
			if(memberDTO != null){
				// 아이디와 비번이 모두 맞다.
				HttpSession session = request.getSession();
				session.setAttribute("login", memberDTO);
				request.setAttribute("loginMessage", memberDTO.getName()+"님 환영합니다!");
				
				if(session.getAttribute("prevPage") == null){ // 이전 페이지가 존재하지 않으면 메인페이지로 이동.
					target = "IndexServlet";
				}else{	// 이전 페이지가 존재한다면 이전 페이지로 이동.
					target = (String)session.getAttribute("prevPage");
				}
			}else{
				//아이디 또는 비번 틀리다.
				target = "LoginUIServlet";
				request.setAttribute("loginFail", "아이디 혹은 비밀번호가 맞지 않습니다.");
			}
		} catch (CommonException e) {
			target = "LoginUIServlet";
			request.setAttribute("message", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
