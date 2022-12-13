package com.appfoodiary.foodiary.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class FollowDto {
	
	private int followNo;
	private int activeMemNo;
	private int passiveMemNo;

}
