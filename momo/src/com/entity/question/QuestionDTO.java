package com.entity.question;

public class QuestionDTO {
	
	private int ref;
	private int qlevel;
	private int qnum;
	private String id;
	private String password;
	private String category;
	private String title;
	private String content;
	private String author;
	private String writeday;
	private int readCnt;
	
	public QuestionDTO(){}

	public QuestionDTO(int ref, int qlevel, int qnum, String id, String password, String category, String title,
			String content, String author, String writeday, int readCnt) {
		this.ref = ref;
		this.qlevel = qlevel;
		this.qnum = qnum;
		this.id = id;
		this.password = password;
		this.category = category;
		this.title = title;
		this.content = content;
		this.author = author;
		this.writeday = writeday;
		this.readCnt = readCnt;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getQlevel() {
		return qlevel;
	}

	public void setQlevel(int qlevel) {
		this.qlevel = qlevel;
	}

	public int getQnum() {
		return qnum;
	}

	public void setQnum(int qnum) {
		this.qnum = qnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
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

	@Override
	public String toString() {
		return "QuestionDTO [ref=" + ref + ", qlevel=" + qlevel + ", qnum=" + qnum + ", id=" + id + ", password="
				+ password + ", category=" + category + ", title=" + title + ", content=" + content + ", author="
				+ author + ", writeday=" + writeday + ", readCnt=" + readCnt + "]";
	}

	
	
}// end QuestionDTO
