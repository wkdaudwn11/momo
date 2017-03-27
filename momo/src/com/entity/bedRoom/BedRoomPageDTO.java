package com.entity.bedRoom;

import java.util.List;

public class BedRoomPageDTO {
	private List<BedRoomDTO> BedRoomList;
	private int curPage;
	private int perPage = 9; // 페이지당 보여줄 레코드 수
	private int page = 10; // 표시할 페이지 수
	private int totalRecord;
	
	public BedRoomPageDTO(){}

	public BedRoomPageDTO(List<BedRoomDTO> BedRoomList, int curPage, int perPage, int totalRecord) {
		this.BedRoomList = BedRoomList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalRecord = totalRecord;
	}

	public List<BedRoomDTO> getBedRoomList() {
		return BedRoomList;
	}

	public void setBedRoomList(List<BedRoomDTO> BedRoomList) {
		this.BedRoomList = BedRoomList;
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
		return "BedRoomPage [BedRoomList=" + BedRoomList + ", curPage=" + curPage + ", perPage=" + perPage
				+ ", totalRecord=" + totalRecord + "]";
	}
	
}// end BedRoomPage
