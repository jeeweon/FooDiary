package com.appfoodiary.foodiary.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class  MyprofileDto{ 
	
	private int attachNo;
	private int memNo;
	private String memEmail;
	private String memPw;
	private String memNick;
	private String memIntro;
	private Date memBirth;
	private String memLevel;
	private int memPoint;
	private Date memJoinDate;
	private Date memLoginDate;
	
}
