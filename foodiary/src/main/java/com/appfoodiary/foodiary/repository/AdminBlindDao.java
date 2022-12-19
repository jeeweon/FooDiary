package com.appfoodiary.foodiary.repository;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.appfoodiary.foodiary.vo.BlindReviewContentsVO;
import com.appfoodiary.foodiary.vo.ReviewBlindVO;
import com.appfoodiary.foodiary.vo.ReviewReportVO;

public interface AdminBlindDao {
	List<ReviewBlindVO> reviewBlindList();
	List<ReviewReportVO> reviewReportHistory(Map<String, Object> history);
	void reviewCntReset(int reviewNo);
	void reviewBlindClear(int reviewNo);
	BlindReviewContentsVO selectOne(int reviewNo);
	Date reviewReportStart(int reviewNo);
}
