package com.appfoodiary.foodiary.repository;

import com.appfoodiary.foodiary.entity.MemDto;

public interface MemDao {
	int sequence();
	void join(MemDto memDto);
}
