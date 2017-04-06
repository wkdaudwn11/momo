package com.controller.myhome;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;
import com.entity.myhome.MyHomeDTO;

@WebServlet("/myHomeWriteUIServlet")
public class myHomeWriteUIServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*response.sendRedirect("myHome/myHomeWrite.jsp");*/
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		
		String curPage = request.getParameter("curPage");
		String hnum = request.getParameter("hnum");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		if(curPage != null){   // 업데이트 일경우
			MyHomeDTO myHomeDTO = new MyHomeDTO();
			myHomeDTO.setId(member.getId());
			myHomeDTO.setAuthor(member.getName());
			myHomeDTO.setHnum(Integer.parseInt(hnum));
			myHomeDTO.setTitle(title);
			myHomeDTO.setContent(content);
			
			request.setAttribute("MyHomeDTO", myHomeDTO);
			request.setAttribute("curPage", curPage);
		}
		RequestDispatcher dis = request.getRequestDispatcher("myHome/myHomeWrite.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
