package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.service.LevelPointService;

@Controller
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	private LevelPointService levelPointService;
	
	@Autowired
	private MemDao memDao;
	
	@GetMapping("")
	public String home(HttpSession session, Model model) {
		if((Integer) session.getAttribute(SessionConstant.NO) != null) {
			int memNo = (Integer) session.getAttribute(SessionConstant.NO);
			//프로필 조회
			model.addAttribute("profile",memDao.findProfile(memNo));
			
			//레벨, 포인트만 조회
			model.addAttribute("level", memDao.memLevelAndPoint(memNo));
			
			//레벨 업데이트
			levelPointService.levelUp(memNo);
			return "home/home";
		} else {
			return "redirect:/search/review";
		}
	}
	
	@GetMapping("/area/interest")
	public String areaInterest() {
		return "home/area-interest";
	}
}
