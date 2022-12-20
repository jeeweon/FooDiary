package com.appfoodiary.foodiary.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CheckRpLkBkVO {
	private int reviewNo; //리뷰 글번호
	private int memNo;	//로그인한 회원번호
	private boolean likeCheck; //특정회원이 리뷰에 좋아요했는지 여부
	private boolean bookmarkCheck; //특정회원이 리뷰를 북마크했는지 여부
	private int replyTotal;	//댓글 갯수
}
