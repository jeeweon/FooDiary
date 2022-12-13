package com.appfoodiary.foodiary.repository;

import java.util.List;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.entity.ProfileAttachDto;

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
	
}
