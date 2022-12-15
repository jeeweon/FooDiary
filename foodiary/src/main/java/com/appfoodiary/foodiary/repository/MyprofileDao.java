package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.MyprofileDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.vo.ProfileBookmarkVO;
import com.appfoodiary.foodiary.vo.ProfileLikeVO;
import com.appfoodiary.foodiary.vo.ProfileMemVO;
import com.appfoodiary.foodiary.vo.ReviewListVO;

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
	//사진갯수 
	int photocnt(int reviewNo);
	//전체회원 구문 
	ProfileMemVO profileMemVO(int memNo);
	//리뷰리스트 
	List<ReviewListVO> reivewListVO(int memNo);
}
