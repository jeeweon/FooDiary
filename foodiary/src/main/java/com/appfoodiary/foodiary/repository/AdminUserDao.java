package com.appfoodiary.foodiary.repository;

import com.appfoodiary.foodiary.entity.AdminDto;

public interface AdminUserDao {
	AdminDto findDto(String adminId);
	void updateLoginDate(String adminId);
}
