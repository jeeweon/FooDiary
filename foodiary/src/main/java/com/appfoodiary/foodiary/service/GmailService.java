package com.appfoodiary.foodiary.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
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
import com.appfoodiary.foodiary.vo.MemEmailVO;

@Service
public class GmailService implements EmailService{

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
		
		//(src 안에 있는 파일)ClassPath안에 있는 경로를 찾아주는 도구 / 다른 폴더 -> filepath로 찾아야 함
		ClassPathResource resource = new ClassPathResource("email/self-check.html");
//		helper.addInline("image", new ClassPathResource("static/images/Foodiary-logo.png"));		
		StringBuffer buffer = new StringBuffer();
		
		try(Scanner sc = new Scanner(resource.getFile())){
			while(sc.hasNextLine()) {//읽을 것이 있으면 추가
				buffer.append(sc.nextLine());
			}
		}
		
		// Jsoup 라이브러리르 이용해서 ID와 Address를 설정한 뒤 전송
		String text = buffer.toString();
		
		//문자열을 HTML로 인식하도록 해서 전송
		Document doc = Jsoup.parse(text);
		
		//serial 선택해서 시리얼 추가
		Element element = doc.getElementById("serial");
		element.text(serial);
		
		//true로 선택해야 html이 날라갈 수 있음
		helper.setText(doc.toString(),true);
		javaMailSender.send(message);
		
		//selfCheckDto email당 1개의 정보이므로 지우고 다시 보내기
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
	
	@Override
	public void inquiryMail(String memEmail, String text) throws MessagingException, FileNotFoundException, IOException {
		
		//1.메세지 생성
		MimeMessage message = javaMailSender.createMimeMessage();
		
		//2.헬퍼
		MimeMessageHelper helper = new MimeMessageHelper(message,false,"UTF-8");
		
		//3.정보 설정
		helper.setTo("minjeongemail@gmail.com");
		helper.setSubject("[Foodiary] 문의 메일");
		helper.setText("[문의 계정 이메일 : " + memEmail+"]\r\n"+ text);
		
		//전송
		javaMailSender.send(message);
	}
	
	@Override
	public void noticeMail(String memEmail,String memNick,String subject, String content) throws MessagingException, FileNotFoundException, IOException {
		
		//1.메세지 생성
		MimeMessage message = javaMailSender.createMimeMessage();
				
		//2.헬퍼 생성
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
			
		//3.정보 설정
		helper.setTo(memEmail);
		helper.setSubject("[FooDiary] "+subject);
		
		ClassPathResource resource = new ClassPathResource("email/notice.html");
		StringBuffer buffer = new StringBuffer();
		
		try(Scanner sc = new Scanner(resource.getFile())){
			while(sc.hasNextLine()) {//읽을 것이 있으면 추가
				buffer.append(sc.nextLine());
			}
		}
		// Jsoup 라이브러리르 이용해서 ID와 Address를 설정한 뒤 전송
		String text = buffer.toString();
		
		//문자열을 HTML로 인식하도록 해서 전송
		Document doc = Jsoup.parse(text);
		
		Element nick = doc.getElementById("memNick");
		nick.text(memNick);
		
		Element element = doc.getElementById("content");
		element.text(content);
		
		//true로 선택해야 html이 날라갈 수 있음
		helper.setText(doc.toString(),true);
		javaMailSender.send(message);
	}
}
