<%@page import="com.entity.myhome.MyHomeDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.service.MyHomeService"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String curPage = request.getParameter("curPage");

	MyHomeService service = new MyHomeService();
	List<MyHomeDTO> myHomeList = service.addList(Integer.parseInt(curPage));
	
	if(myHomeList.size() != 0){
%>
<div class="content_22">
	<div class="contents_22_product">
		<ul class="contents_22_product_images">
			<c:forEach var="myHomeDTO" items="<%=myHomeList%>" varStatus="status">
				<c:if test="${myHomeDTO.img == null}">
					<c:set var="mainImg" value="" />
				</c:if>
				<c:forTokens var="img" items="${myHomeDTO.img}" delims=","
					varStatus="imgSts">
					<c:if test="${imgSts.index == 0}">
						<c:set var="mainImg" value="${img}" />
					</c:if>
				</c:forTokens>

				<li>
					<div class="img">
						<a
							href="MyHomeDetailServlet?hnum=${myHomeDTO.hnum}&curPage=<%=curPage%>">
							<c:if test="${myHomeDTO.img != null}">
								<img src="images/${mainImg}" />
							</c:if> <c:if test="${myHomeDTO.img == null }">
								<img src="images/ImgNotFound.png" />
							</c:if>
							<div class="desc">
								<b> ${myHomeDTO.title}<br>
								</b>
							</div>
						</a>
					</div>
				</li>
<c:if test="${status.count % 3 == 0}">
		</ul>
	</div>
</div>
<div id="content_22">
	<div class="contents_22_product">
		<ul class="contents_22_product_images">
</c:if>
</c:forEach>
		</ul><!-- contents_2_product_images -->
	</div><!-- contents_2_product -->
</div><!-- contents_22 -->
<%}%>