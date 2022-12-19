package com.appfoodiary.foodiary.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BlindReviewContentsVO {
	private int reviewNo;
	private int memNo;
	private String reviewContent;
	private Date reviewWriteTime;
	private float starScore;
	private String reviewAddress;
	private String reviewPlace;
	private int reviewReportCnt;
	private int likeCnt;
	private int replyCnt;
	private String memNick;
	private String memLevel;
	private String memReviewCnt;
	private int pno; //프로필 이미지 첨부파일 번호
}
