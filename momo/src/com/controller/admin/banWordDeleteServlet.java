package com.controller.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;
import com.service.AdminService;

@WebServlet("/banWordDeleteServlet")
public class banWordDeleteServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		String target = "";
		
		if(login != null){
			if(login.getId().equals("admin")){
				
				String bwnum = request.getParameter("bwnum");
				
				AdminService service = new AdminService();
				service.banWordDelete(Integer.parseInt(bwnum));
				
				target = "banWordUIServlet";
			}else{
				target = "IndexServlet";
				request.setAttribute("message", "잘못된 접근입니다!");
			}
		}else{
			target = "IndexServlet";
			request.setAttribute("message", "잘못된 접근입니다!");
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}//doGet()

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
