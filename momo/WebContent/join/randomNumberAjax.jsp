<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.entity.order.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.dao.MySqlSessionFactory"%>

<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.auth.AuthScope"%>
<%@page import="org.apache.http.auth.UsernamePasswordCredentials"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.client.CredentialsProvider"%>
<%@page import="org.apache.http.impl.client.BasicCredentialsProvider"%>
<%@page import="org.apache.http.impl.client.BasicAuthCache"%>
<%@page import="org.apache.http.impl.auth.BasicScheme"%>
<%@page import="org.apache.http.client.AuthCache"%>
<%@page import="org.apache.http.HttpHost"%>
<%@page import="org.apache.http.client.protocol.HttpClientContext"%>

<%!
	public static final String appid = "momoApp";
	public static final String apikey = "d7fd1fc6141a11e7ad4f0cc47a1fcfae"; //d7fd1fc6141a11e7ad4f0cc47a1fcfae
	public static final String content = "ㅋ";
	public static final String sender = "01080107913";
	public static final String receiver = "ㅋ"; 
%>

<%
	request.setCharacterEncoding("UTF-8");

	String usertel = request.getParameter("usertel");
	String confirmNumber = "";
	
	//랜덤으로 인증번호 6자리 생성
	for(int i=0; i<6; i++){
		int randomNum = (int)(Math.random() * 10);
		confirmNumber += randomNum;
	}
	
	System.out.println(confirmNumber);
	
	//인증번호를 세션에 저장.
	HttpSession session123 = request.getSession();
	session123.setAttribute("confirmNumber", confirmNumber);
	
	String hostname = "api.bluehouselab.com";
    String url = "https://"+hostname+"/smscenter/v1.0/sendsms";

    CredentialsProvider credsProvider = new BasicCredentialsProvider();
    credsProvider.setCredentials(
        new AuthScope(hostname, 443, AuthScope.ANY_REALM),
        new UsernamePasswordCredentials(appid, apikey)
    );

    // Create AuthCache instance
    AuthCache authCache = new BasicAuthCache();
    authCache.put(new HttpHost(hostname, 443, "https"), new BasicScheme());

    // Add AuthCache to the execution context
    HttpClientContext context = HttpClientContext.create();
    context.setCredentialsProvider(credsProvider);
    context.setAuthCache(authCache);

    DefaultHttpClient client = new DefaultHttpClient();

    try {
        HttpPost httpPost = new HttpPost(url);
        httpPost.setHeader("Content-type", "application/json; charset=utf-8");
        String json = "{\"sender\":\""+sender+"\",\"receivers\":[\""+usertel+"\"],\"content\":\""+"[momo가구] 인증번호: "+confirmNumber+"\"}";

        StringEntity se = new StringEntity(json, "UTF-8");
        httpPost.setEntity(se);

        HttpResponse httpResponse = client.execute(httpPost, context);
        System.out.println(httpResponse.getStatusLine().getStatusCode());

        InputStream inputStream = httpResponse.getEntity().getContent();
        if(inputStream != null) {
            BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(inputStream));
            String line = "";
            while((line = bufferedReader.readLine()) != null)
                System.out.println(line);
            inputStream.close();
        }
    } catch (Exception e) {
        System.err.println("Error: "+e.getLocalizedMessage());
    } finally {
        client.getConnectionManager().shutdown();
    }
%>