package com.exception;

public class LoginFailException extends Exception {
	
	public LoginFailException(){
		super("로그인 후 이용 할 수 있습니다.");
	}
}
