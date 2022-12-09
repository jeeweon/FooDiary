package com.appfoodiary.foodiary.repository;

import com.appfoodiary.foodiary.entity.LikeDto;

public interface LikeDao {
	//좋아요 추가
	void insert(LikeDto dto);
	//좋아요 삭제
	void delete(LikeDto dto);
	//좋아요 확인
	boolean cert(LikeDto dto);
	//좋아요 갯수 확인
	int count(int reviewNo);

}
