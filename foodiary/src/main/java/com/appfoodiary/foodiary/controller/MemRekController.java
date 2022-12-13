package com.appfoodiary.foodiary.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.repository.BookmarkDao;
import com.appfoodiary.foodiary.repository.FollowDao;
import com.appfoodiary.foodiary.repository.MemRekDao;
import com.appfoodiary.foodiary.repository.ReviewDao;

@Controller
@RequestMapping("/profilepage")
public class MemRekController {
	@Autowired
	private MemRekDao memRekDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private BookmarkDao bookmarkDao;
	@Autowired
	private FollowDao followDao;
	
	@GetMapping("/memrek")
	public String memrek(Model model){
		model.addAttribute("reviewcount",followDao.reviewCount(13));
		model.addAttribute("follower",followDao.follower(13));
		model.addAttribute("following",followDao.following(13));
		model.addAttribute("list",memRekDao.list());
		model.addAttribute("reviewlist",reviewDao.list());
		model.addAttribute("bookmarklist",bookmarkDao.list(14));
		return "/profilepage/memrek";
	}
}
