package com.appfoodiary.foodiary.email;

import java.util.Properties;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@SpringBootTest
public class EmailTest02 {
	
	@Autowired
	private JavaMailSender sender;
	
	@Test
	public void test() {
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo("oooo8912@naver.com");
		message.setSubject("테스트 이메일2");
		message.setText("테스트중2");
		
		sender.send(message);
		
	}

}
