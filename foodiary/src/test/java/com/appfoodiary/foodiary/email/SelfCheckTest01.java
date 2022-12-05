package com.appfoodiary.foodiary.email;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.appfoodiary.foodiary.entity.SelfCheckDto;
import com.appfoodiary.foodiary.repository.SelfCheckDao;

@SpringBootTest
public class SelfCheckTest01 {
	
	@Autowired
	SelfCheckDao selfCheckDao;
	
	String email = "oooo8912@naver.com";
	String serial = "680336";
	
	@Test
	public void test() {
		SelfCheckDto selfCheckDto = SelfCheckDto.builder()
				.who(email)
				.serial(serial)
				.build();
		
		boolean result = selfCheckDao.check(selfCheckDto);
		
		if(result) {
//			System.out.println("인증 성공");
			selfCheckDao.delete(email);
		}
		else {
//			System.out.println("인증 실패");
		}
	}
	

}
