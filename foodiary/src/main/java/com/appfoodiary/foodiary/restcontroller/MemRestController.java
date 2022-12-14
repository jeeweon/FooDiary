package com.appfoodiary.foodiary.restcontroller;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.entity.SelfCheckDto;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.service.EmailService;

@RestController
@RequestMapping("/rest/mem")
public class MemRestController {
	
	@Autowired
	private MemDao memDao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@RequestMapping("/email")
	public String email(@RequestParam String memEmail) {
		MemDto memDto = memDao.findByEmail(memEmail);
		if(memDto==null) {
			return "NNNNY"; //사용 가능
		}
		else {
			return "NNNNN"; //사용 불가
		}
	}
	
	@RequestMapping("/nick")
	public String nick(@RequestParam String memNick) {
		MemDto memDto = memDao.findByNick(memNick);
		if(memDto==null) {
			return "NNNNY"; //사용 가능
		}
		else {
			return "NNNNN"; //사용 불가
		}
	}
	
	@PostMapping("/email_check1")
	public void emailCheck2(@RequestParam String who) throws FileNotFoundException, MessagingException, IOException {
		emailService.sendSelfCheckMail(who);
	}
	
	@PostMapping("/email_check2")
	public boolean emailCheck3(@ModelAttribute SelfCheckDto selfCheckDto) {
		return emailService.checkSerial(selfCheckDto);
	}
	
	@PostMapping("/profile_delete")
	public void profileDelete(@RequestParam int memNo) {
		memDao.deleteProfile(memNo);
	}
	
	@PostMapping("/leave_pw")
	public boolean leavePw(HttpSession session, 
							@RequestParam String memPw) {
			int memNo = (int) session.getAttribute(SessionConstant.NO);
			MemDto loginDto = memDao.selectOne(memNo);
			return encoder.matches(memPw,loginDto.getMemPw());
	}
}
