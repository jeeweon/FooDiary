package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.MemDto;

public interface AdminMemDao {

	List<MemDto> memList(String keyword);
	/*
	 * List<ReviewReportVO> reviewReportHistory(Map<String, Object> history);
	 * boolean reviewCntReset(int reviewNo); boolean reviewBlindClear(int reviewNo);
	 * BlindReviewContentsVO selectOne(int reviewNo); Date reviewReportStart(int
	 * reviewNo);
	 * 
	 * //블라인드 댓글 List<ReplyBlindVO> replyBlindList(String keyword);
	 * List<ReplyReportVO> replyReportHistory(Map<String, Object> history); boolean
	 * replyCntReset(int replyNo); boolean replyBlindClear(int replyNo);
	 * BlindReplyContentsVO pickOne(int replyNo); Date replyReportStart(int
	 * replyNo);
	 */
}
