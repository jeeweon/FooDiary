package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.FollowCertDto;
import com.appfoodiary.foodiary.entity.FollowDto;
import com.appfoodiary.foodiary.vo.FollowCertVO;
import com.appfoodiary.foodiary.vo.FollowMemVO;

public interface FollowDao {

	//삽입
	void insert(FollowDto dto);
	//삭제
	void delete(FollowDto dto);
	//확인
	boolean cert(FollowDto dto);
	//팔로워수 
	int follower(int memNo);
	//팔로잉수 
	int following(int memNo);
	//게시물수
	int reviewCount(int memNo);
	//팔로우멤버 확인
	FollowCertVO followCert(FollowCertDto dto);
	//팔로우멤버 확인 
	List<FollowMemVO> followMem(int memNo);
	//팔로워멤버 확인
	List<FollowMemVO> followerMem(int memNo);
}
