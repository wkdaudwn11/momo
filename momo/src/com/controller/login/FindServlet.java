package com.controller.login;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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
		
		String target = "LoginUIServlet";
		
		String findRadio = "";
		String findSelect = "";
		
		MemberService service = new MemberService();
		MemberDTO memberDTO = null;
		
		HashMap map = new HashMap();
		
		try{
			if(request.getParameter("findIdQuestion") != null){
				findRadio = "id";
				findSelect = "question";
				String name = request.getParameter("findIdQuestionName");
				String question = request.getParameter("findIdQuestionQuestion");
				String answer = request.getParameter("findIdQuestionAnswer");
				
				map.put("findRadio", findRadio);
				map.put("findSelect", findSelect);
				map.put("name", name);
				map.put("question", question);
				map.put("answer", answer);
				
				memberDTO = service.findMember(map);
				
			}else if(request.getParameter("findIdTel") != null){
				findRadio = "id";
				findSelect = "tel";
				String name = request.getParameter("findIdTelName");
				String tel = request.getParameter("findIdTelTel");
				
				map.put("findRadio", findRadio);
				map.put("findSelect", findSelect);
				map.put("name", name);
				map.put("tel", tel);
				
				memberDTO = service.findMember(map);
			}else if(request.getParameter("findIdEmail") != null){
				findRadio = "id";
				findSelect = "email";
				String name = request.getParameter("findIdEmailName");
				String email1 = request.getParameter("findIdEmailEmail1");
				String email2 = request.getParameter("findIdEmailEmail2");
				String email = email1 + "@" + email2;
				
				map.put("findRadio", findRadio);
				map.put("findSelect", findSelect);
				map.put("name", name);
				map.put("email", email);
				
				memberDTO = service.findMember(map);
			}else if(request.getParameter("findPwdQuestion") != null){
				findRadio = "pwd";
				findSelect = "question";
				String id = request.getParameter("findPwdQuestionId");
				String name = request.getParameter("findPwdQuestionName");
				String question = request.getParameter("findPwdQuestionQuestion");
				String answer = request.getParameter("findPwdQuestionAnswer");
				
				map.put("findRadio", findRadio);
				map.put("findSelect", findSelect);
				map.put("id", id);
				map.put("name", name);
				map.put("question", question);
				map.put("answer", answer);
				
				memberDTO = service.findMember(map);
			}else if(request.getParameter("findPwdTel") != null){
				findRadio = "pwd";
				findSelect = "tel";
				String id = request.getParameter("findPwdTelId");
				String name = request.getParameter("findPwdTelName");
				String tel = request.getParameter("findPwdTelTel");
				
				map.put("findRadio", findRadio);
				map.put("findSelect", findSelect);
				map.put("id", id);
				map.put("name", name);
				map.put("tel", tel);
				
				memberDTO = service.findMember(map);
			}else if(request.getParameter("findPwdEmail") != null){
				findRadio = "pwd";
				findSelect = "email";
				String id = request.getParameter("findPwdEmailId");
				String name = request.getParameter("findPwdEmailName");
				String email1 = request.getParameter("findPwdEmailEmail1");
				String email2 = request.getParameter("findPwdEmailEmail2");
				String email = email1 + "@" + email2;
				
				map.put("findRadio", findRadio);
				map.put("findSelect", findSelect);
				map.put("id", id);
				map.put("name", name);
				map.put("email", email);
				
				memberDTO = service.findMember(map);
			}
			
			if(memberDTO != null){
				if(!(findSelect.equals("email"))){
					if(findRadio.equals("pwd")){
						request.setAttribute("message", "회원님의 비밀번호는 "+memberDTO.getPwd()+" 입니다.");
					}else{
						request.setAttribute("message", "회원님의 아이디는 "+memberDTO.getId()+" 입니다.");
					}
				}else{
					target = "login/emailConfirm.jsp";
					
					String confirmNumber = "";
					
					for(int i=0; i<6; i++){
						int randomNum = (int)(Math.random() * 10);
						confirmNumber += randomNum;
					}
					
					ServletContext ctx = getServletContext();
					ctx.setAttribute("memberDTO", memberDTO);
					ctx.setAttribute("confirmNumber", confirmNumber);
					ctx.setAttribute("findRadio", findRadio);
				}
			 }else{
				 target = "FindUIServlet";
				 request.setAttribute("message", "일치하는 정보가 없습니다.");
			 }
		}catch(CommonException e) {
			e.printStackTrace();
			request.setAttribute("message", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
