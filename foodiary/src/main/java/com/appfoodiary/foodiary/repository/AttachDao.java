package com.appfoodiary.foodiary.repository;

import com.appfoodiary.foodiary.entity.AttachDto;

//첨부파일
public interface AttachDao {

//	번호 생성
	int newAttachNo();
//	파일 추가
	void insert(AttachDto dto);	
//	파일 탐색
	AttachDto selectOne(int attachNo);
//	파일 삭제
	boolean delete(int attachNo);

}
