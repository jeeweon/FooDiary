package com.appfoodiary.foodiary.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ListSearchVO {
	
	//검색분류와 검색어
	private String keyword;
	public boolean isSearch() {
		return keyword != null;
	}
	
	//현재 페이지 번호(없을 경우 1)
		private int p=1;
		private int size = 10;

		public int startRow() {
			return endRow() - (size-1);
		}

		public int endRow() {
			return p * size;
		}
		
		private int startRow = startRow();
		private int endRow = endRow();
		
		//총 게시물 수
		private int count;
		
		//화면에 표시할 블럭 개수
		private int blockSize = 10;
		
		public int pageCount() {
			return (count + size - 1) /size;
		}
		
		public int startBlock() {
			return (p-1) / blockSize * blockSize + 1;
		}
		
		public int endBlock() {
			int value = startBlock() + blockSize - 1;
			return Math.min(value, lastBlock());
		}
		
		public int prevBlock() {
			return startBlock() - 1;
		}
		
		public int nextBlock() {
			return endBlock() + 1;
		}
		
		public int firstBlock() {
			return 1;
		}
		
		public int lastBlock() {
			return pageCount();
		}
		
		public Boolean isFirst() {
			return p ==1;
		}
		
		public Boolean isLast() {
			return endBlock() == lastBlock();
		}
		
		public boolean hasPrev() {
			return startBlock() > 1;
		}
		
		public boolean hasNext() {
			return endBlock() < lastBlock();
		}
		
		public String parameter() {
			if(isSearch()) {
				return "size="+size+"&keyword="+keyword;
			}
			else {
				return "size="+size;
			}
			
		}
}
