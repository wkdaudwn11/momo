package com.controller.login;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.member.MemberDTO;
import com.exception.CommonException;
import com.service.MemberService;


@WebServlet("/FindServlet")
public class FindServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String findValue = request.getParameter("findValue");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		String userid = request.getParameter("userid");
		String name = request.getParameter("name");
		
		HashMap<String, String> map = new HashMap<>();
		map.put("findValue", findValue);
		map.put("question",question);
		map.put("answer",answer);
		map.put("userid",userid);
		map.put("name",name);
		
		
		MemberService service = new MemberService();
		MemberDTO memberDTO = null;
		
		try {
			 memberDTO = service.findMember(map);
			 
			 if(memberDTO != null){
				 String userID= map.get("userid");
				 
				 if(map.get("findValue").equals("pwd")){
						request.setAttribute("message", "회원님의 비밀번호는 "+memberDTO.getPwd()+" 입니다.");
					 }else{
						 request.setAttribute("message", "회원님의 아이디는 "+memberDTO.getId()+" 입니다z.");
					 }
				 
			 }else{
				 request.setAttribute("message", "일치하는 정보가 없습니다.");
			 }
			 
		} catch (CommonException e) {
			e.printStackTrace();
			request.setAttribute("message", e.getMessage());
		}
	
		RequestDispatcher dis = request.getRequestDispatcher("LoginUIServlet");
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
