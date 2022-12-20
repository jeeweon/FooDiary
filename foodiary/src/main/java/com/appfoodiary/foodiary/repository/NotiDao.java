package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.NotiDto;

public interface NotiDao {
	void saveNoti(NotiDto notiDto);
	List<NotiDto> myNotiList(int memNo);
}
