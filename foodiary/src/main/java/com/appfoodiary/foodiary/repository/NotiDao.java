package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.NotiDto;

public interface NotiDao {
	void saveNoti(NotiDto notiDto);
	List<NotiDto> myNotiList(int memNo);
	boolean updateReadDate(int notiNo); //읽은 시간 업데이트
	int noReadCnt(int memNo); //안 읽은 알림 수
}
