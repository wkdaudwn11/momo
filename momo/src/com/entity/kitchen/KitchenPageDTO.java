package com.entity.kitchen;

import java.util.List;

public class KitchenPageDTO {
	private List<KitchenDTO> kitchenList;
	private int curPage;
	private int perPage = 9; // 페이지당 보여줄 레코드 수
	private int page = 10; // 표시할 페이지 수
	private int totalRecord;
	
	public KitchenPageDTO(){}

	public KitchenPageDTO(List<KitchenDTO> kitchenList, int curPage, int perPage, int page, int totalRecord) {
		this.kitchenList = kitchenList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.page = page;
		this.totalRecord = totalRecord;
	}

	public List<KitchenDTO> getKitchenList() {
		return kitchenList;
	}

	public void setKitchenList(List<KitchenDTO> kitchenList) {
		this.kitchenList = kitchenList;
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
		return "KitchenPageDTO [kitchenList=" + kitchenList + ", curPage=" + curPage + ", perPage=" + perPage
				+ ", page=" + page + ", totalRecord=" + totalRecord + "]";
	}

	
	
}// end KitchenPage
