package com.entity.freeboard;

import java.util.List;

public class FreeBoardPageDTO {
	private List<FreeBoardDTO> freeBoardList;
	private int curPage;
	private int perPage = 10; // 페이지당 보여줄 레코드 수
	private int page = 10; // 표시할 페이지 수
	private int totalRecord;
	
	public FreeBoardPageDTO(){}

	public FreeBoardPageDTO(List<FreeBoardDTO> freeBoardList, int curPage, int perPage, int totalRecord) {
		this.freeBoardList = freeBoardList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalRecord = totalRecord;
	}

	public List<FreeBoardDTO> getFreeBoardList() {
		return freeBoardList;
	}

	public void setFreeBoardList(List<FreeBoardDTO> freeBoardList) {
		this.freeBoardList = freeBoardList;
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
		return "freeBoardPage [freeBoardList=" + freeBoardList + ", curPage=" + curPage + ", perPage=" + perPage
				+ ", totalRecord=" + totalRecord + "]";
	}
	
}// end freeBoardPage
