package com.controller.bedRoom;

import java.io.IOException; 
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.bedRoom.BedRoomPageDTO;
import com.exception.CommonException;
import com.service.BedRoomService;


@WebServlet("/BedRoomListServlet")
public class BedRoomListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String category = request.getParameter("category");
		if(category == null) category = "0";
		
		HashMap<String, String> map = new HashMap<>();
		map.put("category", category);
		
		String sortValue = request.getParameter("sortValue");
		if(sortValue == null) sortValue = "bnum";
		
		String curPage = request.getParameter("curPage");
		if(curPage == null) curPage="1";

		BedRoomService service = new BedRoomService();
		String target = "";
		
		try {
			BedRoomPageDTO bedRoomPageDTO = service.bedRoomList(Integer.parseInt(curPage), map, sortValue);
			BedRoomPageDTO bestBedRoomPageDTO = service.bestBedRoomList(map);
			
			request.setAttribute("bedRoomPageDTO", bedRoomPageDTO);	//상품 리스트
			request.setAttribute("bestBedRoomPageDTO", bestBedRoomPageDTO);	// 인기상품 베스트3 리스트
			request.setAttribute("category", category);
			request.setAttribute("sortValue", sortValue);
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "BedRoomListServlet?curPage="+curPage+"&category="+category+"&sortValue="+sortValue);
			
			target = "bedRoom/bedRoomList.jsp";
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
