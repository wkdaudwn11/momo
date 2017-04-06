package com.controller.myhome;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
		String curPage = request.getParameter("curPage");
		String target = null;
		
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
				
				ArrayList<String> sampleList = new ArrayList<>();
				
				for(FileItem item : items){
					if(item.isFormField()){
						String name = item.getFieldName();
						String value = item.getString("UTF-8");
						if(name.equals("title")){ myHomeDTO.setTitle(value);}else
						if(name.equals("content")){ myHomeDTO.setContent(value);}else
						if(name.equals("author")){ myHomeDTO.setAuthor(value);}else
						if(name.equals("orderList")){ /*DTO 에 아직 안만들었다. Write에도 미구현*/ }
						
					}else{
						File file = new File("C:\\Users\\user\\Desktop\\MyHomeImg",item.getName());
						// 테스터 PC 에 폴더 만들어야한다.
						try {
							item.write(file);
						} catch (Exception e) {
							e.printStackTrace();
						}
						sampleList.add(item.getName());
					}
				} // end for
				
				myHomeDTO.setId( member.getId() );
				myHomeDTO.setImg( StringUtils.join(sampleList,",") );
				
				service.InsertMyHome(myHomeDTO);
				
				
				target = "MyHomeListServlet";
			}else{
				throw new LoginFailException();
			}
		}catch(Exception e){
			/*request.setAttribute("loginFail",e.getMessage());*/
			target = "LoginUIServlet";
		}
		
		response.sendRedirect(target);
		
	}// end doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
