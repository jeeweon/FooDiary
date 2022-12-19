package com.appfoodiary.foodiary.repository;

import java.util.List;
import java.util.Map;

import com.appfoodiary.foodiary.entity.ReplyDto;
import com.appfoodiary.foodiary.vo.ReplyListVO;

public interface ReplyDao {
	//댓글
	int newReplyNo();	//댓글번호 생성
	List<ReplyListVO> list(int reviewNo);	//댓글목록출력
	void write(ReplyDto dto);	//댓글 작성
	ReplyDto find(int replyNo);	//댓글 검색
	boolean delete(int replyNo);	//댓글 삭제
	
	//댓글신고 테이블 : 신고+1 (insert)
	void insertReplyReport(Map<String, Object> report);
	//댓글 테이블 : 신고수+1 (update)
	boolean plusReplyReportCnt(int replyNo);
	//댓글 테이블의 댓글신고수 조회
	int selectReplyReportCnt(int replyNo);
	//댓글블라인드 테이블 : 신고+1 (insert)
	void insertReplyBlind(int replyNo);
	//댓글블라인드 테이블 : 신고수+1 (update)
	boolean plusReplyBlind(Map<String, Object> blind);
	
}
