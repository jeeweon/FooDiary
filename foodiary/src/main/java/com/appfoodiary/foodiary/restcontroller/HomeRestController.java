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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@Slf4j
@RestController
@Tag(name = "home-rest-controller", description = "홈")
@RequestMapping("/rest/home")
public class HomeRestController {
	@Autowired
	private ReviewDao reviewDao;
	
	@GetMapping(value = {"/review/{interestArea}", "/review"})
	@Operation(summary = "리뷰 목록(전체/관심지역 한정)")
	public List<ReviewSearchVO> allOrAreaReviewList(@PathVariable (required=false) String interestArea,
			ReviewSearchVO vo, HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		vo.setMemNo(memNo);
		return reviewDao.homeSearchList(vo);
	}
	
	@GetMapping("/review/follow")
	@Operation(summary = "리뷰 목록(팔로우)")
	public List<ReviewSearchVO> followReviewList(HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		return reviewDao.homeFollowList(memNo);
	}
	
	
}
