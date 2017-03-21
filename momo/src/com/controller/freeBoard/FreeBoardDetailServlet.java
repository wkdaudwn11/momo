package com.controller.freeBoard;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.freeboard.FreeBoardDTO;
import com.entity.freeboard.FreeBoardRepleDTO;
import com.exception.AccessWrongException;
import com.service.FreeBoardService;

@WebServlet("/FreeBoardDetailServlet")
public class FreeBoardDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String fnum = request.getParameter("fnum");
		String curPage = request.getParameter("curPage");
		if(curPage == null){curPage="1";}
		
		HttpSession session = request.getSession();
		session.setAttribute("prevPage", "FreeBoardDetailServlet?fnum="+fnum+"&curPage="+curPage);
		
		FreeBoardService service = new FreeBoardService();
		
		String target="";
		
			try {
				if(fnum == null || fnum.equals("null")){
					target="FreeBoardListServlet";
					throw new AccessWrongException();
				}else{
					FreeBoardDTO freeBoardDTO = service.boardDetail(Integer.parseInt(fnum)); //게시물 상제정보
					
					int repleCount = service.repleCount(Integer.parseInt(fnum)); //댓글 갯수

					List<FreeBoardRepleDTO> repleList = service.repleList(Integer.parseInt(fnum)); //댓글 리스트
					
					request.setAttribute("FreeBoardDTO", freeBoardDTO);
					request.setAttribute("curPage",Integer.parseInt(curPage));
					
					request.setAttribute("repleCount", repleCount);
					request.setAttribute("repleList", repleList);
					
					target ="freeBoard/freeBoardDetail.jsp";
				}
			} catch (Exception e) {
				request.setAttribute("AccessWrong", e.getMessage());
			}
		
		RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
