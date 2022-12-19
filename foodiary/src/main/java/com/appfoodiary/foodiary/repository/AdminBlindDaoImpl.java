package com.appfoodiary.foodiary.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.vo.ReviewBlindVO;
import com.appfoodiary.foodiary.vo.ReviewReportVO;

@Repository
public class AdminBlindDaoImpl implements AdminBlindDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReviewBlindVO> blindList() {
		return sqlSession.selectList("admin-blind.list");
	}

	@Override
	public List<ReviewReportVO> reportHistory(Map<String, Object> history) {
		return sqlSession.selectList("admin-blind.report-history", history);
	}

	@Override
	public void cntReset(int reviewNo) {
		sqlSession.update("admin-blind.report-cnt-reset", reviewNo);
	}

	@Override
	public void blindClear(int reviewNo) {
		sqlSession.update("admin-blind.blind-clear", reviewNo);
	}
}
