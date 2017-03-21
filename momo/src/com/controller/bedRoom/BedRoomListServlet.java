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

import com.entity.bedroom.BedroomPageDTO;
import com.exception.CommonException;
import com.service.BedroomService;


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

		BedroomService service = new BedroomService();
		String target = "";
		
		try {
			BedroomPageDTO bedroomPageDTO = service.bedroomList(Integer.parseInt(curPage), map, sortValue);
			BedroomPageDTO bestBedroomPageDTO = service.bestBedroomList();
			
			request.setAttribute("bedroomPageDTO", bedroomPageDTO);	//상품 리스트
			request.setAttribute("bestBedroomPageDTO", bestBedroomPageDTO);	// 인기상품 베스트3 리스트
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
