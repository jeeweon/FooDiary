package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.MemDto;

@Repository
public class MemRekDaoImpl implements MemRekDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemDto> list() {
		return sqlSession.selectList("memrek.list");
		
	}

}
