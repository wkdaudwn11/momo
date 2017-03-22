package com.controller.childrenRoom;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.childrenRoom.ChildrenRoomPageDTO;
import com.exception.CommonException;
import com.service.ChildrenRoomService;


@WebServlet("/ChildrenRoomListServlet")
public class ChildrenRoomListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String category = request.getParameter("category");
		if(category == null) category = "0";
		
		HashMap<String, String> map = new HashMap<>();
		map.put("category", category);
		
		String sortValue = request.getParameter("sortValue");
		if(sortValue == null) sortValue = "cnum";
		
		String curPage = request.getParameter("curPage");
		if(curPage == null) curPage="1";

		ChildrenRoomService service = new ChildrenRoomService();
		String target = "";
		
		try {
			ChildrenRoomPageDTO childrenRoomPageDTO = service.childrenRoomList(Integer.parseInt(curPage), map, sortValue);
			ChildrenRoomPageDTO bestChildrenRoomPageDTO = service.bestChildrenRoomList();
			
			request.setAttribute("ChildrenRoomPageDTO", childrenRoomPageDTO);	//상품 리스트
			request.setAttribute("bestChildrenRoomPageDTO", bestChildrenRoomPageDTO);	// 인기상품 베스트3 리스트
			request.setAttribute("category", category);
			request.setAttribute("sortValue", sortValue);
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "ChildrenRoomListServlet?curPage="+curPage+"&category="+category+"&sortValue="+sortValue);
			
			target = "childrenRoom/childrenRoomList.jsp";
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
