package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.ReviewAttachDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.vo.ReviewSearchVO;

public interface ReviewDao {
	//리뷰
	int newReviewNo();
	List<ReviewDto> list();
	void write(ReviewDto dto);
	ReviewDto find(int reviewNo);
	boolean edit(ReviewDto dto);
	boolean delete(int reviewNo);
	
	//리뷰 첨부파일
	void addReviewAttach(ReviewAttachDto dto);	//파일첨부
	List<AttachDto> findReviewAttachViewList(int reviewNo);	//전체 조회
	AttachDto findReviewAttachView(int reviewNo);	//대표파일 조회
	
	//홈 > 리뷰(전체/관심지역) 조회
	List<ReviewSearchVO> homeSearchList(ReviewSearchVO vo);
	
	//홈 > 리뷰(팔로우) 조회
	List<ReviewSearchVO> homeFollowList(int memNo);
}
