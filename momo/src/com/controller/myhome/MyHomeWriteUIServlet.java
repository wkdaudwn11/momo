package com.controller.myhome;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.member.MemberDTO;
import com.entity.myhome.MyHomeDTO;

@WebServlet("/MyHomeWriteUIServlet")
public class MyHomeWriteUIServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*response.sendRedirect("myHome/myHomeWrite.jsp");*/
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		
		String curPage = request.getParameter("curPage");
		String hnum = request.getParameter("hnum");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		// 주문내역에서 체크 된 것들을 가져오는 배열 (checkedProduct[0]에 다 들어가 있음. ','를 기준으로 ex: 10,9,8,7)
		String[] checkedProduct = null;
		
		// checkedProduct[0]에 들어가 있는 값을 담을 String 변수
		String checkedProductChangeString = null;
		
		// 주문내역에서 체크 된 상품들의 상품번호를 담을 배열
		String realCheckedProduct[] = new String[100];
		
		if(request.getParameterValues("checkedProduct") != null){
			
			checkedProduct = request.getParameterValues("checkedProduct");
			checkedProductChangeString = checkedProduct[0];
			
			StringTokenizer st1 = new StringTokenizer(checkedProductChangeString, ",");
			
			for(int i=0; i<realCheckedProduct.length; i++){
		        if(st1.hasMoreTokens()){
		        	realCheckedProduct[i] = st1.nextToken();
		        }else{
		        	break;
		        }
			}
		}
		
		if(curPage != null){   // 업데이트 일경우
			MyHomeDTO myHomeDTO = new MyHomeDTO();
			myHomeDTO.setId(member.getId());
			myHomeDTO.setAuthor(member.getName());
			myHomeDTO.setHnum(Integer.parseInt(hnum));
			myHomeDTO.setTitle(title);
			myHomeDTO.setContent(content);
			
			request.setAttribute("MyHomeDTO", myHomeDTO);
			request.setAttribute("curPage", curPage);
		}
		
		request.setAttribute("title", title);
		request.setAttribute("content", content);
		
		// 주문내역에서 선택한 값들을 리퀘스트 스코프에 저장
		request.setAttribute("realCheckedProduct", realCheckedProduct);
		
		RequestDispatcher dis = request.getRequestDispatcher("myHome/myHomeWrite.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
