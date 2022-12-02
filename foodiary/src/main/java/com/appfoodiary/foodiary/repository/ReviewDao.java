package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.ReviewDto;

public interface ReviewDao {
	List<ReviewDto> list();
	void insert(ReviewDto dto);
	ReviewDto find(int no);
	boolean edit(ReviewDto dto);
	boolean delete(int no);
}
