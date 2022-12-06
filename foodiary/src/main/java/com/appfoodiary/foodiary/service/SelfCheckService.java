package com.appfoodiary.foodiary.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.appfoodiary.foodiary.component.RandomGenerator;
import com.appfoodiary.foodiary.entity.SelfCheckDto;
import com.appfoodiary.foodiary.repository.SelfCheckDao;

@Service
public class SelfCheckService implements EmailService{

	@Autowired
	private RandomGenerator randomGenerator;
	
	@Autowired
	private SelfCheckDao selfCheckDao;
	
	@Autowired
	private JavaMailSender javaMailSender; 
	
	
	@Override
	public void sendSelfCheckMail(String email) throws MessagingException, FileNotFoundException, IOException {
		//(1)인증번호 생성 (2)메일 전송 (3)데이터베이스 등록
		
		String serial = randomGenerator.generateSerial(6);
		
		//1.메세지 생성
		MimeMessage message = javaMailSender.createMimeMessage();
				
		//2.헬퍼 생성
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
			
		//3.정보 설정
		helper.setTo(email);
		helper.setSubject("[FooDiary] 본인확인 인증 메일입니다");
				
		ClassPathResource resource = new ClassPathResource("email/self-check.html");
		StringBuffer buffer = new StringBuffer();
				
		try(Scanner sc = new Scanner(resource.getFile())){
			while(sc.hasNextLine()) {
				buffer.append(sc.nextLine());
			}
		}
				
		String text = buffer.toString();
		Document doc = Jsoup.parse(text);
		Element element = doc.getElementById("serial");
		element.text(serial);
				
		helper.setText(doc.toString(),true);
		javaMailSender.send(message);
				
		selfCheckDao.delete(email);
		SelfCheckDto selfCheckDto = SelfCheckDto.builder()
											.who(email)
											.serial(serial)
										.build();
				
		selfCheckDao.insert(selfCheckDto);
		
	}
	
	@Override
	public boolean checkSerial(SelfCheckDto selfCheckDto) {
		if(selfCheckDao.check(selfCheckDto)) {
			selfCheckDao.delete(selfCheckDto.getWho());
			return true;
		}
		else {
			return false;			
		}
	}
	
}
