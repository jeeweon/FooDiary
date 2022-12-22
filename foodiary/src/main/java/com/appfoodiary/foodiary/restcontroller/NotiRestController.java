package com.appfoodiary.foodiary.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.NotiDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/noti")
public class NotiRestController {
	@Autowired
	private NotiDao notiDao;
	
	@GetMapping("/read/{notiNo}")
	public boolean updateReadDate(@PathVariable int notiNo) {
		log.debug("들어옴");
		log.debug("notiNo=" + notiNo);
		return notiDao.updateReadDate(notiNo);
	}
}
