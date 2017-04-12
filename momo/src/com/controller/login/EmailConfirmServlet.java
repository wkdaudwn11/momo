package com.controller.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.member.MemberDTO;

@WebServlet("/EmailConfirmServlet")
public class EmailConfirmServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		
		ServletContext ctx = getServletContext();
		if(ctx.getAttribute("confirmNumber") == null){
			request.setAttribute("message", "잘못된 접근입니다!");
			target = "index.jsp";
		}else{
			if(ctx.getAttribute("findRadio").equals("id")){
				request.setAttribute("message", "회원님의 아이디는 "+((MemberDTO)ctx.getAttribute("memberDTO")).getId()+" 입니다.");
			}else{
				request.setAttribute("message", "회원님의 비밀번호는 "+((MemberDTO)ctx.getAttribute("memberDTO")).getPwd()+" 입니다.");
			}
			target = "login/loginForm.jsp";
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
