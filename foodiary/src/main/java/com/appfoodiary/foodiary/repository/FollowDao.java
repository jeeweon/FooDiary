package com.appfoodiary.foodiary.repository;

import com.appfoodiary.foodiary.entity.FollowCertDto;
import com.appfoodiary.foodiary.entity.FollowDto;
import com.appfoodiary.foodiary.vo.FollowCertVO;

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
	//팔로우 확인
	FollowCertVO followCert(FollowCertDto dto);
}
