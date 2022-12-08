package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.AreaDto;
import com.appfoodiary.foodiary.entity.InterestAreaDto;
import com.appfoodiary.foodiary.vo.CntInterestAreaVO;
import com.appfoodiary.foodiary.vo.InterestAreaVO;

public interface AreaDao {
	List<AreaDto> selectList();
	void addInterest(InterestAreaDto interestAreaDto);
	List<InterestAreaVO> myAreas(int memNo);
	List<InterestAreaDto> myAreasDto(int memNo);
	void deleteInterest(InterestAreaDto interestAreaDto);
	CntInterestAreaVO selectCnt(int memNo);
}
