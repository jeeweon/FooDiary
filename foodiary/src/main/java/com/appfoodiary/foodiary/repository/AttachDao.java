package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.AttachDto;

public interface AttachDao {
	
//	첨부파일 데이터
	int newAttachNo();
	void insert(AttachDto dto);	
	List<AttachDto> selectList();
	AttachDto selectOne(int attachNo);
	boolean delete(int attachNo);

}
