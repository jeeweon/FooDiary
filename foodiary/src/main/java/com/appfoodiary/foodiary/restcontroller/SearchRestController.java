package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.vo.MemSearchVO;
import com.appfoodiary.foodiary.vo.ReviewSearchVO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@Slf4j
@RestController
@Tag(name = "search rest controller", description = "리뷰/유저 탐색")
@RequestMapping("/rest/search")
public class SearchRestController {
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private MemDao memDao;
	
	//비회원 리뷰 조회
	@GetMapping(value = {"/review/guest/{keyword}", "/review/guest"})
	@Operation(summary = "비회원 리뷰 목록")
	public List<ReviewSearchVO> guestSearchList(@PathVariable (required=false) String keyword) {
		return reviewDao.guestSearchList(keyword);
	}
	
	//회원 리뷰 조회
	@GetMapping(value = {"/review/{keyword}", "/review"})
	@Operation(summary = "회원 리뷰 목록")
	public List<ReviewSearchVO> memSearchList(@PathVariable (required=false) String keyword,
			ReviewSearchVO vo, HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		vo.setMemNo(memNo);
		vo.setKeyword(keyword);
		return reviewDao.memSearchList(vo);
	}
	
	//회원 닉네임 검색 결과 조회
	@GetMapping("/mem/{keyword}")
	@Operation(summary = "회원 닉네임 검색 결과")
	public List<MemSearchVO> userSearchList(@PathVariable String keyword,
			MemSearchVO vo, HttpSession session) {
		if((Integer)session.getAttribute("loginNo") != null) {
			vo.setMemNo((Integer)session.getAttribute("loginNo"));
		}
		vo.setKeyword(keyword);
		return memDao.memSearchList(vo);
	}
	
	//활동점수 높은 순 top5 회원 조회
	@GetMapping("/mem/point-top")
	@Operation(summary = "활동점수 top5 회원")
	public List<MemSearchVO> memPointTopList(MemSearchVO vo, HttpSession session) {
		if((Integer)session.getAttribute("loginNo") != null) {
			vo.setMemNo((Integer)session.getAttribute("loginNo"));
		}
		return memDao.memPointTopList(vo);
	}
	
	//맛쟁이 탐색 > 관심지역 같은 유저 조회(비회원)
	@GetMapping("/mem/same-interest/guest")
	@Operation(summary = "관심지역 같은 유저 목록(비회원)")
	public List<MemSearchVO> guestSameInterestList() {
		return memDao.guestSameInterestList();
	}
	
	//맛쟁이 탐색 > 관심지역 같은 유저 조회(회원)
	@GetMapping("/mem/same-interest/{keyword}")
	@Operation(summary = "관심지역 같은 유저 목록(회원)")
	public List<MemSearchVO> memSameInterestList(@PathVariable String keyword,
			MemSearchVO vo, HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		vo.setMemNo(memNo);
		vo.setKeyword(keyword);
		return memDao.memSameInterestList(vo);
	}
}
