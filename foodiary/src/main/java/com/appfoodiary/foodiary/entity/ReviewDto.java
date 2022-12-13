package com.appfoodiary.foodiary.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewDto { 

	private int reviewNo;
	private int memNo;
	private String reviewContent;
	private Date reviewWriteTime;
	private float starScore;
	private String reviewAddress;
	private String reviewPlace;
	private int reviewReportCnt;
	private int likeCnt;
}
