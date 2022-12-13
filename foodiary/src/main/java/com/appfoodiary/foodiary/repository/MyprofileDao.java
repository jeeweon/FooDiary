package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.BookmarkDto;
import com.appfoodiary.foodiary.entity.LikeDto;
import com.appfoodiary.foodiary.entity.MyprofileDto;
import com.appfoodiary.foodiary.entity.ReviewDto;

public interface MyprofileDao {

	//하나의 회원정보
	MyprofileDto selectOne(int memNo);
	//리뷰수
	int reviewCnt(int memNo);
	//리뷰 사진
	List<ReviewDto> reviewList(int memNo);
	//북마크 사진
	List<BookmarkDto> bookmarkList(int memNo);
	//좋아요
	List<LikeDto> likeList(int memNo);
}
