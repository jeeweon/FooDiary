package com.appfoodiary.foodiary.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class FollowCertDto {
	private int activeMemNo;
	private int passiveMemNo;
	

}
