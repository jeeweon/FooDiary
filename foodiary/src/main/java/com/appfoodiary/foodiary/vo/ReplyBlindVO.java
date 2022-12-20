package com.appfoodiary.foodiary.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyBlindVO {
	private int replyBlindNo;
	private int replyNo;
	private int blindReportCnt;	//블라인드 신고수 카운트
	private String replyIsblind;	//블라인드 상태(0:대기,1:블라인드,2:해제)
	private Date reportStartTime;	//신고시작일 (5번째=블라인드일)
	private Date blindClearTime;	//블라인드 해제일
	private String memNick;
	private String keyword;
}
