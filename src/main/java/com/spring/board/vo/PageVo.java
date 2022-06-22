package com.spring.board.vo;

import java.util.List;

public class PageVo {

	private int currentPage = 0;
	private String chk;	
	//Á¶È¸¿ë
	private String[] chkList;
	private String searchType;
	private String searchName;
	
	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchName() {
		return searchName;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

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
