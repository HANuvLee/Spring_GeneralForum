package com.spring.board.vo;

public class ReplyVo {
	private int reply_num; //��۹�ȣ, ���seq
	private int board_num; //�Խñ� ��ȣ
	private String board_type; //�Խñ� ����
	private int grp; //�θ����� �ڽ����� (��� = 0, ��� = 1)
	private int grps; //�θ� �������� (NULL or reply_num) 
	private String creator; //�ۼ���
	private String cont; //����
	private String wdate; //�ۼ���
	
	//��ȸ��
	private int rownum; //��� ����Ʈ �Ϸù�ȣ
	private int childCnt;//��۸���Ʈ ��ȸ �� �θ����� ��� ���� ǥ�ø� ���� ���
	
	
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
