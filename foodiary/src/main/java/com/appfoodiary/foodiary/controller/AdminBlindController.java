package com.appfoodiary.foodiary.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.appfoodiary.foodiary.repository.AdminBlindDao;
import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.vo.BlindReviewContentsVO;

@Controller
@RequestMapping("/admin/blind")
public class AdminBlindController {
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private AdminBlindDao blindDao;
	
	@GetMapping("/review")
	public String reviewBlind(Model model) {
		model.addAttribute("list", blindDao.reviewBlindList());
		return "admin/review-blind";
	}
	
	@GetMapping("/review/detail")
	public String reviewBlindDetail(@RequestParam int reviewNo, Model model) {
		//리뷰정보
		BlindReviewContentsVO reviewVO = blindDao.selectOne(reviewNo);
		model.addAttribute("reviewVO", reviewVO);
		
		//첨부파일
		model.addAttribute("attachments", reviewDao.findReviewAttachViewList(reviewNo));
		
		//신고내역
		Date reviewReportStart = blindDao.reviewReportStart(reviewNo);
		
		Map<String, Object> history = new HashMap<>();
		history.put("reviewNo", reviewNo);
		history.put("reportStartTime", reviewReportStart);
		model.addAttribute("history", blindDao.reviewReportHistory(history));
		return "admin/review-blind-detail";
	}
}
