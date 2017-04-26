package com.entity.myhome;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MyHomeDTO {

	private int hnum;
	private String id;
	private String orderList;
	private String title;
	private String img;
	private String content;
	private String author;
	private String writeday;
	private int readCnt;
	private int goodCnt;
	
	public MyHomeDTO(){}
	public MyHomeDTO(int hnum, String id, String orderList, String title, String img, String content, String author,
			String writeday, int readCnt, int goodCnt) {
		this.hnum = hnum;
		this.id = id;
		this.orderList = orderList;
		this.title = title;
		this.img = img;
		this.content = content;
		this.author = author;
		this.writeday = writeday;
		this.readCnt = readCnt;
		this.goodCnt = goodCnt;
	}
	public int getHnum() {
		return hnum;
	}
	public void setHnum(int hnum) {
		this.hnum = hnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderList() {
		return orderList;
	}
	public void setOrderList(String orderList) {
		this.orderList = orderList;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public int getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	public int getGoodCnt() {
		return goodCnt;
	}
	public void setGoodCnt(int goodCnt) {
		this.goodCnt = goodCnt;
	}
	@Override
	public String toString() {
		return "MyHomeDTO [hnum=" + hnum + ", id=" + id + ", orderList=" + orderList + ", title=" + title + ", img="
				+ img + ", content=" + content + ", author=" + author + ", writeday=" + writeday + ", readCnt="
				+ readCnt + ", goodCnt=" + goodCnt + "]";
	}

}// end MyHomeDTO
