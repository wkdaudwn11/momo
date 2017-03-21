package com.entity.bedroom;

import java.util.List;

public class BedroomPageDTO {
	private List<BedroomDTO> BedroomList;
	private int curPage;
	private int perPage = 9; // 페이지당 보여줄 레코드 수
	private int page = 10; // 표시할 페이지 수
	private int totalRecord;
	
	public BedroomPageDTO(){}

	public BedroomPageDTO(List<BedroomDTO> BedroomList, int curPage, int perPage, int totalRecord) {
		this.BedroomList = BedroomList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalRecord = totalRecord;
	}

	public List<BedroomDTO> getBedroomList() {
		return BedroomList;
	}

	public void setBedroomList(List<BedroomDTO> BedroomList) {
		this.BedroomList = BedroomList;
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
		return "BedroomPage [BedroomList=" + BedroomList + ", curPage=" + curPage + ", perPage=" + perPage
				+ ", totalRecord=" + totalRecord + "]";
	}
	
}// end BedroomPage
