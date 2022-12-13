package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.MyprofileDto;
import com.appfoodiary.foodiary.entity.ReviewDto;

public interface MyprofileDao {

	//하나의 회원정보
	MyprofileDto selectOne(int memNo);
	//리뷰수
	int reviewCnt(int memNo);
	//한 회원 리뷰
	List<ReviewDto> reviewList(int memNo);
}
