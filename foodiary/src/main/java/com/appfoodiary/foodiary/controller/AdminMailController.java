package com.appfoodiary.foodiary.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.entity.NoticeEmailDto;
import com.appfoodiary.foodiary.repository.AdminEmailDao;
import com.appfoodiary.foodiary.repository.MemDao;
import com.appfoodiary.foodiary.service.EmailService;
import com.appfoodiary.foodiary.vo.MemEmailVO;

@Controller
@RequestMapping("/admin")
public class AdminMailController {

	@Autowired
	private AdminEmailDao adminEmailDao;
	@Autowired
	private EmailService emailService;
	@Autowired
	private MemDao memDao;
	
	@GetMapping("/send-mail")
	public String sendMail() {
		return "admin/send-mail";
	}
	
	@PostMapping("/send-mail")
	public String sendMail(@RequestParam String content,@RequestParam String subject) throws FileNotFoundException, MessagingException, IOException {
		
		int emailNo = adminEmailDao.emailSequence();
		adminEmailDao.insertMail(NoticeEmailDto.builder()
							.emailNo(emailNo)
							.emailSubject(subject)
							.emailContent(content)
				.build());
		List<MemEmailVO> memEmailVO = adminEmailDao.emailList();
		
		
		for(int i=0; i<memEmailVO.size(); i++) {
			MemEmailVO memEmails =memEmailVO.get(i);
			String memEmail = memEmails.getMemEmail();
			MemDto memDto = memDao.findByEmail(memEmail);
			String memNick = memDto.getMemNick();
//			emailService.noticeMail(memEmail, memNick, subject, content);
		} 
		return "admin/send-result";
	}
}
