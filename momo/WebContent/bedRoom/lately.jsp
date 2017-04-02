<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.bedRoom.BedRoomDTO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	SqlSession sess = MySqlSessionFactory.openSession();
	String curPage = request.getParameter("curPage");
	ArrayList<String> cookieList = new ArrayList<String>();
	Cookie[] cookies = request.getCookies();
	//List<Cookie> cookieList = cookies.subList(1, cookies.size()-1);
	
	//System.out.println("lately.jsp 가져온 쿠키 ="+cookies);
	for(int i =1; i<cookies.length-1;i++){
		//System.out.println("lately.jsp 가져온 쿠키 getName ="+i+"번째"+cookies[i].getName());
		//System.out.println("lately.jsp 가져온 쿠키 getValue ="+i+"번째"+cookies[i].getValue());
		cookieList.add(cookies[i].getName());
	}
	//System.out.println("lately.jsp 쿠키 리스트 = "+cookieList);
	//System.out.println("lately.jsp 쿠키리스트 사이즈 ="+cookieList.size());
	if(cookieList != null && cookieList.size() != 0){
		List<BedRoomDTO> latelyList = sess.selectList("com.momo.BedRoomMapper.latelyList",cookieList);
		//System.out.println("lately.jsp 가져온 lately리스트 ="+latelyList);
%>
<ul>
	<c:forEach var="bedRoomDTO" items="<%=latelyList%>">
		<li><a href="BedRoomDetailServlet?curPage=<%=curPage%>&bnum=${bedRoomDTO.bnum}"><img src="images/bedRoom/${bedRoomDTO.image1}.JPG">${bedRoomDTO.name}<br>${bestBedRoomDTO.price * (1.0 - (bestBedRoomDTO.discount/100))}</a></li>
	</c:forEach>
</ul>
<%
	}
	
%>
