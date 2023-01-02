package com.appfoodiary.foodiary.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.NotiDao;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@RestController
@Tag(name = "noti-rest-controller", description = "실시간 알림")
@RequestMapping("/rest/noti")
public class NotiRestController {
	@Autowired
	private NotiDao notiDao;
	
	@GetMapping("/read/{notiNo}")
	@Operation(summary = "알림 읽음 처리")
	public boolean updateReadDate(@PathVariable int notiNo) {
		return notiDao.updateReadDate(notiNo);
	}
}
