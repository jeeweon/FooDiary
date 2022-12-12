package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.entity.ProfileAttachDto;

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
	
	@Override
	public MemDto selectOne(int memNo) {
		return sqlSession.selectOne("mem.one",memNo);
	}
	
	@Override
	public MemDto findByEmail(String memEmail) {
		return sqlSession.selectOne("mem.email",memEmail);
	}
	
	@Override
	public MemDto findByNick(String memNick) {
		return sqlSession.selectOne("mem.nick", memNick);
	}
	
	@Override
	public boolean login(MemDto memDto) {
		//memDto : 암호화 되지 않은 사용자 입력 정보, findDto : 암호화된 DB 정보
		
		MemDto findDto = sqlSession.selectOne("mem.email",memDto.getMemEmail());
		if(findDto==null) return false;
		boolean judge = encoder.matches(memDto.getMemPw(), findDto.getMemPw());
		return judge;
	}
	
//	@Override
//	public boolean checkPw(String pw) {
//		MemDto findDto = sqlSession.selectOne("mem.one",memDto.getMemNo());
//		if(findDto==null) return false;
//		boolean judge = encoder.matches(memDto.getMemPw(), findDto.getMemPw());
//		return judge;
//	}
	
	@Override
	public boolean updateLoginDate(int memNo) {
		
		boolean judge = sqlSession.update("mem.loginDate", memNo)>0;
		return judge;
	}
	
	@Override
	public boolean resetPw(MemDto memDto) {
		
		String pw = memDto.getMemPw();
		String enc = encoder.encode(pw);
		memDto.setMemPw(enc);
		
		boolean judge = sqlSession.update("mem.pw",memDto)>0;
		return judge;
	}
	
//	@Override
//	public boolean editPw(MemDto memDto) {
//		
//		String pw = memDto.getMemPw();
//		String enc = encoder.encode(pw);
//		memDto.setMemPw(enc);
//		
//		boolean judge = sqlSession.update("mem.pw",memDto)>0;
//		return judge;
//	}
	
	@Override
	public boolean editProfile(MemDto memDto) {
		return sqlSession.update("mem.profile",memDto)>0;
	}
	
	@Override
	public void profileImage(ProfileAttachDto profileAttachDto) {
		sqlSession.insert("mem.profileAttach",profileAttachDto);
		
	}
	
	@Override
	public List<AttachDto> findProfile(int memNo) {
		return sqlSession.selectList("mem.findProfile",memNo);
	}
	
	@Override
	public boolean deleteProfile(int memNo) {
		return sqlSession.delete("mem.deleteProfile",memNo)>0;
	}
	

}
