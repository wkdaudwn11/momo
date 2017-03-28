package com.entity.freeboard;

public class FreeBoardDTO {

	private String id;
	private int fnum;
	private String author;
	private String title;
	private String content;
	private String writeday;
	private int readCnt;
	private int goodCnt;
	private int repleCnt;
	
	public FreeBoardDTO(){}

	public FreeBoardDTO(String id, int fnum, String author, String title, String content, String writeday, int readCnt,
			int goodCnt, int repleCnt) {
		this.id = id;
		this.fnum = fnum;
		this.author = author;
		this.title = title;
		this.content = content;
		this.writeday = writeday;
		this.readCnt = readCnt;
		this.goodCnt = goodCnt;
		this.repleCnt = repleCnt;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getFnum() {
		return fnum;
	}

	public void setFnum(int fnum) {
		this.fnum = fnum;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public int getRepleCnt() {
		return repleCnt;
	}

	public void setRepleCnt(int repleCnt) {
		this.repleCnt = repleCnt;
	}

	@Override
	public String toString() {
		return "FreeBoardDTO [id=" + id + ", fnum=" + fnum + ", author=" + author + ", title=" + title + ", content="
				+ content + ", writeday=" + writeday + ", readCnt=" + readCnt + ", goodCnt=" + goodCnt + ", repleCnt="
				+ repleCnt + "]";
	}

	
	
}// end freeBoardDTO
