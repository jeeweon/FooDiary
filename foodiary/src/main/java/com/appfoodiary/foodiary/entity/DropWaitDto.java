package com.appfoodiary.foodiary.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class DropWaitDto {

	private int waitNo;
	private int waitMemNo;
	private String waitMemEmail;
	private String waitMemPw;
	private String waitMemNick;
	private String waitMemIntro;
	private String waitMemBirth;
	private String waitMemLevel;
	private int waitMemPoint;
	private Date waitMemJoinDate;
	private Date waitMemLoginDate;
	private Date waitMemDropDate;
	
}
