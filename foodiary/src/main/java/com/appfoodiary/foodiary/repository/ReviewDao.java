package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.ReviewDto;

public interface ReviewDao {
	int newReviewNo();
	List<ReviewDto> list();
	void write(ReviewDto dto);
	ReviewDto find(int reviewNo);
	boolean edit(ReviewDto dto);
	boolean delete(int reviewNo);
}
