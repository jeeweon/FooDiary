package com.appfoodiary.foodiary.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.entity.ProfileAttachDto;
import com.appfoodiary.foodiary.repository.AttachDao;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.service.AttachmentService;
import com.appfoodiary.foodiary.service.EmailService;

@Controller
@RequestMapping("/mem")
public class MemController {
	
	@Autowired
	private MemDao memDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private AttachmentService attachmentService;
	
	@Autowired
	private EmailService emailService;
	
	@GetMapping("/join")
	public String join() {
		return "mem/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemDto memDto) {
		int memNo = memDao.sequence();
		memDao.join(MemDto.builder()
				.memNo(memNo)
				.memEmail(memDto.getMemEmail())
				.memPw(memDto.getMemPw())
				.memNick(memDto.getMemNick())
				.memBirth(memDto.getMemBirth())
			.build());
		return "redirect:join_finish";
	}
	
	@RequestMapping("/join_finish")
	public String joinFinish() {
		return "mem/join-finish";
	}
	
	@GetMapping("/login")
	public String login() {
		return "mem/login";
	}
	
	@PostMapping("/login")
	public String login(
			@ModelAttribute MemDto inputDto, HttpSession session) {
				
		boolean judge = memDao.login(inputDto);
		MemDto findDto = memDao.findByEmail(inputDto.getMemEmail());
		
		if(judge){
			session.setAttribute(SessionConstant.NO, findDto.getMemNo());
			session.setAttribute(SessionConstant.NICK, findDto.getMemNick());
			
			//로그인 시간 업데이트
			memDao.updateLoginDate(findDto.getMemNo());
			return "redirect:/home";
		}
		else {
			return "redirect:login?error";
		}	
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		//세션에서 loginNo, loginNick 데이터 삭제
		session.removeAttribute(SessionConstant.NO);
		session.removeAttribute(SessionConstant.NICK);
		return "redirect:/search/review";
	}
	
	//비밀번호 재설정
	//1.연결된 계정 있는지 이메일 체크
	@GetMapping("/email_check")
	public String emailCheck() {
		return "mem/email-check";
	}
	
	@PostMapping("/email_check")
	public String emailCheck(@RequestParam String memEmail,
								RedirectAttributes attr) {
		
		MemDto findDto = memDao.findByEmail(memEmail);
		
		if(findDto==null) {
			return "redirect:email_check?error";
		}
		else {
			attr.addAttribute("memEmail", memEmail);
			return "redirect:email_send";			
		}
	}
	
	//2. 이메일 본인인증
	@GetMapping("/email_send")
	public String emailSend() {
		return "mem/email-send";
	}
	
	@PostMapping("/email_send")
	public String emailSend(@RequestParam String memEmail,
							RedirectAttributes attr) {
		MemDto memDto = memDao.findByEmail(memEmail);
		attr.addFlashAttribute("memDto",memDto);
		return "redirect:reset_pw";
	}
	
	//3. 비밀번호 재설정
	@GetMapping("/reset_pw")
	public String resetPw(@ModelAttribute MemDto memDto) {
		
		if(memDto!=null) {
			return "mem/reset-pw";			
		}
		else {
			return "redirect:reset_pw?error"; //error 페이지로 가게 할 수는 없나?
		}
	}
	
	@PostMapping("/reset_pw")
	public String resetPw(@ModelAttribute MemDto memDto,Model model) {
		boolean result = memDao.resetPw(memDto);
		
		if(result) {			
			return "redirect:login";
		}
		else {
			return "redirect:reset_pw?error";
		}
	}
	
//	@PostMapping("/reset_pw")
//	public String resetPw(@ModelAttribute MemDto memDto) {
//		MemDto memDto = memDao.findByEmail(memEmail);
//		boolean result = memDao.resetPw(memDto);
//		
//		if(result) {			
//			return "redirect:login";
//		}
//		else {
//			return "redirect:reset_pw?error";
//		}
//	}
	
	@GetMapping("/check_pw")
	public String checkPw() {
		return "mem/check-pw";
	}
	
	@PostMapping("/check_pw")
	public String checkPw(HttpSession session,
						@RequestParam String beforePw,
						RedirectAttributes attr) {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		MemDto loginDto = memDao.selectOne(memNo);
		boolean judge = encoder.matches(beforePw, loginDto.getMemPw());
		
		if(judge) {
			attr.addFlashAttribute("memNo", memNo);
			return "redirect:edit_pw";
		}
		else {
			return "redirect:check_pw?error"; 
		}
	}

