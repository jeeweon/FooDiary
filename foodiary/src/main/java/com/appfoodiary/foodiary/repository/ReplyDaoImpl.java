package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.ReplyDto;

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
	public List<ReplyDto> list() {
		return sqlSession.selectList("reply.list");
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

}
