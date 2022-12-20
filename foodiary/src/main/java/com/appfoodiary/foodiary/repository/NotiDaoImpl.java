package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.NotiDto;

@Repository
public class NotiDaoImpl implements NotiDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void saveNoti(NotiDto notiDto) {
		sqlSession.insert("noti.save", notiDto);
	}
	
	@Override
	public List<NotiDto> myNotiList(int memNo) {
		return sqlSession.selectList("noti.list", memNo);
	}
}
