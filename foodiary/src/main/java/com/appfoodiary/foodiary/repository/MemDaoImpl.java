package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.component.LevelPoint;
import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.LevelPointDto;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.entity.ProfileAttachDto;
import com.appfoodiary.foodiary.vo.MemLevelVO;
import com.appfoodiary.foodiary.vo.MemSearchVO;

@Repository
public class MemDaoImpl implements MemDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
//	private LevelPoint levelPoint;
	
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
	
	@Override
	public boolean deleteMem(int memNo) {
		return sqlSession.delete("mem.deleteMem",memNo)>0;
	}
	
	@Override
	public List<LevelPointDto> getPoint() {
		return sqlSession.selectList("mem.findPoint");
	}
	
	@Override
	public boolean updatePoint(MemDto memDto) {
		return sqlSession.update("mem.point",memDto)>0;
	}
	
	@Override
	public boolean levelUp(MemDto memDto) {
		return sqlSession.update("mem.levelUp",memDto)>0;
	}
	
	//맛쟁이 탐색 > 검색 결과 조회
	@Override
	public List<MemSearchVO> memSearchList(MemSearchVO vo) {
		return sqlSession.selectList("mem.nick-search", vo);
	}
	
	//맛쟁이 탐색 > 활동 점수 top10 조회
	@Override
	public List<MemSearchVO> memPointTopList(MemSearchVO vo) {
		return sqlSession.selectList("mem.point-top", vo);
	}
	
	//맛쟁이 탐색 > 관심지역 같은 유저 조회(비회원)
	@Override
	public List<MemSearchVO> guestSameInterestList() {
		return sqlSession.selectList("mem.guest-same-interest");
	}
	
	//맛쟁이 탐색 > 관심지역 같은 유저 조회(회원)
	@Override
	public List<MemSearchVO> memSameInterestList(MemSearchVO vo) {
		return sqlSession.selectList("mem.mem-same-interest", vo);
	}
	
	//회원 레벨과 포인트만 조회
	@Override
	public MemLevelVO memLevelAndPoint(int memNo) {
		return sqlSession.selectOne("mem.level-and-point", memNo);
	}
}
