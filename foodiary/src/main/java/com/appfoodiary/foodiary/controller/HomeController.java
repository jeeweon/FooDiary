package com.appfoodiary.foodiary.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.service.LevelPointService;

@Controller
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	LevelPointService levelPointService;
	
	@Autowired
	private MemDao memDao;
	
	@GetMapping("")
	public String home(HttpSession session, Model model) {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		//프로필 조회
		model.addAttribute("profile",memDao.findProfile(memNo));
		
		//레벨 업데이트
		levelPointService.levelUp(memNo);
		return "home/home";
	}
	
	@GetMapping("/area/interest")
	public String areaInterest() {
		return "home/area-interest";
	}
}
