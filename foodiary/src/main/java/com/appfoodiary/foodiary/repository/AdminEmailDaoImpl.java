package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.NoticeEmailDto;
import com.appfoodiary.foodiary.vo.MemEmailVO;

@Repository
public class AdminEmailDaoImpl implements AdminEmailDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int emailSequence() {
		return sqlSession.selectOne("admin-email.sequence");
	}
	
	@Override
	public void insertMail(NoticeEmailDto noticeEmailDto) {
		sqlSession.insert("admin-email.send",noticeEmailDto);
	}
	
	@Override
	public NoticeEmailDto selectOne(int emailNo) {
		return sqlSession.selectOne("admin-email.one",emailNo);
	}
	
	@Override
	public List<NoticeEmailDto> selectList() {
		return sqlSession.selectList("admin-email.list");
	}
	
	@Override
	public List<MemEmailVO> emailList(){
		return sqlSession.selectList("admin-email.emailList");
	}
}
