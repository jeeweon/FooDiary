package com.appfoodiary.foodiary.mem;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.appfoodiary.foodiary.repository.AdminEmailDao;

@SpringBootTest
public class emailDeleteTest {

	@Autowired
	private AdminEmailDao adminEmailDao;
	
	@Test
	public void test() {
		adminEmailDao.delete(52);
		
	}
}
