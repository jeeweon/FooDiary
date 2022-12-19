package com.appfoodiary.foodiary.repository;

import java.util.List;
import java.util.Map;

import com.appfoodiary.foodiary.vo.ReviewBlindVO;
import com.appfoodiary.foodiary.vo.ReviewReportVO;

public interface AdminBlindDao {
	List<ReviewBlindVO> blindList();
	List<ReviewReportVO> reportHistory(Map<String, Object> history);
	void cntReset(int reviewNo);
	void blindClear(int reviewNo);
}
