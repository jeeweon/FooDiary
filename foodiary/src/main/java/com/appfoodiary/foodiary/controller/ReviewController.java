package com.appfoodiary.foodiary.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.ReviewAttachDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.service.AttachmentService;

//@CrossOrigin(origins = "http://127.0.0.1:5500/")
@Controller
@RequestMapping("/review")
public class ReviewController {
	
	//private final File dir = new File("D:\\upload\\kh10g");	//파일 경로
	private final File dir = new File(System.getProperty("user.home") + "/upload"); //OS 무관 파일 경로(배포 시, 삭제 예정)
	@PostConstruct	//최초 실행 시, 딱 한번만 실행
	public void prepare() {
		dir.mkdirs();	//파일 생성
	}
	
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private AttachmentService attachmentService;
	
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
			@ModelAttribute ReviewDto dto, 
			@RequestParam List<MultipartFile> attachments, RedirectAttributes attr) 
															throws IllegalStateException, IOException {
		session.removeAttribute(SessionConstant.NO);	//★로그인 구현시 삭제예정
		session.setAttribute(SessionConstant.NO, 14);	//★로그인 구현시 삭제예정
		int memNo = (Integer)session.getAttribute(SessionConstant.NO);
		dto.setMemNo(memNo);	//세션값을 dto.memNo에 저장
		
		//reviewNo
		int reviewNo = reviewDao.newReviewNo();
		dto.setReviewNo(reviewNo);

		//write
		reviewDao.write(dto);
		
		//파일 첨부
		for(MultipartFile file : attachments) {
			if(!file.isEmpty()) {	//파일이 있다면
				int attachNo = attachmentService.attachmentsUp(attachments, file);	//attach 추가
				
				ReviewAttachDto reviewAttachDto = new ReviewAttachDto(attachNo, reviewNo);	
				reviewDao.addReviewAttach(reviewAttachDto);	//reviewAttach DB 저장
			}
		}
		
		attr.addAttribute("reviewNo", reviewNo);
		return "redirect:detail";
	}
	
	@GetMapping("/detail")
	public String detail(HttpSession session,
			Model model, @RequestParam int reviewNo) {
		//리뷰정보
		ReviewDto dto = reviewDao.find(reviewNo);
		model.addAttribute("reviewDto", dto);
		
		//첨부파일 조회, 첨부
		model.addAttribute("attachments", reviewDao.findReviewAttachViewList(reviewNo));
		return "review/detail";
	}
	
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int reviewNo) {
		ReviewDto reviewDto = reviewDao.find(reviewNo);
		model.addAttribute("reviewDto", reviewDto);
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
		//리뷰 삭제 전, review_attach 조회
		List<AttachDto> attachments = reviewDao.findReviewAttachViewList(reviewNo);
		
		//리뷰 삭제 (DB: review_attach 자동삭제)
		boolean result = reviewDao.delete(reviewNo);
		
		if(result) {	//리뷰삭제 성공
			//(DB: attach테이블), 실제파일 삭제
			attachmentService.attachmentsDelete(attachments);
			return "redirect:list";
		}
		return "redirect:list";	//삭제 실패
	}
	
}	
