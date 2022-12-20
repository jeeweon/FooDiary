package com.appfoodiary.foodiary.repository;

import java.util.List;
import java.util.Map;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.ReviewAttachDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.vo.CheckRpLkBkVO;
import com.appfoodiary.foodiary.vo.MemRekVO;
import com.appfoodiary.foodiary.vo.ReviewSearchVO;
import com.appfoodiary.foodiary.vo.ReviewWriterVO;

public interface ReviewDao {
	//리뷰
	int newReviewNo();
	List<ReviewDto> list();
	void write(ReviewDto dto);
	ReviewDto find(int reviewNo);
	boolean edit(ReviewDto dto);
	boolean delete(int reviewNo);
	
	//리뷰 첨부파일
	void addReviewAttach(ReviewAttachDto dto);	//파일첨부
	List<AttachDto> findReviewAttachViewList(int reviewNo);	//전체 조회
	AttachDto findReviewAttachView(int reviewNo);	//대표파일 조회
	
	//홈 > 리뷰(전체/관심지역) 조회
	List<ReviewSearchVO> homeSearchList(ReviewSearchVO vo);
	
	//홈 > 리뷰(팔로우) 조회
	List<ReviewSearchVO> homeFollowList(int memNo);
	
	//맛집 탐색 > 리뷰/검색 결과 조회(비회원)
	List<ReviewSearchVO> guestSearchList(String keyword);
	//맛집 탐색 > 리뷰/검색 결과 조회(회원)
	List<ReviewSearchVO> memSearchList(ReviewSearchVO vo);
	
	//리뷰신고 테이블 : 신고+1 (insert)
	void insertReviewReport(Map<String, Object> report);
	//리뷰 테이블 : 신고수+1 (update)
	boolean plusReviewReportCnt(int reviewNo);
	//리뷰 테이블의 리뷰신고수 조회
	int selectReviewReportCnt(int reviewNo);
	//리뷰블라인드 테이블 : 신고+1 (insert)
	void insertReviewBlind(int reviewNo);
	//리뷰블라인드 테이블 : 신고수+1 (update)
	boolean plusReviewBlind(Map<String, Object> blind);
	
	//리뷰 상세
	//작성자 회원정보(+프로필)
	ReviewWriterVO selectReviewWriter(int memNo);
	//로그인회원의 좋아요,북마크 여부
	boolean loginIslike(CheckRpLkBkVO checkRpLkBkVO);
	boolean loginIsbook(CheckRpLkBkVO checkRpLkBkVO);
	//댓글 총갯수
	int replyTotal(int reviewNo);
}
