package com.appfoodiary.foodiary.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.ReplyDto;
import com.appfoodiary.foodiary.vo.ReplyListVO;

@Repository
public class ReplyDaoImpl implements ReplyDao {

	@Autowired
	private SqlSession sqlSession;

	//댓글번호 생성
	@Override
	public int newReplyNo() {
		int replyNo = sqlSession.selectOne("reply.seq");
		return replyNo;
	}
	//댓글목록출력
	@Override
	public List<ReplyListVO> list(int reviewNo) {
		return sqlSession.selectList("reply.list", reviewNo);
	}
	//댓글 작성
	@Override
	public void write(ReplyDto dto) {
		sqlSession.insert("reply.insert", dto);
	}
	//댓글 검색
	@Override
	public ReplyDto find(int replyNo) {
		return sqlSession.selectOne("reply.get", replyNo);
	}
	//댓글 삭제
	@Override
	public boolean delete(int replyNo) {
		int count = sqlSession.delete("reply.delete", replyNo);
		return count >0;
	}

	
	//댓글신고 테이블 : 신고+1 (insert)
	@Override
	public void insertReplyReport(Map<String, Object> report) {
		sqlSession.insert("reply.insertReplyReport", report);
	}
	//댓글 테이블 : 신고수+1 (update)
	@Override
	public boolean plusReplyReportCnt(int replyNo) {
		int count = sqlSession.update("reply.plusReplyReportCnt", replyNo);
		return count >0;
	}
	//댓글 테이블의 댓글신고수 조회
	@Override
	public int selectReplyReportCnt(int replyNo) {
		return sqlSession.selectOne("reply.selectReplyReportCnt", replyNo);
	}
	//댓글블라인드 테이블 : 신고+1 (insert)
	@Override
	public void insertReplyBlind(int replyNo) {
		sqlSession.insert("reply.insertReplyBlind", replyNo);
	}
	//댓글블라인드 테이블 : 신고수+1 (update)
	@Override
	public boolean plusReplyBlind(Map<String, Object> blind) {
		int count = sqlSession.update("reply.plusReplyBlind", blind);
		return count >0;
	}
}
