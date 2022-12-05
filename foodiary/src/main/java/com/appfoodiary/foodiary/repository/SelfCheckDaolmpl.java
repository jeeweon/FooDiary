package com.appfoodiary.foodiary.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.SelfCheckDto;

@Repository
public class SelfCheckDaolmpl implements SelfCheckDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(SelfCheckDto selfCheckDto) {
		sqlSession.insert("selfCheck.insert",selfCheckDto);
		
	}
	
	@Override
	public boolean check(SelfCheckDto selfCheckDto) {
		SelfCheckDto result = sqlSession.selectOne("selfCheck.check",selfCheckDto);
		return result !=null;
	}
	
	@Override
	public boolean delete(String who) {
		int count = sqlSession.delete("selfCheck.delete",who);
		return count>0;
	}
	
	@Override
	public void clear() {
		sqlSession.delete("selfCheck.clear");
		
	}
}
