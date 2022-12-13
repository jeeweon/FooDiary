package com.appfoodiary.foodiary.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewSearchVO {
	private int reviewNo;
	private int memNo;
	private String memNick;
	private String reviewContent;
	private Date reviewWriteTime;
	private float starScore;
	private String reviewPlace;
	private String reviewAddress;
	private int reviewReportCnt;
	private String interestArea;
	private int likeCnt;
	private int replyCnt;
	private int memReviewCnt;
	private int imgCnt;
	private boolean likeCheck; //특정회원이 리뷰에 좋아요했는지 여부
	private boolean bookmarkCheck; //특정회원이 리뷰를 북마크했는지 여부
}
