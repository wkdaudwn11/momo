package com.entity.banWord;

public class BanWordDTO {

	private int bwnum;
	private String word;
	
	public BanWordDTO() {
		super();
	}

	public BanWordDTO(int bwnum, String word) {
		super();
		this.bwnum = bwnum;
		this.word = word;
	}

	@Override
	public String toString() {
		return "banWordDTO [bwnum=" + bwnum + ", word=" + word + "]";
	}

	public int getBwnum() {
		return bwnum;
	}

	public void setBwnum(int bwnum) {
		this.bwnum = bwnum;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}
	
}
