package com.controller.livingroom;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.livingroom.LivingRoomDTO;
import com.exception.CommonException;
import com.service.LivingRoomService;

@WebServlet("/LivingRoomDetailServlet")
public class LivingRoomDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String target = "";
		String lnum = request.getParameter("lnum");
		
		LivingRoomService service = new LivingRoomService();
		try {
			LivingRoomDTO livingroomDTO = service.livingroomDetail(Integer.parseInt(lnum));
			request.setAttribute("LivingRoomDTO", livingroomDTO);
			target="livingRoom/livingRoomDetail.jsp";
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "LivingRoomDetailServlet?lnum="+lnum);
			
		}catch (CommonException e) {
			request.setAttribute("AccessWrong", e.getMessage());
			target = "LivingRoomListServlet";
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
