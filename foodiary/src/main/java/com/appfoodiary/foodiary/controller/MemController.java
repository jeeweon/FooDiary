package com.appfoodiary.foodiary.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.repository.MemDao;

@Controller
@RequestMapping("/mem")
public class MemController {
	
	@Autowired
	private MemDao memDao;
	
	@GetMapping("/join")
	public String join() {
		return "mem/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemDto memDto) {
		memDao.join(memDto);
		return "redirect:join-finish";
	}
	
	@RequestMapping("/join_finish")
	public String joinFinish() {
		return "mem/join-finish";
	}
	

}
