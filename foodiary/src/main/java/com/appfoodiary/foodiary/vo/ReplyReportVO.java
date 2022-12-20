package com.appfoodiary.foodiary.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyReportVO {
	private int replyReportNo;
	private int replyNo;
	private int memNo;
	private Date replyReportTime;
	private String memNick;
}
