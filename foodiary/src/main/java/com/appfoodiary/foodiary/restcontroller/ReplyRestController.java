package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.entity.ReplyDto;
import com.appfoodiary.foodiary.repository.ReplyDao;

import io.swagger.v3.oas.annotations.tags.Tag;

@CrossOrigin(origins = "http://127.0.0.1:5500/")
@Tag(name = "reply controller")
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	ReplyDao replyDao;
	
	@GetMapping("/list")
	public List<ReplyDto> list() {
		return replyDao.list();
	}

}
