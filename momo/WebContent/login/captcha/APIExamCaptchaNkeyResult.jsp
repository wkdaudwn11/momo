<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@page import="java.util.StringTokenizer"%>


	<%!String clientId = "QCcfC4gW8cTf_EFfgjEO"; //애플리케이션 클라이언트 아이디값";
	String clientSecret = "_fxFUv2m1o"; //애플리케이션 클라이언트 시크릿값";%>

	<%
		try {
			String code = "1"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
			String key = request.getParameter("captchakey"); // 캡차 키 발급시 받은 키값
			String value = request.getParameter("captchaUserInput"); // 사용자가 입력한 캡차 이미지 글자값
			System.out.println("value: " + value);
			String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code + "&key=" + key + "&value="+ value;

			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response2 = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response2.append(inputLine);
			}
			br.close();
			System.out.println(response2.toString());
			
			StringTokenizer st1 = new StringTokenizer(response2.toString(), "\"");
			String captchaKey = "";
			
			for(int i=0; i<5; i++){
				if(i != 2){
					st1.nextToken();
				}else{
					captchaKey = st1.nextToken();
				}
			}
			
			if(captchaKey.equals(":true,")){
				out.println("성공");
			}else if(captchaKey.equals(":false,")){
				out.println("실패");
			}else{
				out.println("에러");
			}
			
		} catch (Exception e) {
			System.out.println(e);
		}
	%>
