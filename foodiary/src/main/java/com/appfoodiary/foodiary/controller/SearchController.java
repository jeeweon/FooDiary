package com.appfoodiary.foodiary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/search")
public class SearchController {
	@GetMapping("/review")
	public String guestSearchReview() {
		return "search/review-search";
	}
}
