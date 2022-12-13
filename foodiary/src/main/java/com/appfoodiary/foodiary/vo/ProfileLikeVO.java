package com.appfoodiary.foodiary.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ProfileLikeVO {
	private int reviewNo;
	private int memNo;
	private int likeCnt;
}
