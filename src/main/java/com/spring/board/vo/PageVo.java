package com.spring.board.vo;

import java.util.List;

public class PageVo {

	private int currentPage = 0;
	private String chk;	
	//Á¶È¸¿ë
	private String[] chkList;
	
	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public String getChk() {
		return chk;
	}

	public void setChk(String chk) {
		this.chk= chk;
	}

	public String[] getChkList() {
		return chkList;
	}

	public void setChkList(String[] chkList) {
		this.chkList = chkList;
	}
	
}
