package com.controller.kitchen;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.kitchen.KitchenDTO;
import com.exception.CommonException;
import com.service.KitchenService;

@WebServlet("/KitchenDetailServlet")
public class KitchenDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String target = "";
		String knum = request.getParameter("knum");
		
		KitchenService service = new KitchenService();
		try {
			KitchenDTO kitchenDTO = service.kitchenDetail(Integer.parseInt(knum));
			request.setAttribute("KitchenDTO", kitchenDTO);
			target="kitchen/kitchenDetail.jsp";
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "KitchenDetailServlet?knum="+knum);
			
		}catch (CommonException e) {
			request.setAttribute("AccessWrong", e.getMessage());
			target = "KitchenListServlet";
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
