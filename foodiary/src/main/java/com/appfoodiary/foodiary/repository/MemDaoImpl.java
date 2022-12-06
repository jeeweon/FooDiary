package com.appfoodiary.foodiary.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.MemDto;

@Repository
public class MemDaoImpl implements MemDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("mem.sequence");
	}
	@Override
	public void join(MemDto memDto) {
		String pw = memDto.getMemPw();
		String enc = encoder.encode(pw);
		memDto.setMemPw(enc);
		sqlSession.insert("mem.join",memDto);
	}

}
