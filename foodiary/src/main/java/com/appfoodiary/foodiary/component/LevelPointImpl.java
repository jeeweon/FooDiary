package com.appfoodiary.foodiary.component;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.appfoodiary.foodiary.entity.LevelPointDto;
import com.appfoodiary.foodiary.repository.MemDao;

@Component
public class LevelPointImpl implements LevelPoint{

	@Autowired
	private MemDao memDao;
	
	@Override
	public int reviewPoint() {
		List<LevelPointDto> levelPointDto = memDao.getPoint();
		int reviewPoint = levelPointDto.get(0).getReviewPoint();
		return reviewPoint;
	}
	
	@Override
	public int likePoint() {
		List<LevelPointDto> levelPointDto = memDao.getPoint();
		int likePoint = levelPointDto.get(0).getLikePoint();
		return likePoint;
	}
	
}
