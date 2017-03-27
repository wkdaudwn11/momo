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
import com.service.MyPageService;

@WebServlet("/PwdCheckServlet")
public class PwdCheckServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String target = "";
		
		String pwd = request.getParameter("pwd").trim();
		
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("login");
		
		try{
			if(memberDTO != null){
				MyPageService service = new MyPageService();
				int n = service.checkPwd(memberDTO.getId(), pwd);
				
				if(n == 1){	//비밀번호가 일치 할 경우
					target = "myPage/updateMember.jsp";
					request.setAttribute("myPage", memberDTO);
				}else if(n == 0){ //비밀번호가 일치하지 않을 경우
					target = "myPage/pwdCheck.jsp";
					request.setAttribute("message", "비밀번호가 일치하지 않습니다.");
				}else{
					target = "myPage/pwdCheck.jsp";
					request.setAttribute("message", "시스템 에러!!");
				}
			}else{
				target = "LoginUIServlet";
				request.setAttribute("message", "로그인 후에 이용해주세요!");
			}
		}catch(Exception e){
			target = "myPage/pwdCheck.jsp";
			request.setAttribute("message", "비밀번호 체크 실패");
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}//doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
