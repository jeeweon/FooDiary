package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.service.LevelPointService;

@Controller
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	LevelPointService levelPointService;
	
	@GetMapping("")
	public String home(HttpSession session) {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		//레벨 업데이트
		levelPointService.levelUp(memNo);
		return "home/home";
	}
	
	@GetMapping("/area/interest")
	public String areaInterest() {
		return "home/area-interest";
	}
}
