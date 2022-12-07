package com.appfoodiary.foodiary.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AreaDto {
	private int areaNo;
	private String areaCity;
	private String areaDistrict;
	private String areaNearby1;
	private String areaNearby2;
}
