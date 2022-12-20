package com.appfoodiary.foodiary.repository;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.appfoodiary.foodiary.vo.BlindReplyContentsVO;
import com.appfoodiary.foodiary.vo.BlindReviewContentsVO;
import com.appfoodiary.foodiary.vo.ReplyBlindVO;
import com.appfoodiary.foodiary.vo.ReplyReportVO;
import com.appfoodiary.foodiary.vo.ReviewBlindVO;
import com.appfoodiary.foodiary.vo.ReviewReportVO;

public interface AdminBlindDao {
	//블라인드 리뷰
	List<ReviewBlindVO> reviewBlindList(String keyword);
	List<ReviewReportVO> reviewReportHistory(Map<String, Object> history);
	boolean reviewCntReset(int reviewNo);
	boolean reviewBlindClear(int reviewNo);
	BlindReviewContentsVO selectOne(int reviewNo);
	Date reviewReportStart(int reviewNo);
	
	//블라인드 댓글
	List<ReplyBlindVO> replyBlindList(String keyword);
	List<ReplyReportVO> replyReportHistory(Map<String, Object> history);
	boolean replyCntReset(int replyNo);
	boolean replyBlindClear(int replyNo);
	BlindReplyContentsVO pickOne(int replyNo);
	Date replyReportStart(int replyNo);
}
