package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.MyprofileDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.vo.ProfileBookmarkVO;
import com.appfoodiary.foodiary.vo.ProfileLikeVO;
import com.appfoodiary.foodiary.vo.ProfileMemVO;
import com.appfoodiary.foodiary.vo.ReviewListVO;

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
		return sqlSession.selectOne("myprofile.reviewCnt",memNo);
	}
	@Override
	public List<ReviewDto> reviewList(int memNo) {
		return sqlSession.selectList("myprofile.review",memNo);
	}
	@Override
	public List<ProfileBookmarkVO> bookmarkList(int memNo) {
		return sqlSession.selectList("myprofile.bookmark", memNo);
	}
	@Override
	public List<ProfileLikeVO> likeList(int memNo) {
		return sqlSession.selectList("myprofile.like",memNo);
	}
	@Override
	public int photocnt(int reviewNo) {
		return sqlSession.selectOne("myprofile.photocnt",reviewNo);
	}
	@Override
	public ProfileMemVO profileMemVO(int memNo) {
		return sqlSession.selectOne("myprofile.memprofile",memNo);
	}
	@Override
	public List<ReviewListVO> reivewListVO(int memNo) {
		return sqlSession.selectList("myprofile.reviewlist",memNo);
	}
	@Override
	public List<ReviewListVO> bookmarkListVO(int memNo) {
		return sqlSession.selectList("myprofile.bookmarklist",memNo);
	}
	@Override
	public List<ReviewListVO> likeListVO(int memNo) {
		return sqlSession.selectList("myprofile.likelist",memNo);
	}
		}
