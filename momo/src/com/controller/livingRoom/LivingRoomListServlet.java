package com.controller.livingRoom;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.livingRoom.LivingRoomPageDTO;
import com.exception.CommonException;
import com.service.LivingRoomService;


@WebServlet("/LivingRoomListServlet")
public class LivingRoomListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String category = request.getParameter("category");
		if(category == null) category = "0";
		
		HashMap<String, String> map = new HashMap<>();
		map.put("category", category);
		
		String sortValue = request.getParameter("sortValue");
		if(sortValue == null) sortValue = "lnum";
		
		String curPage = request.getParameter("curPage");
		if(curPage == null) curPage="1";

		LivingRoomService service = new LivingRoomService();
		String target = "";
		
		try {
			LivingRoomPageDTO livingRoomPage = service.livingRoomList(Integer.parseInt(curPage), map, sortValue);
			LivingRoomPageDTO bestLivingRoomPage = service.bestLivingRoomList();
			
			request.setAttribute("LivingRoomPageDTO", livingRoomPage);	//상품 리스트
			request.setAttribute("BestLivingRoomPageDTO", bestLivingRoomPage);	// 인기상품 베스트3 리스트
			request.setAttribute("category", category);
			request.setAttribute("sortValue", sortValue);
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "LivingRoomListServlet?curPage="+curPage+"&category="+category+"&sortValue="+sortValue);
			
			target = "livingRoom/livingRoomList.jsp";
		} catch (CommonException e) {
			target = "IndexServlet";
			request.setAttribute("message", e.getMessage());
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
