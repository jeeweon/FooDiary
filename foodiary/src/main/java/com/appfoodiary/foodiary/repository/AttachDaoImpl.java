package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.AttachDto;

@Repository
public class AttachDaoImpl implements AttachDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int newAttachNo() {
		int attachNo = sqlSession.selectOne("attach.seq");
		return attachNo;
	}

	@Override
	public void insert(AttachDto dto) {
		sqlSession.insert("attach.insert", dto);
	}

	@Override
	public List<AttachDto> selectList() {
		return sqlSession.selectList("attach.list");
	}

	@Override
	public AttachDto selectOne(int attachNo) {
		return sqlSession.selectOne("attach.get", attachNo);
	}

	@Override
	public boolean delete(int attachNo) {
		int count = sqlSession.delete("attach.delete", attachNo);
		return count >0;
	}

}
