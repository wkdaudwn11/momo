package com.entity.freeboard;

/** 자유게시판 댓글 DTO 클래스 */
public class FreeBoardRepleDTO {
	private int reLevel;		// 댓글 깊이 
	private int ref ;			// 댓글 그룹으로 구분
	private int step;			// 댓글 출력 순서 구분
	private int pfrnum;			// 부모의 고유번호
	private	Integer frnum;		//댓글 고유번호 (pk)
	private	int fnum;			//게시물번호 (fk) -> 게시글 삭제되면 댓글도 같이 삭제 (cascade)
	private String author;		//작성자
	private String content;		//내용
	private String writeday;	//작성일
	
	public FreeBoardRepleDTO() {}

	public FreeBoardRepleDTO(int reLevel, int ref, int step, int pfrnum, Integer frnum, int fnum, String author,
			String content, String writeday) {
		this.reLevel = reLevel;
		this.ref = ref;
		this.step = step;
		this.pfrnum = pfrnum;
		this.frnum = frnum;
		this.fnum = fnum;
		this.author = author;
		this.content = content;
		this.writeday = writeday;
	}

	@Override
	public String toString() {
		return "FreeBoardRepleDTO [reLevel=" + reLevel + ", ref=" + ref + ", step=" + step + ", pfrnum=" + pfrnum
				+ ", frnum=" + frnum + ", fnum=" + fnum + ", author=" + author + ", content=" + content + ", writeday="
				+ writeday + "]";
	}

	public int getReLevel() {
		return reLevel;
	}

	public void setReLevel(int reLevel) {
		this.reLevel = reLevel;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getPfrnum() {
		return pfrnum;
	}

	public void setPfrnum(int pfrnum) {
		this.pfrnum = pfrnum;
	}

	public Integer getFrnum() {
		return frnum;
	}

	public void setFrnum(Integer frnum) {
		this.frnum = frnum;
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
	
}// end FreeBoardRepleDTO;
