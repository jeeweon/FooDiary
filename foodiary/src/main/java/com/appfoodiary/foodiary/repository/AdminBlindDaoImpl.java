package com.appfoodiary.foodiary.repository;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.vo.BlindReviewContentsVO;
import com.appfoodiary.foodiary.vo.ReviewBlindVO;
import com.appfoodiary.foodiary.vo.ReviewReportVO;

@Repository
public class AdminBlindDaoImpl implements AdminBlindDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReviewBlindVO> reviewBlindList() {
		return sqlSession.selectList("admin-blind.list");
	}

	@Override
	public List<ReviewReportVO> reviewReportHistory(Map<String, Object> history) {
		return sqlSession.selectList("admin-blind.report-history", history);
	}

	@Override
	public void reviewCntReset(int reviewNo) {
		sqlSession.update("admin-blind.report-cnt-reset", reviewNo);
	}

	@Override
	public void reviewBlindClear(int reviewNo) {
		sqlSession.update("admin-blind.blind-clear", reviewNo);
	}
	
	@Override
	public BlindReviewContentsVO selectOne(int reviewNo) {
		return sqlSession.selectOne("admin-blind.review-contents", reviewNo);
	}
	
	@Override
	public Date reviewReportStart(int reviewNo) {
		return sqlSession.selectOne("admin-blind.review-report-start", reviewNo);
	}
}
