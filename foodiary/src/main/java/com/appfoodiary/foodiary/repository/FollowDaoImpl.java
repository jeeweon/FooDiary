package com.appfoodiary.foodiary.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.FollowDto;
import com.appfoodiary.foodiary.vo.FollowVO;

@Repository
public class FollowDaoImpl implements FollowDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(FollowDto dto) {
		sqlSession.insert("follow.insert",dto);
	}
	@Override
	public void delete(FollowDto dto) {
		sqlSession.delete("follow.delete",dto);
		
	}
	@Override
	public boolean cert(FollowDto dto) {
		int count=sqlSession.selectOne("follow.count",dto);
		return count>0;
	}
	@Override
	public int follower(int memNo) {
		return sqlSession.selectOne("follow.follower",memNo);
		
	}
	@Override
	public int following(int memNo) {
		return sqlSession.selectOne("follow.following",memNo);
	}
	@Override
	public int reviewCount(int memNo) {
		return sqlSession.selectOne("follow.reviewcount",memNo);
	}
	

}
