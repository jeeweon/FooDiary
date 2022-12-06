package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.AreaDto;
import com.appfoodiary.foodiary.entity.InterestAreaDto;

@Repository
public class AreaDaoImpl implements AreaDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<AreaDto> selectList() {
		return sqlSession.selectList("area.list");
	}
	
	@Override
	public void addInterest(InterestAreaDto interestAreaDto) {
		sqlSession.insert("area.add-interest", interestAreaDto);
	}
}
