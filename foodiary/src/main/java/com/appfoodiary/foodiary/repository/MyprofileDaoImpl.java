package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.BookmarkDto;
import com.appfoodiary.foodiary.entity.LikeDto;
import com.appfoodiary.foodiary.entity.MyprofileDto;
import com.appfoodiary.foodiary.entity.ReviewDto;

@Repository
public class MyprofileDaoImpl implements MyprofileDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MyprofileDto selectOne(int memNo) {
		return sqlSession.selectOne("myprofile.profile",memNo);
	}
	@Override
	public int reviewCnt(int memNo) {
		return sqlSession.selectOne("myprofile.reviewcnt",memNo);
	}
	@Override
	public List<ReviewDto> reviewList(int memNo) {
		return sqlSession.selectList("myprofile.review",memNo);
	}
	@Override
	public List<BookmarkDto> bookmarkList(int memNo) {
		return sqlSession.selectList("myprofile.bookmark", memNo);
	}
	@Override
	public List<LikeDto> likeList(int memNo) {
		return sqlSession.selectList("myprofile.like",memNo);
	}
}
