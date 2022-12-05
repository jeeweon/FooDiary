package com.appfoodiary.foodiary.email;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.appfoodiary.foodiary.component.RandomGenerator;
import com.appfoodiary.foodiary.entity.SelfCheckDto;
import com.appfoodiary.foodiary.repository.SelfCheckDao;
@SpringBootTest
public class EmailTest04 {
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Autowired
	private RandomGenerator randomGenerator;
	
	@Autowired
	private SelfCheckDao selfCheckDao;
	
	@Test
	public void test() throws MessagingException, FileNotFoundException, IOException {
		//1.메세지 생성
		MimeMessage message = javaMailSender.createMimeMessage();
		
		//2.헬퍼 생성
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
	
		//3.정보 설정
		String email = "oooo8912@naver.com";
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
		
		String serial = randomGenerator.generateSerial(6);
		
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

}
