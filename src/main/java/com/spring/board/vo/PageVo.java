package com.spring.board.vo;

import java.util.ArrayList;

public class PageVo {

	private int pageNo = 0;
	private String[] chk;

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	public String[] getChk() {
		return chk;
	}

	public void setChk(String[] chk) {
		this.chk= chk;
	}
	
}
