package com.appfoodiary.foodiary.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SelfCheckDto {
	
	private String who;
	private String serial;
	private Date when;

}
