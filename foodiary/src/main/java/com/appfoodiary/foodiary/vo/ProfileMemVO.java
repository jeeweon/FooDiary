package com.appfoodiary.foodiary.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ProfileMemVO {
private int memNo;
private String memNick;
private String memIntro;
private int reviewCnt;
private int followCnt;
private int followerCnt;
private int attachNo;
}
