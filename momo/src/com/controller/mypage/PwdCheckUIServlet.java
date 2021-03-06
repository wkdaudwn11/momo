package com.controller.mypage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;

@WebServlet("/PwdCheckUIServlet")
public class PwdCheckUIServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
		
		if(memberDTO != null){
			if(memberDTO.getSns() == null){
				target = "myPage/pwdCheck.jsp";
			}else{
				request.setAttribute("message", "페이스북으로 로그인하셨으면 정보수정은 할 수 없습니다.");
				if(request.getParameter("prevPage") != null){
					target = (String)request.getParameter("prevPage");
				}else{
					target = "index.jsp";
				}
			}
		}else{
			target = "LoginUIServlet";
			request.setAttribute("message", "로그인 후에 이용해주세요!");
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}//doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
