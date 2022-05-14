package com.spring.board.vo;

import java.util.ArrayList;

public class PageVo {
	
	private int pageNo = 0;
	
	private String[] chkValue;


	public String[] getChkValue() {
		return chkValue;
	}

	
	public void setChkValue(String[] chkValue) {
		this.chkValue = chkValue;
	}


	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
}
