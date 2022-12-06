package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.BookmarkDto;

@Repository
public class BookmarkDaoImpl implements BookmarkDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(BookmarkDto dto) {
		sqlSession.insert("bookmark.insert",dto);
	}
	@Override
	public void delete(BookmarkDto dto) {
		sqlSession.delete("bookmark.delete",dto);
	}
	@Override
	public List<BookmarkDto> list(BookmarkDto dto) {
		return sqlSession.selectList("bookmark.list",dto);
	}
	@Override
	public boolean cert(BookmarkDto dto) {
		int count=sqlSession.selectOne("bookmark.cert", dto);
		return count>0;
	}
}
