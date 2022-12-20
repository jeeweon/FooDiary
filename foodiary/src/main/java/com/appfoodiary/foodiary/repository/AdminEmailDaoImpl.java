package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.NoticeEmailDto;
import com.appfoodiary.foodiary.vo.ListSearchVO;
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
	public List<NoticeEmailDto> selectList(ListSearchVO vo) {
		if(vo.isSearch()) {
			return search(vo);
		}
		else {
			return list(vo);
		}
	}
	
	@Override
	public List<NoticeEmailDto> list(ListSearchVO vo) {
		return sqlSession.selectList("admin-email.list",vo);
	}
	
	@Override
	public List<NoticeEmailDto> search(ListSearchVO vo) {
		return sqlSession.selectList("admin-email.search",vo);
	}
	
	@Override
	public List<MemEmailVO> emailList(){
		return sqlSession.selectList("admin-email.emailList");
	}
	
	@Override
	public int count(ListSearchVO vo) {
		if(vo.isSearch()) {//검색이라면
			return searchCount(vo); //검색 카운트 구하는 메소드
		}
		else {
			return listCount(vo);
		}
	}
	
	@Override
	public int listCount(ListSearchVO vo) {
		return sqlSession.selectOne("admin-email.listCount");
	}
	
	@Override
	public int searchCount(ListSearchVO vo) {
		return sqlSession.selectOne("admin-email.searchCount",vo);
	}

}
