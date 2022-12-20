package com.appfoodiary.foodiary.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BlindReplyContentsVO {
	private int replyNo;
	private int memNo;
	private String replyContent;
	private Date replyWriteTime;
	private int replyReportCnt;
	private String memNick;
	private String memLevel;
	private int pno; //프로필 이미지 첨부파일 번호
}
