package com.appfoodiary.foodiary.mem;

import static org.assertj.core.api.Assertions.from;

import java.sql.Date;
import java.text.SimpleDateFormat;


import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.repository.MemDao;

@SpringBootTest
public class joinTest {

	@Autowired
	private MemDao memDao;
	@Test
	public void test() {
		
		String from = "2000-12-06";
		
		java.sql.Date to = java.sql.Date.valueOf(from);
		
		int memNo= memDao.sequence();
		
		MemDto memDto = MemDto.builder()
								.memNo(memNo)
								.memEmail("oooo89123@naver.com")
								.memPw("민정1")
								.memNick("민정닉")
								.memBirth(to)
							.build();
		memDao.join(memDto);
	}
}
