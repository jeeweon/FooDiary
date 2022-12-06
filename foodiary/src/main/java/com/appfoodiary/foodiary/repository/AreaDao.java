package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.AreaDto;
import com.appfoodiary.foodiary.entity.InterestAreaDto;

public interface AreaDao {
	List<AreaDto> selectList();
	void addInterest(InterestAreaDto interestAreaDto);
}
