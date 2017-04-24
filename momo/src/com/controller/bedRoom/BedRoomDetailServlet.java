package com.controller.bedRoom;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

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
		
		ArrayList<String> list = null; // image2, content를 ','를 기준으로 쪼개서 list에 순서대로 담을 것이다.
		
		BedRoomService service = new BedRoomService();
		
		try {
			BedRoomDTO bedRoomDTO = service.bedRoomDetail(Integer.parseInt(bnum));
			
			if(bedRoomDTO.getRegister().equals("o")){
				String image2 = bedRoomDTO.getImage2();
				String content = bedRoomDTO.getContent();
				
				list = new ArrayList<>();
				
				//image2, content는 ','로 쪼갠다.
				StringTokenizer image2Token = new StringTokenizer(image2, ",");
				StringTokenizer contentToken = new StringTokenizer(content, ",");
				
				//토큰에 있는 값들을 list에 add해준다.
				for(int i=0; i<100; i++){
					if(image2Token.hasMoreTokens()){
						String a = image2Token.nextToken();
						list.add(a);
					}
					if(contentToken.hasMoreTokens()){
						String a = contentToken.nextToken();
						list.add(a);
					}else{
						break;
					}
				}
			}
			
			request.setAttribute("bedRoomDTO", bedRoomDTO);
			
			if(list != null) request.setAttribute("list", list);
			
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
