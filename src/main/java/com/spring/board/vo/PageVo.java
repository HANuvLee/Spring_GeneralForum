package com.spring.board.vo;


public class PageVo {

	private int currentPage = 1;
	private String[] chk;
	
	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public String[] getChk() {
		return chk;
	}

	public void setChk(String[] chk) {
		this.chk= chk;
	}
	
}
