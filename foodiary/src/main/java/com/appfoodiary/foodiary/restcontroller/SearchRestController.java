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
@RequestMapping("/rest/search")
public class SearchRestController {
	@Autowired
	private ReviewDao reviewDao;
	
	//비회원 리뷰 조회
	@GetMapping(value = {"/guest/review/{keyword}", "/guest/review"})
	public List<ReviewSearchVO> guestSearchList(@PathVariable (required=false) String keyword) {
		return reviewDao.guestSearchList(keyword);
	}
	
	//회원 리뷰 조회
	@GetMapping(value = {"/review/{keyword}", "/review"})
	public List<ReviewSearchVO> memSearchList(@PathVariable (required=false) String keyword,
			ReviewSearchVO vo, HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		vo.setMemNo(memNo);
		vo.setKeyword(keyword);
		return reviewDao.memSearchList(vo);
	}
}
