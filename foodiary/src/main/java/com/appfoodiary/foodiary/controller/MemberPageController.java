package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.FollowDto;
import com.appfoodiary.foodiary.repository.FollowDao;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.repository.MyprofileDao;
import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.vo.FollowVO;


@Controller
@RequestMapping("/profilepage")
public class MemberPageController {
	
	@Autowired
	private MemDao memDao;
	@Autowired
	private MyprofileDao myprofileDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private FollowDao followDao;
	
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
		FollowVO vo=FollowVO.builder()
				.follow(followDao.follower(memNo))
				.follower(followDao.following(memNo))
				.review(myprofileDao.reviewCnt(memNo))
				.build();
		model.addAttribute("followcnt",vo);
		model.addAttribute("list",memDao.selectOne(memNo));
		return "profilepage/myprofileheader";
	}
	
	@GetMapping("/my-profile-header")
	public String follow() {
		return "profilepage/my-profile-header";
	}
	@GetMapping("/board")
	public String follower() {
		return "profilepage/board";
	}
	@GetMapping("/yourprofile")
	public String yourprofile(
			@RequestParam int memNo,
			Model model 
			) {
		model.addAttribute("memNo",memNo);
		return "/profilepage/yourprofile";
	}
	@GetMapping("/yourreviewlist")
	public String yourreviewlist(
			@RequestParam int memNo,
			Model model) {
		model.addAttribute("memNo",memNo);
		return "/profilepage/yourreviewlist";
	}
}
