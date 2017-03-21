package com.controller.freeBoard;

import java.io.IOException;

import javax.security.auth.login.LoginException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;

@WebServlet("/FreeBoardWriteUIServlet")
public class FreeBoardWriteUIServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		String target ="";
		try{
			if(member == null){
				target = "LoginUIServlet";
				throw new LoginException();
			}else{
				target ="freeBoard/freeBoardWrite.jsp";
			}
		}catch(Exception e){
			request.setAttribute("loginFail",e.getMessage());		
		}
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request,response);
	}// end Get

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
