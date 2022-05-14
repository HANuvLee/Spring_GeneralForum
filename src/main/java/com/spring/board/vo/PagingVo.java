package com.spring.board.vo;

public class PagingVo {

		//����������(�⺻���� 1)					�� �������� ������ ���� ����				
		private int currentPage = 1;		private int rowPage   = 10;
		//�ϳ��� ��Ͽ� ���������� �����ִ���, �� 10�̸� <<1,2,3,4,5,6,7,8,9,10>> �������� �Ѻ�� 
		private int pageBlock = 10;	
		//�� �������� ���۱� ��ȣ 								    �� �������� ������ �۹�ȣ   
	    //EX. rowPage�� 10�ΰ��, 1������-> 1 2������ -> 10       EX. rowPage�� 10�ΰ��, 1������-> 10 2������ -> 20
		private int start;									private int end; 
		//���� �������� ���� ����������� ���� ������
		//EX.3�������� 1��° ������ ����̴�. <<1,2,3,4,5,6,7,8,9,10>>. �� ����������� ���� �������� 1�̴�.
		//EX.12�������� 2��° ������ ����̴�. <<11,12,13,14,15,16,17,18,19,20>>. �� ����������� ���� �������� 11�̴�.
		private int startPage;
		//���� ����������� ������ ������
		private int endPage; 
		//�� ���ϸ���Ʈ ����						�� ���ϸ���Ʈ ������ ���������� 10���� ���� ���������ν� ������ �� ������ ���� 
		private int total;					private int totalPage;

		public PagingVo(int total, String currentPage1) {
			this.total = total;
			if (currentPage1 != null) {
				this.currentPage = Integer.parseInt(currentPage1);			
			}
			//10���� ���� �������ٸ� 1���������� �������� 1 2������������ ������ 11 �ǰԲ� ����
			start = (currentPage - 1) * rowPage + 1; 
			////10���� ���� �������ٸ� 1���������� ���������� 10 2������������ ������ 20 �ǰԲ� ����
			end   = start + rowPage - 1;              
			totalPage = (int) Math.ceil((double)total / rowPage);  
			startPage = currentPage - (currentPage - 1) % pageBlock;
			endPage = startPage + pageBlock - 1;
			if (endPage > totalPage) {
				endPage = totalPage;
			}
		}

		public int getCurrentPage() {
			return currentPage;
		}

		public void setCurrentPage(int currentPage) {
			this.currentPage = currentPage;
		}

		public int getRowPage() {
			return rowPage;
		}

		public void setRowPage(int rowPage) {
			this.rowPage = rowPage;
		}

		public int getPageBlock() {
			return pageBlock;
		}

		public void setPageBlock(int pageBlock) {
			this.pageBlock = pageBlock;
		}

		public int getStart() {
			return start;
		}

		public void setStart(int start) {
			this.start = start;
		}

		public int getEnd() {
			return end;
		}

		public void setEnd(int end) {
			this.end = end;
		}

		public int getStartPage() {
			return startPage;
		}

		public void setStartPage(int startPage) {
			this.startPage = startPage;
		}

		public int getEndPage() {
			return endPage;
		}

		public void setEndPage(int endPage) {
			this.endPage = endPage;
		}

		public int getTotal() {
			return total;
		}

		public void setTotal(int total) {
			this.total = total;
		}

		public int getTotalPage() {
			return totalPage;
		}

		public void setTotalPage(int totalPage) {
			this.totalPage = totalPage;
		}
}
