package com.appfoodiary.foodiary.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.LikeDto;
import com.appfoodiary.foodiary.entity.ReviewDto;

@Repository
public class LikeDaoImpl implements LikeDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public boolean cert(LikeDto dto) {
		int count=sqlSession.selectOne("like.cert",dto);
		return count>0;
	}
	@Override
	public void delete(LikeDto dto) {
		  sqlSession.delete("like.delete",dto);
	}
	@Override
	public void insert(LikeDto dto) {
		sqlSession.insert("like.insert",dto);
	}
	@Override
	public int count(int reviewNo) {
		return sqlSession.selectOne("like.count",reviewNo);	
	}
	@Override
	public void plus(int reviewNo) {
		 sqlSession.update("like.plus",reviewNo);
		
	}
	@Override
	public void minus(int reviewNo) {
		 sqlSession.update("like.minus",reviewNo);
	}
	@Override
	public int count2(int reviewNo) {
		return sqlSession.selectOne("like.count2",reviewNo);
	}
	
}
