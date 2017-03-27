package com.entity.childrenRoom;

public class ChildrenRoomDTO {
	private int cnum;
	private String category;
	private String name;
	private String content;
	private int price;
	private int discount;
	private int buycount;
	private String image1;
	private String image2;
	
	public ChildrenRoomDTO() {}

	public ChildrenRoomDTO(int cnum, String category, String name, String content, int price, int discount,
			int buycount, String image1, String image2) {
		this.cnum = cnum;
		this.category = category;
		this.name = name;
		this.content = content;
		this.price = price;
		this.discount = discount;
		this.buycount = buycount;
		this.image1 = image1;
		this.image2 = image2;
	}

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public int getBuycount() {
		return buycount;
	}

	public void setBuycount(int buycount) {
		this.buycount = buycount;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	@Override
	public String toString() {
		return "ChildrenRoomDTO [cnum=" + cnum + ", category=" + category + ", name=" + name + ", content=" + content
				+ ", price=" + price + ", discount=" + discount + ", buycount=" + buycount + ", image1=" + image1
				+ ", image2=" + image2 + "]";
	}

	
	
}
