package com.entity.question;

import java.util.List;

public class QuestionPage {

	private List<QuestionDTO> questionList;
	private int curPage;
	private int perPage =10;
	private int page = 5;
	private int totalRecord;
	
	
	public QuestionPage(){}

	public QuestionPage(List<QuestionDTO> questionList, int curPage, int perPage, int page, int totalRecord) {
		this.questionList = questionList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.page = page;
		this.totalRecord = totalRecord;
	}

	public List<QuestionDTO> getQuestionList() {
		return questionList;
	}

	public void setQuestionList(List<QuestionDTO> questionList) {
		this.questionList = questionList;
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
		return "QuestionPage [questionList=" + questionList + ", curPage=" + curPage + ", perPage=" + perPage
				+ ", page=" + page + ", totalRecord=" + totalRecord + "]";
	}
	
	
}// end QuestionPage
