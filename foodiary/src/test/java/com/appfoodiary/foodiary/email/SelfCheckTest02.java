package com.appfoodiary.foodiary.email;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.appfoodiary.foodiary.entity.SelfCheckDto;
import com.appfoodiary.foodiary.repository.SelfCheckDao;

@SpringBootTest
public class SelfCheckTest02 {
	
	@Autowired
	SelfCheckDao selfCheckDao;
	
	String email = "oooo8912@naver.com";
	String serial = "983213";
	
	@Test
	public void test() {
		SelfCheckDto selfCheckDto = SelfCheckDto.builder()
				.who(email)
				.serial(serial)
				.build();
		
		boolean result = selfCheckDao.check(selfCheckDto);
		
		if(result) {
			selfCheckDao.delete(email);
		}
		else {
		}
	}
	

}
