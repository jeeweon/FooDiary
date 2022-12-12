package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.MemDto;

public interface MemRekDao {
	
	//추천 회원 받아오기
	List<MemDto> list();
}
