package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.repository.MyprofileDao;
import com.appfoodiary.foodiary.repository.ReviewDao;


@Controller
@RequestMapping("/profilepage")
public class MemberPageController {
	
	@Autowired
	private MemDao memDao;
	@Autowired
	private MyprofileDao myprofileDao;
	@Autowired
	private ReviewDao reviewDao;
	
	@GetMapping("/myprofile")
	public String myprfile(
			Model model,
			HttpSession session
			) {
		//String loginId=(String)session.getAttribute(SessionConstant.ID);
		//model.addAttribute("memdao",memDao.selectOne(loginId));
		return "profilepage/myprofile";
	}
	@GetMapping("/board2")
	public String board(
			Model model,
			HttpSession session
			) {
		//한회원에 대해하여 리뷰 정보를 가지고 온다.
		int memNo = (Integer)session.getAttribute(SessionConstant.NO);
		model.addAttribute("list",myprofileDao.reviewList(memNo));
		return "profilepage/board2";
	}
	@GetMapping("/like")
	public String like(
			Model model,
			HttpSession session
			) {
		int memNo=(Integer)session.getAttribute(SessionConstant.NO);
		model.addAttribute("list",myprofileDao.likeList(memNo));
		return "profilepage/like";
	}
	@GetMapping("/bookmark")
	public String bookmark(
			Model model,
			HttpSession session
			) {
		int memNo = (Integer)session.getAttribute(SessionConstant.NO);
		model.addAttribute("list",myprofileDao.bookmarkList(memNo));
		return "profilepage/bookmark";
	}
	
	@GetMapping("/myprofileheader")
	public String myprofileheader(
			Model model,
			HttpSession session) {
		int memNo = (Integer)session.getAttribute(SessionConstant.NO);
		model.addAttribute("list",memDao.selectOne(memNo));
		//model.addAttribute("reviewcnt",myprofileDao.reviewCnt(memNo));
		return "profilepage/myprofileheader";
	}
}
