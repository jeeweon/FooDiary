package com.appfoodiary.foodiary.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.AdminBlindDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/blind")
public class AdminBlindRestController {
	@Autowired
	private AdminBlindDao blindDao;
	
	@PostMapping("/review/clear")
	public boolean reviewBlindClear(@RequestParam int reviewNo) {
		if(blindDao.reviewCntReset(reviewNo) && blindDao.reviewBlindClear(reviewNo)) {
			return true;
		} else {
			return false;
		}
	}
}
