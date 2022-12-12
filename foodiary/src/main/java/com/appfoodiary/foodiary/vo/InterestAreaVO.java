package com.appfoodiary.foodiary.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class InterestAreaVO {
	private int memNo;
	private int areaNo;
	private String areaCity;
	private String areaDistrict;
}
