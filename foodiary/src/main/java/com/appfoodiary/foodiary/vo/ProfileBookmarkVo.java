package com.appfoodiary.foodiary.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data @Builder
public class ProfileBookmarkVo {
 private int memNo;
 private int reviewNo;
 private Date bookmarkTime;
 private int likeCnt;
 
}
