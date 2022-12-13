package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.MyprofileDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.vo.ProfileBookmarkVO;
import com.appfoodiary.foodiary.vo.ProfileLikeVO;

public interface MyprofileDao {

	//하나의 회원정보
	MyprofileDto selectOne(int memNo);
	//리뷰수
	int reviewCnt(int memNo);
	//나의 게시물
	List<ReviewDto> reviewList(int memNo);
	//북마크 사진
	List<ProfileBookmarkVO> bookmarkList(int memNo);
	//좋아요
	List<ProfileLikeVO> likeList(int memNo);
}
