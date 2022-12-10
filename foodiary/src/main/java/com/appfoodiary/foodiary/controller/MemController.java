package com.appfoodiary.foodiary.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.repository.MemDao;

@Controller
@RequestMapping("/mem")
public class MemController {
	
	@Autowired
	private MemDao memDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
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
		return "redirect:/home";
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
		attr.addAttribute("memEmail",memEmail);
		return "redirect:reset_pw";
	}
	
	//3. 비밀번호 재설정
	@GetMapping("/reset_pw")
	public String resetPw(@RequestParam String memEmail,Model model) {
		MemDto memDto = memDao.findByEmail(memEmail);
		model.addAttribute("memDto",memDto);
		return "mem/reset-pw";
	}
	
	@PostMapping("/reset_pw")
	public String resetPw(@ModelAttribute MemDto memDto) {
		
		boolean result = memDao.resetPw(memDto);
		
		if(result) {			
			return "redirect:login";
		}
		else {
			return "redirect:reset_pw?error";
		}
	}
	
	@GetMapping("/check_pw")
	public String checkPw() {
		return "mem/check-pw";
	}
	
	@PostMapping("/check_pw")
	public String checkPw(HttpSession session,
						@RequestParam String beforePw) {
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		MemDto loginDto = memDao.selectOne(memNo);
		boolean judge = encoder.matches(beforePw, loginDto.getMemPw());
		
		if(judge) {
			return "mem/edit-pw";
		}
		else {
			return "redirect:check_pw?error"; 
		}
	}

	@GetMapping("/edit_pw")
	public String editPw() {
		return "";
	}
	@PostMapping("/edit_pw")
	public String editPw(HttpSession session,
							@RequestParam String memPw) {
		
		int memNo = (int) session.getAttribute(SessionConstant.NO);
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
	

}
