package com.appfoodiary.foodiary.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class FollowVO {
private int follow;
private int follower;
private int review;
}
