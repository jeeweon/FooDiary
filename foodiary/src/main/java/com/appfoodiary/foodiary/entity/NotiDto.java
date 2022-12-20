package com.appfoodiary.foodiary.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class NotiDto {
	private int notiNo;
	private int callerMemNo;
	private int receiverMemNo;
	private String notiType;
	private String notiContent;
	private String notiUrl;
	private Date notiCreateDate;
	private Date notiReadDate; //읽은 시간 null이면 안읽은 메시지
}
