package com.entity.order;

public class OrderDTO {
	private int onum;					//주문번호
	private int groupnum;				//그룹번호
	private String id;					//회원아이디
	private int pnum;					//상품번호
	private String category;			//해당 상품의 테이블명
	private String pname;				//상품명
	private int count;					//주문갯수
	private	int price;					//주문가격
	private int discount;				//할인율
	private String orderdate;			//주문날짜
	private String image1;				//상품사진
	private String orderMessage;		//주문메세지
	private String orderstate;			//주문상태
	private int equalGroupCount;		//같은 그룹번호 상품의 갯수 
	private int equalGroupTotalPrice;	//같은 그룹번호 상품의 총 가격
	private int equalGroupTotalCount;	//같은 그룹번호 상품의 총 갯수
	
	public OrderDTO() {}

	public OrderDTO(int onum, int groupnum, String id, int pnum, String category, String pname, int count, int price,
			int discount, String orderdate, String image1, String orderMessage, String orderstate, int equalGroupCount,
			int equalGroupTotalPrice, int equalGroupTotalCount) {
		this.onum = onum;
		this.groupnum = groupnum;
		this.id = id;
		this.pnum = pnum;
		this.category = category;
		this.pname = pname;
		this.count = count;
		this.price = price;
		this.discount = discount;
		this.orderdate = orderdate;
		this.image1 = image1;
		this.orderMessage = orderMessage;
		this.orderstate = orderstate;
		this.equalGroupCount = equalGroupCount;
		this.equalGroupTotalPrice = equalGroupTotalPrice;
		this.equalGroupTotalCount = equalGroupTotalCount;
	}

	public int getOnum() {
		return onum;
	}

	public void setOnum(int onum) {
		this.onum = onum;
	}

	public int getGroupnum() {
		return groupnum;
	}

	public void setGroupnum(int groupnum) {
		this.groupnum = groupnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getOrderMessage() {
		return orderMessage;
	}

	public void setOrderMessage(String orderMessage) {
		this.orderMessage = orderMessage;
	}

	public String getOrderstate() {
		return orderstate;
	}

	public void setOrderstate(String orderstate) {
		this.orderstate = orderstate;
	}

	public int getEqualGroupCount() {
		return equalGroupCount;
	}

	public void setEqualGroupCount(int equalGroupCount) {
		this.equalGroupCount = equalGroupCount;
	}

	public int getEqualGroupTotalPrice() {
		return equalGroupTotalPrice;
	}

	public void setEqualGroupTotalPrice(int equalGroupTotalPrice) {
		this.equalGroupTotalPrice = equalGroupTotalPrice;
	}

	public int getEqualGroupTotalCount() {
		return equalGroupTotalCount;
	}

	public void setEqualGroupTotalCount(int equalGroupTotalCount) {
		this.equalGroupTotalCount = equalGroupTotalCount;
	}

	@Override
	public String toString() {
		return "OrderDTO [onum=" + onum + ", groupnum=" + groupnum + ", id=" + id + ", pnum=" + pnum + ", category="
				+ category + ", pname=" + pname + ", count=" + count + ", price=" + price + ", discount=" + discount
				+ ", orderdate=" + orderdate + ", image1=" + image1 + ", orderMessage=" + orderMessage + ", orderstate="
				+ orderstate + ", equalGroupCount=" + equalGroupCount + ", equalGroupTotalPrice=" + equalGroupTotalPrice
				+ ", equalGroupTotalCount=" + equalGroupTotalCount + "]";
	}

	
} //// end Class
