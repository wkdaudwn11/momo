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
		
		//String selectValue = request.getParameter("selectValue");
		HashMap<String, String> map = new HashMap<>();
		
		
			String question = request.getParameter("question");						
			String answer = request.getParameter("answer");
			String userid = request.getParameter("userid");						
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String email1 = request.getParameter("email1");
			String email2 = request.getParameter("email2");
			String email = email1+"@"+email2;
			System.out.println(email);
			/*if(userid.length()<2){ 
				userid = null;
			}*/
			
			if(userid != null && userid.equals("null") == false){
				map.put("userid",userid);
			}
			map.put("email",email);
			map.put("question",question);
			map.put("answer",answer);
			map.put("name",name);
			map.put("tel",tel);
		
		MemberService service = new MemberService();
		MemberDTO memberDTO = null;
		
		try {
			 memberDTO = service.findMember(map);
			 
			 if(memberDTO != null){
				 String userID= map.get("userid");
				
				 if(map.get("userid")==null){

					 	request.setAttribute("message", "회원님의 아이디는 "+memberDTO.getId()+" 입니다.");
					 
					 }else{
						 request.setAttribute("message", "회원님의 비밀번호는 "+memberDTO.getPwd()+" 입니다."); 
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
