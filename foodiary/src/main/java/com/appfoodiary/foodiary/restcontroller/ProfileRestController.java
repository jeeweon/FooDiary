package com.appfoodiary.foodiary.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.MyprofileDao;
import com.appfoodiary.foodiary.vo.ProfileMemVO;

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
}
