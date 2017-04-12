<%@page import="com.entity.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.internet.MimeUtility"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!String host = "smtp.naver.com";
	String subject = "안녕하세요. momo가구 입니다.";
	String from = "wkdaudwn11@naver.com"; //보내는 사람의 메일주소
	String passwd = "qjffp0101";%>
	<%
	MemberDTO memberDTO = (MemberDTO)application.getAttribute("memberDTO");
	String to = memberDTO.getEmail(); //받는 사람의 메일주소
	String fromName = memberDTO.getName();	//받는 사람의 이름
	String content = "아래의 링크를 클릭해주세요. \n <a href='http:\\localhost:8090/momo/EmailConfirmServlet'>[momo] 이메일 인증하기 </a>";
		try {
			//프로퍼티 값 인스턴스 생성과 기본세션(SMTP 서버 호스트 지정)
			Properties props = new Properties();
			//네이버 SMTP 사용시
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", host);

			props.put("mail.smtp.port", "465"); // 보내는 메일 포트 설정
			props.put("mail.smtp.user", from);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.debug", "true");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");

			// Authenticator auth = new SendMail();
			Authenticator auth = new SMTPAuthenticator();
			//Session mailSession = Session.getDefaultInstance(props,auth);
			Session mailSession = Session.getInstance(props, auth);
			mailSession.setDebug(true);
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B"))); //보내는 사람 설정
			InternetAddress[] address = { new InternetAddress(to) };

			msg.setRecipients(Message.RecipientType.TO, address); //받는 사람설정

			msg.setSubject(subject); //제목설정
			msg.setSentDate(new java.util.Date()); //보내는 날짜 설정
			msg.setContent(content, "text/html; charset=UTF-8"); //내용 설정(MIME 지정-HTML 형식)

			Transport.send(msg); //메일 보내기

			System.out.println("메일 발송을 완료하였습니다.");
		} catch (MessagingException ex) {
			System.out.println("mail send error : " + ex.getMessage());
			ex.printStackTrace();
		} catch (Exception e) {
			System.out.println("error : " + e.getMessage());
			e.printStackTrace();
		}
	%>
	<%!private class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(from, passwd);
		}
	}%>
</body>
</html>