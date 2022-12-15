package com.appfoodiary.foodiary.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ReviewListVO {
private int memNo;
private int reviewNo;
private int likeCnt;
private int imgCnt;
private int replyCnt;
}
