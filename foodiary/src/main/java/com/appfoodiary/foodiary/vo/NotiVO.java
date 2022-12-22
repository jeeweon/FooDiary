package com.appfoodiary.foodiary.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class NotiVO {
	private int notiNo;
	private int callerMemNo;
	private int receiverMemNo;
	private String notiType;
	private String notiContent;
	private String notiUrl;
	private Date notiCreateDate;
	private Date notiReadDate; //읽은 시간 null이면 안읽은 메시지
	private String memNick; //알림 발생시킨 유저 닉네임
}
