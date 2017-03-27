package com.controller.bedRoom;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.bedRoom.BedRoomDTO;
import com.exception.CommonException;
import com.service.BedRoomService;

@WebServlet("/BedRoomDetailServlet")
public class BedRoomDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String target = "";
		String bnum = request.getParameter("bnum");
		
		BedRoomService service = new BedRoomService();
		try {
			BedRoomDTO bedRoomDTO = service.bedRoomDetail(Integer.parseInt(bnum));
			request.setAttribute("bedRoomDTO", bedRoomDTO);
			target="bedRoom/bedRoomDetail.jsp";
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "BedRoomDetailServlet?bnum="+bnum);
			
		}catch (CommonException e) {
			request.setAttribute("AccessWrong", e.getMessage());
			target = "BedRoomListServlet";
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
