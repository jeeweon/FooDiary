package com.appfoodiary.foodiary.repository;

import java.util.List;
import java.util.Map;

import com.appfoodiary.foodiary.entity.LikeDto;
import com.appfoodiary.foodiary.entity.LikePointHistoryDto;

public interface LikeDao {
	//좋아요 추가
	void insert(LikeDto dto);
	//좋아요 삭제
	void delete(LikeDto dto);
	//좋아요 확인
	boolean cert(LikeDto dto);
	//좋아요 갯수 확인
	int count(int reviewNo);
	//좋아요갯수 증가
	void plus(int reviewNo);
	//좋아요갯수 감소
	void minus(int reviewNo);
	//리뷰 like_cnt
	int count2(int reviewNo);
	//좋아요 점수 내역 조회
	LikePointHistoryDto likePointHistory(Map<String, Integer> param);
	//좋아요 점수 내역 추가
	void addHisotry(Map<String, Integer> param);

}
