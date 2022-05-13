package com.spring.board.vo;

import java.util.ArrayList;

public class PageVo {
	
	private int pageNo = 0;
	
	private ArrayList<String> chkValue;


	public ArrayList<String> getChkValue() {
		return chkValue;
	}

	public void setChkValue(ArrayList<String> chkValue) {
		this.chkValue = chkValue;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
}
