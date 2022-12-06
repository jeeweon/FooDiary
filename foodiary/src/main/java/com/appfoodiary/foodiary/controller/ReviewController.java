package com.appfoodiary.foodiary.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.repository.ReviewDao;

@Controller
//@CrossOrigin(origins = "http://127.0.0.1:5500/")
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewDao reviewDao;
	
	@GetMapping("/list")
	public String list(@ModelAttribute ReviewDto dto,
			Model model) {
		List<ReviewDto> list = reviewDao.list();
		model.addAttribute("list", list);
		return "review/list";
	}

	@GetMapping("/write")
	public String write() {
		return "review/write";
	}
	@PostMapping("/write")
	public String write(HttpSession session,
			@ModelAttribute ReviewDto dto, RedirectAttributes attr) {
		session.removeAttribute(SessionConstant.NO);	//★로그인 구현시 삭제예정
		session.setAttribute(SessionConstant.NO, 3);	//★로그인 구현시 삭제예정
		int memNo = (Integer)session.getAttribute(SessionConstant.NO);
		dto.setMemNo(memNo);	//세션값을 dto.memNo에 저장
		
		//reviewNo
		int reviewNo = reviewDao.newReviewNo();
		dto.setReviewNo(reviewNo);

		//write
		reviewDao.write(dto);
		
		attr.addAttribute("reviewNo", reviewNo);
		return "redirect:detail";
	}
	
	@GetMapping("/detail")
	public String detail(Model model, @RequestParam int reviewNo,
			HttpSession session) {
		ReviewDto dto = reviewDao.find(reviewNo);
		model.addAttribute("reviewDto", dto);
		return "review/detail";
	}
	
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int reviewNo) {
		return "review/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewDto dto, 
			RedirectAttributes attr) {
		reviewDao.edit(dto);
		attr.addAttribute("reviewNo", dto.getReviewNo());
		return "redirect:detail";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int reviewNo) {
		reviewDao.delete(reviewNo);
		return "redirect:list";
	}
	
}	
