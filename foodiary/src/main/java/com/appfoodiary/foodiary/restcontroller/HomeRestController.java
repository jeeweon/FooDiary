package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.vo.ReviewSearchVO;

import lombok.extern.slf4j.Slf4j;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@Slf4j
@RestController
@RequestMapping("/rest")
public class HomeRestController {
	@Autowired
	private ReviewDao reviewDao;
	
	@GetMapping(value = {"/home/review/{interestArea}", "/home/review"})
	public List<ReviewSearchVO> allOrAreaReviewList(@PathVariable (required=false) String interestArea,
			ReviewSearchVO vo, HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		vo.setMemNo(memNo);
		return reviewDao.homeSearchList(vo);
	}
	
	@GetMapping("/home/review/follow")
	public List<ReviewSearchVO> followReviewList(HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		return reviewDao.homeFollowList(memNo);
	}
	
	
}
