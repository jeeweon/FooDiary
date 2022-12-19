package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.AdminDto;
import com.appfoodiary.foodiary.repository.AdminUserDao;

@Controller
@RequestMapping("/admin")
public class AdminHomeController {
	@Autowired
	private AdminUserDao adminDao;
	
	@GetMapping("/home")
	public String home() {
		return "admin/home";
	}
	
	@GetMapping("/login")
	public String login() {
		return "admin/login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute AdminDto inputDto,
			HttpSession session) {
		AdminDto findDto = adminDao.findDto(inputDto.getAdminId());
		if(findDto == null) {
			return "redirect:login?error";
		}
		// 비밀번호 검사
		boolean pwMatch = inputDto.getAdminPw().equals(findDto.getAdminPw());
		
		if(pwMatch) {
			session.setAttribute(SessionConstant.ID, findDto.getAdminId());
			// 로그인 일시 갱신
			adminDao.updateLoginDate(inputDto.getAdminId());
			return "redirect:home";
		} else {
			return "redirect:login?error";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute(SessionConstant.ID);
		return "redirect:login";
	}
	
	@GetMapping("/review-blind")
	public String reviewBlind() {
		return "admin/review-blind";
	}
}
