package com.entity.member;

/** member 테이블의 속성을 갖고 있는 DTO클래스 */
public class MemberDTO {
	private int mnum;
	private String name;
	private String id;
	private String pwd;
	private String pwd2;
	private String gender;
	private String tel;
	private String question;
	private String answer;
	private String post1;
	private String post2;
	private String addr1;
	private String addr2;
	private String joindate;
	private String logindate;
	private int orderPrice;
	private int progressingorder;
	private String sns;
	
	public MemberDTO() {
		super();
	}

	public MemberDTO(int mnum, String name, String id, String pwd, String pwd2, String gender, String tel,
			String question, String answer, String post1, String post2, String addr1, String addr2, String joindate,
			String logindate, int orderPrice, int progressingorder, String sns) {
		super();
		this.mnum = mnum;
		this.name = name;
		this.id = id;
		this.pwd = pwd;
		this.pwd2 = pwd2;
		this.gender = gender;
		this.tel = tel;
		this.question = question;
		this.answer = answer;
		this.post1 = post1;
		this.post2 = post2;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.joindate = joindate;
		this.logindate = logindate;
		this.orderPrice = orderPrice;
		this.progressingorder = progressingorder;
		this.sns = sns;
	}

	@Override
	public String toString() {
		return "MemberDTO [mnum=" + mnum + ", name=" + name + ", id=" + id + ", pwd=" + pwd + ", pwd2=" + pwd2
				+ ", gender=" + gender + ", tel=" + tel + ", question=" + question + ", answer=" + answer + ", post1="
				+ post1 + ", post2=" + post2 + ", addr1=" + addr1 + ", addr2=" + addr2 + ", joindate=" + joindate
				+ ", logindate=" + logindate + ", orderPrice=" + orderPrice + ", progressingorder=" + progressingorder
				+ ", sns=" + sns + "]";
	}

	public int getMnum() {
		return mnum;
	}

	public void setMnum(int mnum) {
		this.mnum = mnum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getPwd2() {
		return pwd2;
	}

	public void setPwd2(String pwd2) {
		this.pwd2 = pwd2;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getPost1() {
		return post1;
	}

	public void setPost1(String post1) {
		this.post1 = post1;
	}

	public String getPost2() {
		return post2;
	}

	public void setPost2(String post2) {
		this.post2 = post2;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getJoindate() {
		return joindate;
	}

	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}

	public String getLogindate() {
		return logindate;
	}

	public void setLogindate(String logindate) {
		this.logindate = logindate;
	}

	public int getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}

	public int getProgressingorder() {
		return progressingorder;
	}

	public void setProgressingorder(int progressingorder) {
		this.progressingorder = progressingorder;
	}

	public String getSns() {
		return sns;
	}

	public void setSns(String sns) {
		this.sns = sns;
	}

}
