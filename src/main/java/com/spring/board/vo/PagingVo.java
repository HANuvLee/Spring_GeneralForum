package com.spring.board.vo;

public class PagingVo {

		//현재페이지(기본값은 1)					한 페이지에 보여줄 글의 개수				
		private int currentPage = 1;		private int rowPage   = 10;
		//하나의 블록에 몇페이지가 속해있는지, 즉 10이면 <<1,2,3,4,5,6,7,8,9,10>> 페이지가 한블록 
		private int pageBlock = 10;	
		//한 페이지의 시작글 번호 								    한 페이지의 마지막 글번호   
	    //EX. rowPage가 10인경우, 1페이지-> 1 2페이지 -> 10       EX. rowPage가 10인경우, 1페이지-> 10 2페이지 -> 20
		private int start;									private int end; 
		//현재 페이지가 속한 페이지블록의 시작 페이지
		//EX.3페이지는 1번째 페이지 블록이다. <<1,2,3,4,5,6,7,8,9,10>>. 이 페이지블록의 시작 페이지는 1이다.
		//EX.12페이지는 2번째 페이지 블록이다. <<11,12,13,14,15,16,17,18,19,20>>. 이 페이지블록의 시작 페이지는 11이다.
		private int startPage;
		//현재 페이지블록의 마지막 페이지
		private int endPage; 
		//총 메일리스트 갯수						총 메일리스트 개수를 한페이지에 10개씩 나눠 보여줌으로써 나오는 총 페이지 개수 
		private int total;					private int totalPage;

		public PagingVo(int total, String currentPage1) {
			this.total = total;
			if (currentPage1 != null) {
				this.currentPage = Integer.parseInt(currentPage1);			
			}
			//10개씩 글이 보여진다면 1페이지에서 시작행은 1 2페이지에서는 시작행 11 되게끔 만듬
			start = (currentPage - 1) * rowPage + 1; 
			////10개씩 글이 보여진다면 1페이지에서 마지막행은 10 2페이지에서는 시작행 20 되게끔 만듬
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
