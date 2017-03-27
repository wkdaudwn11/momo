package com.controller.childrenRoom;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.childrenRoom.ChildrenRoomDTO;
import com.exception.CommonException;
import com.service.ChildrenRoomService;

@WebServlet("/ChildrenRoomDetailServlet")
public class ChildrenRoomDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String target = "";
		String cnum = request.getParameter("cnum");
		
		ChildrenRoomService service = new ChildrenRoomService();
		try {
			ChildrenRoomDTO childrenRoomDTO = service.childrenRoomDetail(Integer.parseInt(cnum));
			request.setAttribute("ChildrenRoomDTO", childrenRoomDTO);
			target="childrenRoom/childrenRoomDetail.jsp";
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "ChildrenRoomDetailServlet?cnum="+cnum);
			
		}catch (CommonException e) {
			request.setAttribute("AccessWrong", e.getMessage());
			target = "ChildrenRoomListServlet";
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
