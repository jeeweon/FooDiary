package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.repository.MemDao;


@Controller
@RequestMapping("/profilepage")
public class MemberPageController {
	
	@Autowired
	private MemDao memDao;
	
	@GetMapping("/myprofile")
	public String myprfile(
			Model model,
			HttpSession session
			) {
		//String loginId=(String)session.getAttribute(SessionConstant.ID);
		//model.addAttribute("memdao",memDao.selectOne(loginId));
		return "profilepage/myprofile";
	}
	@GetMapping("/board")
	public String board() {
		return "profilepage/board";
	}
	@GetMapping("/like")
	public String like() {
		return "profilepage/like";
	}
	@GetMapping("/bookmark")
	public String bookmark() {
		return "profilepage/bookmark";
	}
}
