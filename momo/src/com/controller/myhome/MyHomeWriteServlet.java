package com.controller.myhome;

import java.io.File; 
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.imageio.stream.FileImageInputStream;
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

import com.entity.member.MemberDTO;
import com.entity.myhome.MyHomeDTO;
import com.exception.LoginFailException;
import com.service.MyHomeService;

@WebServlet("/MyHomeWriteServlet")
public class MyHomeWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MyHomeDTO myHomeDTO = new MyHomeDTO();
		MyHomeService service = new MyHomeService();
		
		MemberDTO member = (MemberDTO)session.getAttribute("login"); 
		String curPage = null;
		String target = null;
		
		String filePath = "C:\\MyHomeImg";
		
		try{
			if(member != null){
				// Create a factory for disk-based file items
				DiskFileItemFactory factory = new DiskFileItemFactory();
		
				// Configure a repository (to ensure a secure temp location is used)
				ServletContext servletContext = this.getServletConfig().getServletContext();
				File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
				factory.setRepository(repository);
		
				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);
				// Parse the request
				List<FileItem> items =null;
				try {
					items = upload.parseRequest(request);
				} catch (FileUploadException e) {
					e.printStackTrace();
				}
				
				List<FileItem> fileList = new ArrayList<FileItem>();
				ArrayList<String> fileNameList = new ArrayList<String>();
				boolean fileExist = true;
				
				for(FileItem item : items){
					if(item.isFormField()){
						String name = item.getFieldName();
						String value = item.getString("UTF-8");
						if(name.equals("title")){ myHomeDTO.setTitle(value);}else
						if(name.equals("content")){ myHomeDTO.setContent(value);}else
						if(name.equals("author")){ myHomeDTO.setAuthor(value);}else
						if(name.equals("hnum")){ myHomeDTO.setHnum(Integer.parseInt(value)); }else
						if(name.equals("curPage")){ curPage = value; }else
						if(name.equals("orderList")){ myHomeDTO.setOrderList(value); } /////////////////////
					}else{
						if(!item.getName().equals("")){
							fileList.add(item); // 파일 만들때 쓰기위한 fileItem 리스트
							fileNameList.add(member.getId()+"_"+item.getName()); // DB 에 저장할 이미지 파일 이름.
						}
					}
				} // end for
				
				myHomeDTO.setId(member.getId());
				myHomeDTO.setImg(StringUtils.join(fileNameList, ","));
				
				if(curPage == null){ 
					service.myHomeInsert(myHomeDTO);
					target = "MyHomeListServlet";
				}else{
					String deleteList = service.detailMyHome(myHomeDTO.getHnum()).getImg();
					List<String> deleteImgList = Arrays.asList(deleteList.split(","));
					
					for(String img : deleteImgList){
						File imgFile = new File(filePath,img);
						imgFile.delete();
					}
					
					service.myHomeUpdate(myHomeDTO);
					target = "MyHomeListServlet?curPage="+curPage;
				}
				
				if(!fileList.isEmpty()){
					for(FileItem img : fileList){
						File file = new File(filePath, member.getId()+"_"+img.getName());
						img.write(file);
					}
				} // end if
				
			}else{
				throw new LoginFailException();
			}
		}catch(Exception e){
			e.printStackTrace();
			/*request.setAttribute("loginFail",e.getMessage());*/
			target = "LoginUIServlet";
		}
		
		response.sendRedirect(target);
		
	}// end doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
