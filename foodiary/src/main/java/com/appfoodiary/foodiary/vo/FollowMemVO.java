package com.appfoodiary.foodiary.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @Builder @AllArgsConstructor @Data
public class FollowMemVO {
	private int memNo;
	private String memNick;
	private int attachNo;
}
