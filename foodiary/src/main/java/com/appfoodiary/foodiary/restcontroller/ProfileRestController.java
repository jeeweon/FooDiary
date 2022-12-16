package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.MyprofileDao;
import com.appfoodiary.foodiary.vo.MemRekVO;
import com.appfoodiary.foodiary.vo.ProfileMemVO;
import com.appfoodiary.foodiary.vo.ReviewListVO;

@CrossOrigin
@RestController
@RequestMapping("/rest")
public class ProfileRestController {

	@Autowired
	private MyprofileDao myprofileDao; 
	
	@GetMapping("/profile/mem")
	public ProfileMemVO profilemem(
			HttpSession session) 
	{
		int memNo = (Integer)session.getAttribute("loginNo");
		return myprofileDao.profileMemVO(memNo);
	}
	@GetMapping("profile/reviewlist")
	public List<ReviewListVO> reviewList(
			HttpSession session
			){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.reivewListVO(memNo);
	}
	
	@GetMapping("profile/bookmarklist")
	public List<ReviewListVO> bookmarkList(
			HttpSession session
			){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.bookmarkListVO(memNo);
	}
	@GetMapping("profile/likelist")
	public List<ReviewListVO> likeList(
			HttpSession session
			){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.likeListVO(memNo);
	}
	@GetMapping("profile/memrek")
	public List<MemRekVO> memRekList(
			HttpSession session){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.MemRekVO(memNo);
	}
}
