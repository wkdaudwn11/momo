package com.entity.childrenRoom;

import java.util.List;

public class ChildrenRoomPageDTO {
	private List<ChildrenRoomDTO> childrenRoomList;
	private int curPage;
	private int perPage = 9; // 페이지당 보여줄 레코드 수
	private int page = 10; // 표시할 페이지 수
	private int totalRecord;
	
	public ChildrenRoomPageDTO(){}

	public ChildrenRoomPageDTO(List<ChildrenRoomDTO> childrenRoomList, int curPage, int perPage, int page,
			int totalRecord) {
		this.childrenRoomList = childrenRoomList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.page = page;
		this.totalRecord = totalRecord;
	}

	public List<ChildrenRoomDTO> getChildrenRoomList() {
		return childrenRoomList;
	}

	public void setChildrenRoomList(List<ChildrenRoomDTO> childrenRoomList) {
		this.childrenRoomList = childrenRoomList;
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
		return "ChildrenRoomPageDTO [childrenRoomList=" + childrenRoomList + ", curPage=" + curPage + ", perPage="
				+ perPage + ", page=" + page + ", totalRecord=" + totalRecord + "]";
	}

	
	
	
}// end ChildrenRoomPage
