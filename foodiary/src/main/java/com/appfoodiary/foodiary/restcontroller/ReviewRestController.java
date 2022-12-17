package com.appfoodiary.foodiary.restcontroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.repository.ReviewDao;



@CrossOrigin(origins = "http://127.0.0.1:5500/")
@RestController
@RequestMapping("/rest/review")
public class ReviewRestController {
	
	@Autowired
	private ReviewDao reviewDao;

	//리뷰 신고 카운트+1
	@PostMapping("/report/{reviewNo}")
	public boolean report(@PathVariable int reviewNo,
			HttpSession session) {
		//신고접수 과정
		//1. 리뷰신고 테이블 : 신고 +1(insert)
		Map<String, Object> report = new HashMap<>();
		report.put("reviewNo", reviewNo);
		report.put("memNo", (Integer)session.getAttribute(SessionConstant.NO));
		reviewDao.insertReviewReport(report);
		
		//2. 리뷰 테이블 : 리뷰신고수 +1(update)
		reviewDao.plusReviewReportCnt(reviewNo);
		//	- 추가한 이후, 리뷰 테이블의 리뷰신고수 조회 	
		int reviewReportCnt = reviewDao.selectReviewReportCnt(reviewNo);
		
		//3. 리뷰블라인드 테이블
		//	- 리뷰테이블 신고수 1	: 리뷰블라인드 테이블 +1(insert), 신고수+1 (상태: 0-대기)
		if(reviewReportCnt==1) {
			reviewDao.insertReviewBlind(reviewNo);
		}
		//	- 리뷰테이블 신고수 2~4	: 블라인드 상태 0(대기)인 데이터의 신고수 +1
		//	- 리뷰테이블 신고수 5	: 블라인드 상태 1(블라인드)로 변경, 신고수 +1
		//	- 리뷰테이블 신고수 6~	: 블라인드 상태 1(블라인드)인 데이터의 신고수 +1
		else if(reviewReportCnt>1) {
			Map<String, Object> blind = new HashMap<>();
			blind.put("reviewNo", reviewNo);
			blind.put("reviewReportCnt", reviewReportCnt);
			reviewDao.plusReviewBlind(blind);
		}
		
		return true;
	}
	
	//리뷰블라인드 테이블 : 블라인드 상태 2(해제)시
	//1. 블라인드 해제일자 update + 상태 2(해제)로 변경
	//2. 리뷰 테이블 : 리뷰 신고수 0으로 초기화
	
	//블라인드 번호에 해당하는 신고내역 화면
	//- 리뷰신고 테이블 데이터 : 신고일자(블라인드 신고시작일~해제일)
	//- 5번째신고 = 블라인드 시작일
}
