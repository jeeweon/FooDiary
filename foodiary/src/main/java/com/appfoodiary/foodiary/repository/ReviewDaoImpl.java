package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.ReviewDto;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSession sqlSession;
	
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

}
