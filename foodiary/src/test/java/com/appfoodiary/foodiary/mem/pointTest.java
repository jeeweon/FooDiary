package com.appfoodiary.foodiary.mem;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.appfoodiary.foodiary.entity.LevelPointDto;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.repository.MemDao;

@SpringBootTest
public class pointTest {

	@Autowired
	private MemDao memDao;
	
	@Test
	public void test() {
		int memNo = 4;
		MemDto memDto = memDao.selectOne(memNo);
		int originPoint = memDto.getMemPoint();
		
		List<LevelPointDto> levelPointDto = memDao.getPoint();
//		int reviewPoint = levelPointDto.get(0).getReviewPoint();
		int likePoint = levelPointDto.get(0).getLikePoint();
				
		int levelPoint = originPoint+likePoint;
		
		memDto.setMemPoint(levelPoint);
		
//		boolean judge = memDao.(memDto);
		
//		if(judge) {
//			System.out.println("포인트 성공");
//		}
//		else {
//			System.out.println("포인트 실패");
//		}
	}
}
