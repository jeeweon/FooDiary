package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.repository.ReviewDao;

@CrossOrigin(origins = "http://127.0.0.1:5500/")
@RestController
public class ReviewController {
	
	@Autowired
	private ReviewDao dao;
	
	@GetMapping("/review")
	public List<ReviewDto> list() {
		return dao.list();
	}

//	@PostMapping()
//	public void insert() {
//		
//	}
	
//	@GetMapping("/reivew/{no}")
//	public ReviewDto find() {
//		return dao.find(no);
//	}
	
//	@PatchMapping()
//	public boolean edit() {
//		
//	}
	
//	@DeleteMapping()
//	public boolean delete() {
//		
//	}
	
	
}
