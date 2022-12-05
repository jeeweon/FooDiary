package com.appfoodiary.foodiary.repository;

import com.appfoodiary.foodiary.entity.SelfCheckDto;

public interface SelfCheckDao {
	
	void insert(SelfCheckDto selfCheckDto);
	boolean check(SelfCheckDto selfCheckDto);
	boolean delete(String who);
	void clear();

}
