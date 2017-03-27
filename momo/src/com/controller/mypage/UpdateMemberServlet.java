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
import com.exception.CommonException;
import com.service.MemberService;
import com.service.MyPageService;


@WebServlet("/UpdateMemberServlet")
public class UpdateMemberServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
		
		String target ="";
		
		if(memberDTO != null){
			String id =request.getParameter("id");
			String name =request.getParameter("name");
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
			
			MemberDTO memberDTO2 = new MemberDTO();
			memberDTO2.setId(id);
			memberDTO2.setName(name);
			memberDTO2.setPwd(pwd);
			memberDTO2.setPwd2(pwd2);
			memberDTO2.setGender(gender);
			memberDTO2.setTel(tel);
			memberDTO2.setQuestion(question);
			memberDTO2.setAnswer(answer);
			memberDTO2.setPost1(post1);
			memberDTO2.setPost2(post2);
			memberDTO2.setAddr1(addr1);
			memberDTO2.setAddr2(addr2);
			
			MyPageService service = new MyPageService();
			try {
				service.updateMember(memberDTO2);
				request.setAttribute("message", "회원정보가 성공적으로 수정되었습니다!");
			} catch (CommonException e) {
				request.setAttribute("message", e.getMessage());
			}
			target = "myPage/myPage.jsp";
		}else{
			request.setAttribute("message", "로그인 후에 이용해주세요.");
			target ="LoginUIServlet";
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
