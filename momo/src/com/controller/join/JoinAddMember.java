package com.controller.join;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.member.MemberDTO;
import com.service.MemberService;


@WebServlet("/JoinAddMember")
public class JoinAddMember extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String name =request.getParameter("name");
		String id =request.getParameter("id");
		String pwd =request.getParameter("pwd");
		String pwd2 =request.getParameter("pwd2");
		String gender =request.getParameter("gender");
		String tel =request.getParameter("tel");
		String question =request.getParameter("question");
		String answer =request.getParameter("answer");
		String post1 =request.getParameter("post1");
		String post2 =request.getParameter("post2");
		String addr1 =request.getParameter("addr1");
		String addr2 =request.getParameter("addr2");
		
		MemberDTO dto = new MemberDTO(0,name, id, pwd, pwd2, gender, tel, question, answer, post1, post2, addr1, addr2, "가입날짜", "로그인날짜", 0, 0, "no");
		MemberService service = new MemberService();
		String target ="";
		try {
			service.addMember(dto);
			target = "IndexServlet";
			request.setAttribute("joinMessage", "회원가입에 성공하였습니다!");
		} catch (Exception e) {
			target = "IndexServlet";
			request.setAttribute("joinMessage", e.getMessage());
			request.setAttribute("link", "joinUIServlet");
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
