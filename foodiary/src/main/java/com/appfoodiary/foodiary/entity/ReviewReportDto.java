package com.appfoodiary.foodiary.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewReportDto {
	private int reviewReportNo;
	private int reviewNo;
	private int memNo;
	private Date reviewReportTime;
}
