package com.entity.myhome;

import java.util.List;

public class MyHomePage {

	private List<MyHomeDTO> myHomeList;
	private int curPage;
	private int perPage = 9;
	private int page = 5;
	private int totalRecord;
	
	public MyHomePage(){}
	public MyHomePage(List<MyHomeDTO> myHomeList, int curPage, int perPage, int page, int totalRecord) {
		super();
		this.myHomeList = myHomeList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.page = page;
		this.totalRecord = totalRecord;
	}
	public List<MyHomeDTO> getMyHomeList() {
		return myHomeList;
	}
	public void setMyHomeList(List<MyHomeDTO> myHomeList) {
		this.myHomeList = myHomeList;
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
		return "MyHomePage [curPage=" + curPage + ", perPage=" + perPage + ", page=" + page + ", totalRecord="
				+ totalRecord + "]";
	}
	
}// end MyHomePage
