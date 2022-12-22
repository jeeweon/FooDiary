package com.appfoodiary.foodiary.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.ReplyDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.repository.ReplyDao;
import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.vo.ReplyListVO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.log4j.Log4j2;

@CrossOrigin(origins = "http://127.0.0.1:5500/")
@Tag(name = "reply controller", description = "댓글")
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	ReplyDao replyDao;
	@Autowired
	ReviewDao reviewDao;
	
	@GetMapping("/{reviewNo}")
	@Operation(summary = "댓글목록 조회", description = "reviewNo 리뷰의 댓글목록을 조회합니다.")
	public List<ReplyListVO> list(@PathVariable int reviewNo) {
		return replyDao.list(reviewNo);
	}
	
	@PostMapping
	@Operation(summary = "댓글 추가", description = "댓글을 추가합니다.")
	public boolean insert(@RequestBody ReplyDto dto) {
		int replyNo = replyDao.newReplyNo();
		dto.setReplyNo(replyNo);
		
		replyDao.write(dto);
		
		int reviewNo = dto.getReviewNo();
		reviewDao.plusReplycnt(reviewNo);
		
		return true;
	}
	
	@DeleteMapping("/{replyNo}")
	@Operation(summary = "댓글 삭제", description = "replyNo 댓글을 삭제합니다.")
	public boolean delete(@PathVariable int replyNo) {
		
		ReplyDto dto = replyDao.find(replyNo);
		int reviewNo = dto.getReviewNo();

		replyDao.delete(replyNo);
		reviewDao.minusReplycnt(reviewNo);
		
		return true;
	}
	
	//댓글 신고 카운트+1
	@PostMapping("/report/{replyNo}")
	@Operation(summary = "댓글 신고처리", description = "replyNo를 이용하여 신고처리를 합니다.")
	public boolean report(@PathVariable int replyNo,
			HttpSession session) {
		//신고접수 과정
		//1. 리뷰신고 테이블 : 신고 +1(insert)
		Map<String, Object> report = new HashMap<>();
		report.put("replyNo", replyNo);
		report.put("memNo", (Integer)session.getAttribute(SessionConstant.NO));
		replyDao.insertReplyReport(report);
		
		//2. 리뷰 테이블 : 리뷰신고수 +1(update)
		replyDao.plusReplyReportCnt(replyNo);
		//	- 추가한 이후, 리뷰 테이블의 리뷰신고수 조회 	
		int replyReportCnt = replyDao.selectReplyReportCnt(replyNo);
		
		//3. 리뷰블라인드 테이블
		//	- 리뷰테이블 신고수 1	: 리뷰블라인드 테이블 +1(insert), 신고수+1 (상태: 0-대기)
		if(replyReportCnt==1) {
			replyDao.insertReplyBlind(replyNo);
		}
		//	- 리뷰테이블 신고수 2~4	: 블라인드 상태 0(대기)인 데이터의 신고수 +1
		//	- 리뷰테이블 신고수 5	: 블라인드 상태 1(블라인드)로 변경, 신고수 +1
		//	- 리뷰테이블 신고수 6~	: 블라인드 상태 1(블라인드)인 데이터의 신고수 +1
		else if(replyReportCnt>1) {
			Map<String, Object> blind = new HashMap<>();
			blind.put("replyNo", replyNo);
			blind.put("replyReportCnt", replyReportCnt);
			replyDao.plusReplyBlind(blind);
		}
		
		return true;
	}
	

}
