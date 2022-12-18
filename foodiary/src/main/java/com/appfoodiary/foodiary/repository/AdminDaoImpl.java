package com.appfoodiary.foodiary.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.AdminDto;

@Repository
public class AdminDaoImpl implements AdminDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public AdminDto findDto(String adminId) {
		return sqlSession.selectOne("admin.find-admin", adminId);
	}
	
	@Override
	public void updateLoginDate(String adminId) {
		sqlSession.update("admin.login-date", adminId);
	}
}
