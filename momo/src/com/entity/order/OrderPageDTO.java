package com.entity.order;

import java.util.List;

public class OrderPageDTO {
	private List<OrderDTO> orderList;
	private int curPage;
	private int perPage = 10;	//페이지당 보여줄 레코드 수
	private int page = 10;		//표시할 페이지 수
	private int totalRecord;	//전체 레코드 수
	private int totalRecordDistinct;	//groupnum의 중복값을 제거한 전체 레코드 수 
	
	public OrderPageDTO(){}

	public OrderPageDTO(List<OrderDTO> orderList, int curPage, int perPage, int page, int totalRecord,
			int totalRecordDistinct) {
		super();
		this.orderList = orderList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.page = page;
		this.totalRecord = totalRecord;
		this.totalRecordDistinct = totalRecordDistinct;
	}

	@Override
	public String toString() {
		return "OrderPageDTO [orderList=" + orderList + ", curPage=" + curPage + ", perPage=" + perPage + ", page="
				+ page + ", totalRecord=" + totalRecord + ", totalRecordDistinct=" + totalRecordDistinct + "]";
	}

	public List<OrderDTO> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<OrderDTO> orderList) {
		this.orderList = orderList;
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

	public int getTotalRecordDistinct() {
		return totalRecordDistinct;
	}

	public void setTotalRecordDistinct(int totalRecordDistinct) {
		this.totalRecordDistinct = totalRecordDistinct;
	}

}// end BedRoomPage
