package com.entity.cart;

import java.util.List;

public class CartPageDTO {
	private List<CartDTO> cartList;
	private int curPage;
	private int perPage = 10; // 페이지당 보여줄 레코드 수
	private int page = 10; // 표시할 페이지 수
	private int totalRecord;
	
	public CartPageDTO(){}

	public CartPageDTO(List<CartDTO> cartList, int curPage, int perPage, int totalRecord) {
		this.cartList = cartList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalRecord = totalRecord;
	}

	public List<CartDTO> getCartList() {
		return cartList;
	}

	public void setCartList(List<CartDTO> cartList) {
		this.cartList = cartList;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	@Override
	public String toString() {
		return "BedroomPage [BedroomList=" + cartList + ", curPage=" + curPage + ", perPage=" + perPage
				+ ", totalRecord=" + totalRecord + "]";
	}
	
}// end BedroomPage
