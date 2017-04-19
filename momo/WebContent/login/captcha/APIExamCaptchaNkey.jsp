<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

	<%!String clientId = "QCcfC4gW8cTf_EFfgjEO"; //애플리케이션 클라이언트 아이디값";
	String clientSecret = "_fxFUv2m1o"; //애플리케이션 클라이언트 시크릿값";%>
	<%
		try {
			String code = "0"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
			String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
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
				if(i != 3){
					st1.nextToken();
				}else{
					captchaKey = st1.nextToken();
				}
			}
			
			HttpSession session2 = request.getSession();
			session2.setAttribute("captchaKey", captchaKey);
			
		} catch (Exception e) {
			System.out.println(e);
		}
	%>

</body>
</html>