package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.AdminBlindDao;
import com.appfoodiary.foodiary.vo.ReviewBlindVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/blind")
public class AdminBlindRestController {
	@Autowired
	private AdminBlindDao blindDao;
	
}
