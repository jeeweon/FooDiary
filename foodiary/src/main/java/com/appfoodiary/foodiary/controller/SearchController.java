package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.repository.NotiDao;

@Controller
@RequestMapping("/search")
public class SearchController {
	@Autowired
	private MemDao memDao;
	
	@Autowired
	private NotiDao notiDao;
	
	@GetMapping("/review")
	public String searchReview(HttpSession session, Model model) {
		if((Integer) session.getAttribute(SessionConstant.NO) != null) {
			int memNo = (Integer) session.getAttribute(SessionConstant.NO);
			//프로필 조회
			model.addAttribute("profile",memDao.findProfile(memNo));
			
			//레벨, 포인트만 조회
			model.addAttribute("level", memDao.memLevelAndPoint(memNo));
			
			//알림 내역 조회
			model.addAttribute("list", notiDao.myNotiList(memNo));
			model.addAttribute("cnt", notiDao.noReadCnt(memNo));
		} 
		return "search/review-search";
	}
	
	@GetMapping("/mem")
	public String searchMem(HttpSession session, Model model) {
		if((Integer) session.getAttribute(SessionConstant.NO) != null) {
			int memNo = (Integer) session.getAttribute(SessionConstant.NO);
			//프로필 조회
			model.addAttribute("profile",memDao.findProfile(memNo));
			
			//레벨, 포인트만 조회
			model.addAttribute("level", memDao.memLevelAndPoint(memNo));
			
			//알림 내역 조회
			model.addAttribute("list", notiDao.myNotiList(memNo));
			model.addAttribute("cnt", notiDao.noReadCnt(memNo));
		} 
		return "search/mem-search";
	}
}
