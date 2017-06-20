package com.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;

import com.entity.bedRoom.BedRoomDTO;
import com.entity.member.MemberDTO;
import com.service.AdminService;

@WebServlet("/ProductRegisterServlet")
public class ProductRegisterServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		
		String target = "";
		
		BedRoomDTO dto = new BedRoomDTO();
		AdminService service = new AdminService();
		
		// Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();

		// Configure a repository (to ensure a secure temp location is used)
		ServletContext servletContext = this.getServletConfig().getServletContext();
		File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
		factory.setRepository(repository);

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		// Parse the request
		List<FileItem> items = null;
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		
		if(login != null){
			if(login.getId().equals("admin")){
				
				List<FileItem> fileList = new ArrayList<FileItem>(); //내용의 실제 파일(들)의 정보를 담을 list (폴더에 사진 저장)
				ArrayList<String> fileNameList = new ArrayList<String>(); // 내용의 실제 파일(들)의 이름을 담을 list (DB에 합쳐서 이름 저장)
				ArrayList<String> contentList = new ArrayList<String>(); // 내용(들)을 담을 list (DB에 합쳐서 저장)
				
				//dto에 값 저장 및 list에 값 저장
				for(FileItem item : items){
					
					String name = item.getFieldName();
					
					if(item.isFormField()){	// type="file"일 때
						if(name.equals("category")){
							dto.setCategory(item.getString("UTF-8"));
						}else if(name.equals("name")){
							dto.setName(item.getString("UTF-8"));
						}else if(name.equals("content")){
							contentList.add(item.getString("UTF-8"));
						}else if(name.equals("price")){
							dto.setPrice(Integer.parseInt(item.getString("UTF-8")));
						}else if(name.equals("discount")){
							dto.setDiscount(Integer.parseInt(item.getString("UTF-8")));
						}
					}else{ // type="file"이 아닐 때
						if(name.equals("upfile")){ //대표사진
							dto.setImage1(item.getName());
							fileList.add(item);
						}else if(name.equals("upfileContent") && !(item.getName().equals(""))){ // 내용의 사진들
							fileNameList.add(item.getName()); // 사진들의 이름을 저장
							fileList.add(item);
						}
					}//if(item.isFormField())
					
				}//for(FileItem item : items)
				
				dto.setBnum(service.getPolderNum()+1);
				
				// list에 들어 있는 값들 사이에 ','를 넣어서 dto에 저장
				dto.setContent(StringUtils.join(contentList, ","));
				dto.setImage2(StringUtils.join(fileNameList, ","));
				
				//db에 insert하기
				service.productInsert(dto);
				
				//사진 저장하기 시작
				if(!fileList.isEmpty()){
					
					String filePath = "c:\\ProductRegisterImg\\"+dto.getBnum()+"_"+dto.getName();
					
					for(FileItem img : fileList){
						
						//폴더가 없으면 생성
						if(!new File(filePath).exists()){
							new File(filePath).mkdir();
						}
						
						try {
							//사진 저장 (저장 할 경로, 사진명)
							File file = new File(filePath, img.getName());
							img.write(file);
						} catch (Exception e) {
							e.printStackTrace();
						}
						
					}
				} // end if
				//사진 저장하기 끝
				
				target = "IndexServlet"; // 바꿔야함.
			}else{
				target = "IndexServlet";
				request.setAttribute("message", "잘못된 접근입니다!");
			}
		}else{
			target = "IndexServlet";
			request.setAttribute("message", "잘못된 접근입니다!");
		}
		
		/*RequestDispatcher dis = request.getRequestDispatcher(target);
		dis.forward(request, response);*/
		
		response.sendRedirect(target);
		
	}//doGet()

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
