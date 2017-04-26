package com.controller.myhome;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.myhome.MyHomeDTO;
import com.service.MyHomeService;

@WebServlet("/MyHomeListServlet")
public class MyHomeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String curPage = request.getParameter("curPage");
		if(curPage == null){
			curPage = "1";
		}
		
		MyHomeService service = new MyHomeService();
		/*MyHomePage myHomePage= service.myHomeList(Integer.parseInt(curPage));*/
		List<MyHomeDTO> myHomeList = service.myHomeList(Integer.parseInt(curPage));
		List<MyHomeDTO> bestMyHomeList = service.bestMyHomeList("MyHomeListServlet");
		
		HttpSession session = request.getSession();
		session.setAttribute("prevPage", "MyHomeListServlet?curPage="+curPage);
		
		request.setAttribute("bestMyHomeList", bestMyHomeList);
		request.setAttribute("MyHomeList", myHomeList);
		request.setAttribute("curPage", curPage);
		RequestDispatcher dis = request.getRequestDispatcher("myHome/myHomeList.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
