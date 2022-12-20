package com.appfoodiary.foodiary.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.ReviewAttachDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.vo.CheckRpLkBkVO;
import com.appfoodiary.foodiary.vo.ReviewSearchVO;
import com.appfoodiary.foodiary.vo.ReviewWriterVO;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSession sqlSession;
	
	//리뷰
	@Override
	public int newReviewNo() {
		int reviewNo = sqlSession.selectOne("review.seq");
		return reviewNo;
	}
	
	@Override
	public List<ReviewDto> list() {
		return sqlSession.selectList("review.list");
	}

	@Override
	public void write(ReviewDto dto) {
		sqlSession.insert("review.insert", dto);
	}

	@Override
	public ReviewDto find(int reviewNo) {
		return sqlSession.selectOne("review.get", reviewNo);
	}

	@Override
	public boolean edit(ReviewDto dto) {
		int count = sqlSession.update("review.edit", dto);
		return count >0;
	}

	@Override
	public boolean delete(int reviewNo) {
		int count = sqlSession.delete("review.delete", reviewNo);
		return count >0;
	}

	//리뷰 파일첨부
	@Override
	public void addReviewAttach(ReviewAttachDto dto) {
		sqlSession.insert("review.insertAttach", dto);
	}
	//리뷰 파일조회
	@Override
	public List<AttachDto> findReviewAttachViewList(int reviewNo) {
		return sqlSession.selectList("review.findAttach", reviewNo);
	}
	//리뷰 대표파일 조회
	@Override
	public AttachDto findReviewAttachView(int reviewNo) {
		return sqlSession.selectOne("review.findAttachRep", reviewNo);
	}
	
	//홈 > 리뷰(전체/관심지역) 조회
	@Override
	public List<ReviewSearchVO> homeSearchList(ReviewSearchVO vo) {	
		return sqlSession.selectList("review.home-list", vo);
	}

	//홈 > 리뷰(팔로우) 조회
	@Override
	public List<ReviewSearchVO> homeFollowList(int memNo) {
		return sqlSession.selectList("review.home-follow", memNo);
	}
	
	//맛집 탐색 > 리뷰/검색 결과 조회(비회원)
	@Override
	public List<ReviewSearchVO> guestSearchList(String keyword) {
		return sqlSession.selectList("review.search-guest", keyword);
	}
	
	//맛집 탐색 > 리뷰/검색 결과 조회(회원)
	@Override
	public List<ReviewSearchVO> memSearchList(ReviewSearchVO vo) {
		return sqlSession.selectList("review.search-mem", vo);
	}

	//리뷰신고 테이블 : 신고+1 (insert)
	@Override
	public void insertReviewReport(Map<String, Object> report) {
		sqlSession.insert("review.insertReviewReport", report);
	}
	//리뷰 테이블 : 신고수+1 (update)
	@Override
	public boolean plusReviewReportCnt(int reviewNo) {
		int count = sqlSession.update("review.plusReviewReportCnt", reviewNo);
		return count >0;
	}
	//리뷰 테이블의 리뷰신고수 조회
	@Override
	public int selectReviewReportCnt(int reviewNo) {
		return sqlSession.selectOne("review.selectReviewReportCnt", reviewNo);
	}
	//리뷰블라인드 테이블 : 신고+1 (insert)
	@Override
	public void insertReviewBlind(int reviewNo) {
		sqlSession.insert("review.insertReviewBlind", reviewNo);
	}
	//리뷰블라인드 테이블 : 신고수+1 (update)
	@Override
	public boolean plusReviewBlind(Map<String, Object> blind) {
		int count = sqlSession.update("review.plusReviewBlind", blind);
		return count >0;
	}

	
	//리뷰 상세
	//작성자 회원정보(+프로필)
	@Override
	public ReviewWriterVO selectReviewWriter(int memNo) {
		return sqlSession.selectOne("review.mem-frofile", memNo);
	}
	//로그인회원의 좋아요,북마크 여부
	@Override
	public boolean loginIslike(CheckRpLkBkVO checkRpLkBkVO) {
		int count = sqlSession.selectOne("review.loginIslike",checkRpLkBkVO);
		if(count >=1) {return true;}
		else {return false;}
	}
	@Override
	public boolean loginIsbook(CheckRpLkBkVO checkRpLkBkVO) {
		int count = sqlSession.selectOne("review.loginIsBook",checkRpLkBkVO);
		if(count >=1) {return true;}
		else {return false;}
	}
	//댓글 총갯수
	@Override
	public int replyTotal(int reviewNo) {
		int count = sqlSession.selectOne("review.replyTotal",reviewNo);
		return count;
	}

}
