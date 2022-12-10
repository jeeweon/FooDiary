package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.repository.AreaDao;

@Controller
@RequestMapping("/home")
public class HomeController {
	@Autowired
	private AreaDao areaDao;
	
	@GetMapping("")
	public String home(Model model, HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		model.addAttribute("myAreasList", areaDao.myAreas(memNo));
		return "home/home";
	}
	
	@GetMapping("/area/interest")
	public String areaInterest(Model model) {
		return "home/area-interest";
	}
}
