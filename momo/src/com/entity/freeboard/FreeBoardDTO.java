package com.entity.freeboard;

public class FreeBoardDTO {

	private int fnum;
	private String id;
	private String author;
	private String title;
	private String content;
	private String writeday;
	private int readCnt;
	private int goodCnt;
	private int repleCnt;
	
	public FreeBoardDTO(){}

	public FreeBoardDTO(int fnum, String id, String author, String title, String content, String writeday, int readCnt,
			int goodCnt, int repleCnt) {
		super();
		this.fnum = fnum;
		this.id = id;
		this.author = author;
		this.title = title;
		this.content = content;
		this.writeday = writeday;
		this.readCnt = readCnt;
		this.goodCnt = goodCnt;
		this.repleCnt = repleCnt;
	}

	@Override
	public String toString() {
		return "FreeBoardDTO [fnum=" + fnum + ", id=" + id + ", author=" + author + ", title=" + title + ", content="
				+ content + ", writeday=" + writeday + ", readCnt=" + readCnt + ", goodCnt=" + goodCnt + ", repleCnt="
				+ repleCnt + "]";
	}

	public int getFnum() {
		return fnum;
	}

	public void setFnum(int fnum) {
		this.fnum = fnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
	
}// end freeBoardDTO
