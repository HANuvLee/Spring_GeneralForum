package com.spring.board.vo;

public class ReplyVo {
	private int reply_num; //댓글번호, 댓글seq
	private int board_num; //게시글 번호
	private String board_type; //게시글 유형
	private int grp; //부모인지 자식인지 (댓글 = 0, 답글 = 1)
	private int grps; //부모가 누구인지 (NULL or reply_num) 
	private String creator; //작성자
	private String cont; //내용
	private String wdate; //작성일
	
	//조회용
	private int rownum; //댓글 리스트 일련번호
	private int childCnt;//댓글리스트 조회 시 부모댓글의 답글 개수 표시를 위해 사용
	
	
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getGrps() {
		return grps;
	}
	public void setGrps(int grps) {
		this.grps = grps;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getChildCnt() {
		return childCnt;
	}
	public void setChildCnt(int childCnt) {
		this.childCnt = childCnt;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	
}
