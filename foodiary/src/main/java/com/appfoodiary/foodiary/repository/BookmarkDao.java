package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.BookmarkDto;

public interface BookmarkDao {
	//북마크 추가 
	void insert(BookmarkDto dto);
	//북마크 삭제
	void delete(BookmarkDto dto);
	//북마크 검증
	boolean cert(BookmarkDto dto);
	//북마크리스트
	List<BookmarkDto> list(BookmarkDto dto);
	
	
}
