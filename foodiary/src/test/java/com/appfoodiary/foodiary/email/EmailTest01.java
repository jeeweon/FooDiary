package com.appfoodiary.foodiary.email;

import java.util.Properties;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@SpringBootTest
public class EmailTest01 {
	
	@Test
	public void test() {
		
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost("smtp.gmail.com");
		sender.setPort(587);
		sender.setUsername("minjeongemail");
		sender.setPassword("fgbupxoiomiedykr");
		
		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "ture");//인증 여부 설정(필수)
		props.setProperty("mail.smtp.debug", "true");//디버깅 사용 여부(선택)
		props.setProperty("mail.smtp.starttls.enable", "true");//TLS 사용 여부(필수) ->tls 방식 사용
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");//TLS 버전 설정(필수)
		props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");//신뢰할 수 있는 대상으로 추가(필수)
		
		sender.setJavaMailProperties(props);
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo("oooo8912@naver.com");
		message.setSubject("테스트 이메일");
		message.setText("테스트중");
		
		sender.send(message);
		
	}

}
