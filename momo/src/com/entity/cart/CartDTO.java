package com.entity.cart;

public class CartDTO {

	private int cnum;			//카트번호
	private int pnum;			//상품번호
	private String category;	//해당 상품의 테이블명
	private String id;			//회원아이디
	private String name;		//상품명
	private int count;			//상품갯수
	private int price;			//상품가격
	private int discount;		//할인율
	private String cartdate;	//카트에 집어넣은 날짜
	private String image1;		//상품사진
	
	public CartDTO() {
		super();
	}

	public CartDTO(int cnum, int pnum, String category, String id, String name, int count, int price, int discount,
			String cartdate, String image1) {
		super();
		this.cnum = cnum;
		this.pnum = pnum;
		this.category = category;
		this.id = id;
		this.name = name;
		this.count = count;
		this.price = price;
		this.discount = discount;
		this.cartdate = cartdate;
		this.image1 = image1;
	}

	@Override
	public String toString() {
		return "CartDTO [cnum=" + cnum + ", pnum=" + pnum + ", category=" + category + ", id=" + id + ", name=" + name
				+ ", count=" + count + ", price=" + price + ", discount=" + discount + ", cartdate= "+ cartdate +", image1=" + image1 + "]";
	}

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
	
	public String getCartdate() {
		return cartdate;
	}

	public void setCartdate(String cartdate) {
		this.cartdate = cartdate;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}
	
}
