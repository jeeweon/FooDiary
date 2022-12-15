package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.entity.ProfileAttachDto;
import com.appfoodiary.foodiary.vo.MemSearchVO;

public interface MemDao {
	
	//가입
	int sequence();
	void join(MemDto memDto);
	
	//단일 조회
	MemDto selectOne(int memNo);
	MemDto findByNick(String memNick);
	MemDto findByEmail(String memEmail);
	
	//로그인
	boolean login(MemDto memDto);
	
	//로그인 날짜 업데이트
	boolean updateLoginDate(int memNo);
	
	//비밀번호 확인
//	boolean checkPw(MemDto memDto);
	
	//비밀번호 재설정
	boolean resetPw(MemDto memDto);
	
	//프로필 수정
	boolean editProfile(MemDto memDto);
	
	//파일첨부
	void profileImage(ProfileAttachDto profileAttachDto);
	
	//프로필 조회
	List<AttachDto> findProfile(int memNo);
	
	//프로필 삭제
	boolean deleteProfile(int memNo);
	
	//회원 탈퇴
	boolean deleteMem(int memNo);
	
	//글 쓰기 포인트
	boolean writePoint(MemDto memDto);
	
	//맛쟁이 탐색 > 검색 결과 조회
	List<MemSearchVO> memSearchList(MemSearchVO vo);
	
	//맛쟁이 탐색 > 활동 점수 top10 조회
	List<MemSearchVO> memPointTopList();
	
	//맛쟁이 탐색 > 관심지역 같은 유저 조회(비회원)
	List<MemSearchVO> guestSameInterestList();
	
	//맛쟁이 탐색 > 관심지역 같은 유저 조회(회원)
	List<MemSearchVO> memSameInterestList(MemSearchVO vo);
}
