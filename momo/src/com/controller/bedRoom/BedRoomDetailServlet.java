package com.controller.bedRoom;

import java.io.IOException;
import java.util.HashSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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
		System.out.println("베드룸 디테일 넘어온 bnum ="+bnum);////////////////////////////////////////////
		Cookie[] cookies = request.getCookies();
		boolean noneCookie = true;
		for(int i =0;i<cookies.length;i++){
			if(cookies[i].getName().equals("bnum")){
				noneCookie = false;
			}
		}
		Cookie cookie = null;
		if(noneCookie){
			cookie = new Cookie(bnum,bnum);
			/*cookie.setMaxAge(24*60*60);*////////////////////////////////////////////////
			cookie.setMaxAge(60);
		}
		System.out.println("베드룸디테일 셋팅된 쿠키 네임 ="+cookie.getName());/////////////////////////////////////
		System.out.println("베드룸 셋팅된 쿠키 밸류 ="+cookie.getValue());/////////////////////////////////////
		
		BedRoomService service = new BedRoomService();
		try {
			BedRoomDTO bedRoomDTO = service.bedRoomDetail(Integer.parseInt(bnum));
			request.setAttribute("bedRoomDTO", bedRoomDTO);
			target="bedRoom/bedRoomDetail.jsp";
			
			HttpSession session = request.getSession();
			session.setAttribute("prevPage", "BedRoomDetailServlet?bnum="+bnum);
			
			response.setCharacterEncoding("text/html;charSet=UTF-8");
			response.addCookie(cookie);
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