	@GetMapping("/edit_pw")
	public String editPw() {
		return "mem/edit-pw";
	}
	@PostMapping("/edit_pw")
	public String editPw(HttpSession session,
						@RequestParam int memNo, String memPw) {
		
		MemDto loginDto = memDao.selectOne(memNo);
		
		loginDto.setMemPw(memPw);
		boolean result = memDao.resetPw(loginDto);
		
		
		if(result) {			
			return "redirect:login"; //마이 프로필 이동으로 수정하기
		}
		else {
			return "redirect:edit_pw?error";
		}
	}
	
//	@PostMapping("/edit_pw")
//	public String editPw(@RequestParam int memNo,
//							@RequestParam String memPw) {
//		
//		MemDto loginDto = memDao.selectOne(memNo);
//		
//		loginDto.setMemPw(memPw);
//		boolean result = memDao.resetPw(loginDto);
//		
//		
//		if(result) {			
//			return "redirect:login"; //마이 프로필 이동으로 수정하기
//		}
//		else {
//			return "redirect:edit_pw?error";
//		}
//	}
	
	@GetMapping("/edit_profile")
	public String editProfile(HttpSession session,
								Model model ) throws IOException {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		MemDto memDto = memDao.selectOne(memNo);
		model.addAttribute("memDto",memDto);
		model.addAttribute("profile",memDao.findProfile(memNo));			

		return "mem/edit-profile";
		
	}
	
	@PostMapping("/edit_profile")
	public String editProfile(HttpSession session, @ModelAttribute MemDto inputDto, @RequestParam MultipartFile profile) throws IllegalStateException, IOException {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		inputDto.setMemNo(memNo);
		
		if(!profile.isEmpty()) {
			int attachNo = attachmentService.attachUp(profile);
			ProfileAttachDto profileAttachDto = new ProfileAttachDto(attachNo, memNo);
			List<AttachDto> attachments = memDao.findProfile(memNo);
			attachmentService.attachmentsDelete(attachments);
			memDao.deleteProfile(memNo);
			memDao.profileImage(profileAttachDto);
		}
		
		if(memDao.editProfile(inputDto)) {
			//닉네임 수정 후 세션에서 지우고 재설정
			session.removeAttribute(SessionConstant.NICK);
			session.setAttribute(SessionConstant.NICK, inputDto.getMemNick());
			return "redirect:/home";
		}
		else {
			return "redirect:edit_profile?error";
		}
	}
	
//	@PostMapping("/edit_profile")
//	public String editProfile(HttpSession session,
//								@ModelAttribute MemDto inputDto,
//								@RequestParam int attachNo ) {
//		int memNo = (int) session.getAttribute(SessionConstant.NO);
//		inputDto.setMemNo(memNo);
//		ProfileAttachDto profileAttachDto = new ProfileAttachDto(attachNo, memNo);
//
//		if(memDao.editProfile(inputDto)) {
//			List<AttachDto> attachments = memDao.findProfile(memNo);
//			attachmentService.attachmentsDelete(attachments);
//			memDao.deleteProfile(memNo);
//			memDao.profileImage(profileAttachDto);
//			return "redirect:/home";//마이 프로필 이동으로 수정하기
//		}
//		else {
//			return "redirect:edit_profile?error";
//		}
//		
//	}
	
	@GetMapping("/leave")
	public String memLeave() {
		return "mem/leave";
	}
	
	@PostMapping("/leave")
	public String memLeave(HttpSession session) {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		MemDto loginDto = memDao.selectOne(memNo);
			memDao.deleteMem(memNo);
			return "redirect:goodbye";
	}
	
	@GetMapping("/goodbye")
	public String goodbye() {
		return "mem/goodbye";
	}
	
	@GetMapping("/inquiry")
	public String inquiry() {
		return "mem/inquiry";
	}
	
	@PostMapping("/inquiry")
	public String inquiry(HttpSession session, @RequestParam String text) throws FileNotFoundException, MessagingException, IOException {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		MemDto memDto = memDao.selectOne(memNo);
		emailService.inquiryMail(memDto.getMemEmail(), text);
		return "mem/inquiry-finish";
	}
	

}
