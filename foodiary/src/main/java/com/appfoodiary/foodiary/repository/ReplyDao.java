package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.ReplyDto;

public interface ReplyDao {
	int newReplyNo();	//댓글번호 생성
	List<ReplyDto> list(int reviewNo);	//댓글목록출력
	void write(ReplyDto dto);	//댓글 작성
	ReplyDto find(int replyNo);	//댓글 검색
	boolean delete(int replyNo);	//댓글 삭제
}
