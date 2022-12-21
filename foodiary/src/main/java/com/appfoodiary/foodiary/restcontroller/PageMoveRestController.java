package com.appfoodiary.foodiary.restcontroller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest")
public class PageMoveRestController {
	
	@GetMapping("/profilepage/board")
	public String board() {
		return "redirect:/profilepage/board";
	}

}
