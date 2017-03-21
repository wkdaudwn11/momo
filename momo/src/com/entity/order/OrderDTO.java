package com.entity.order;

public class OrderDTO {
	private int onum;			//주문번호
	private int pnum;			//상품번호
	private String category;	//해당 상품의 테이블명
	private String pname;		//상품명
	private int count;			//주문갯수
	private	int price;			//주문가격
	private int discount;		//할인율
	private String orderdate;	//주문날짜
	private String image1;		//상품사진
	private String username;	//회원명
	private String id;			//회원아이디
	private String tel;			//회원전화번호
	private String post1;		//우편번호1
	private String post2;		//우편번호2
	private String addr1;		//상세주소1
	private String addr2;		//상세주소2
	private String orderstate;	//주문상태
	private String orderMessage;//주문메세지
	
	public OrderDTO() {
		super();
	}

	public OrderDTO(int onum, int pnum, String category, String pname, int count, int price, int discount,
			String orderdate, String image1, String username, String id, String tel, String post1, String post2,
			String addr1, String addr2, String orderstate, String orderMessage) {
		super();
		this.onum = onum;
		this.pnum = pnum;
		this.category = category;
		this.pname = pname;
		this.count = count;
		this.price = price;
		this.discount = discount;
		this.orderdate = orderdate;
		this.image1 = image1;
		this.username = username;
		this.id = id;
		this.tel = tel;
		this.post1 = post1;
		this.post2 = post2;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.orderstate = orderstate;
		this.orderMessage = orderMessage;
	}

	@Override
	public String toString() {
		return "OrderDTO [onum=" + onum + ", pnum=" + pnum + ", category=" + category + ", pname=" + pname + ", count="
				+ count + ", price=" + price + ", discount=" + discount + ", orderdate=" + orderdate + ", image1="
				+ image1 + ", username=" + username + ", id=" + id + ", tel=" + tel + ", post1=" + post1 + ", post2="
				+ post2 + ", addr1=" + addr1 + ", addr2=" + addr2 + ", orderstate=" + orderstate + ", orderMessage="
				+ orderMessage + "]";
	}

	public int getOnum() {
		return onum;
	}

	public void setOnum(int onum) {
		this.onum = onum;
	}

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public String getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
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

	public String getOrderstate() {
		return orderstate;
	}

	public void setOrderstate(String orderstate) {
		this.orderstate = orderstate;
	}

	public String getOrderMessage() {
		return orderMessage;
	}

	public void setOrderMessage(String orderMessage) {
		this.orderMessage = orderMessage;
	}

}
