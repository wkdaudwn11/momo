package com.controller.kitchen;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.kitchen.KitchenPageDTO;
import com.exception.CommonException;
import com.service.KitchenService;


@WebServlet("/KitchenListServlet")
public class KitchenListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String category = request.getParameter("category");
		if(category == null) category = "0";
		
		HashMap<String, String> map = new HashMap<>();
		map.put("category", category);
		
		String sortValue = request.getParameter("sortValue");
		if(sortValue == null) sortValue = "knum";
		
		String curPage = request.getParameter("curPage");
		if(curPage == null) curPage="1";

		KitchenService service = new KitchenService();
		String target = "";
		
		try {
			KitchenPageDTO kitchenPageDTO = service.kitchenList(Integer.parseInt(curPage), map, sortValue);
			KitchenPageDTO bestKitchenPageDTO = service.bestKitchenList();
			
			request.setAttribute("KitchenPageDTO", kitchenPageDTO);	//상품 리스트
			request.setAttribute("bestKitchenPageDTO", bestKitchenPageDTO);	// 인기상품 베스트3 리스트
			request.setAttribute("category", category);
			request.setAttribute("sortValue", sortValue);
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "KitchenListServlet?curPage="+curPage+"&category="+category+"&sortValue="+sortValue);
			
			target = "kitchen/kitchenList.jsp";
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
