package com.appfoodiary.foodiary.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminBlindDaoImpl implements AdminBlindDao {
	@Autowired
	private SqlSession sqlSession;
	
	
}
