package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.ReviewAttachDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.vo.ReviewSearchVO;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSession sqlSession;
	
	//리뷰
	@Override
	public int newReviewNo() {
		int reviewNo = sqlSession.selectOne("review.seq");
		return reviewNo;
	}
	
	@Override
	public List<ReviewDto> list() {
		return sqlSession.selectList("review.list");
	}

	@Override
	public void write(ReviewDto dto) {
		sqlSession.insert("review.insert", dto);
	}

	@Override
	public ReviewDto find(int reviewNo) {
		return sqlSession.selectOne("review.get", reviewNo);
	}

	@Override
	public boolean edit(ReviewDto dto) {
		int count = sqlSession.update("review.edit", dto);
		return count >0;
	}

	@Override
	public boolean delete(int reviewNo) {
		int count = sqlSession.delete("review.delete", reviewNo);
		return count >0;
	}

	//리뷰 파일첨부
	@Override
	public void addReviewAttach(ReviewAttachDto dto) {
		sqlSession.insert("review.insertAttach", dto);
	}
	//리뷰 파일조회
	@Override
	public List<AttachDto> findReviewAttachViewList(int reviewNo) {
		return sqlSession.selectList("review.findAttach", reviewNo);
	}
	//리뷰 대표파일 조회
	@Override
	public AttachDto findReviewAttachView(int reviewNo) {
		return sqlSession.selectOne("review.findAttachRep", reviewNo);
	}
	
	//홈 > 리뷰(전체/관심지역) 조회
	@Override
	public List<ReviewSearchVO> homeSearchList(ReviewSearchVO vo) {	
		return sqlSession.selectList("review.home-list", vo);
	}

	//홈 > 리뷰(팔로우) 조회
	@Override
	public List<ReviewSearchVO> homeFollowList(int memNo) {
		return sqlSession.selectList("review.home-follow", memNo);
	}
	
	//맛집 탐색 > 리뷰/검색 결과 조회(비회원)
	@Override
	public List<ReviewSearchVO> guestSearchList(String keyword) {
		return sqlSession.selectList("review.search-guest", keyword);
	}
	
	//맛집 탐색 > 리뷰/검색 결과 조회(회원)
	@Override
	public List<ReviewSearchVO> memSearchList(ReviewSearchVO vo) {
		return sqlSession.selectList("review.search-mem", vo);
	}
}
