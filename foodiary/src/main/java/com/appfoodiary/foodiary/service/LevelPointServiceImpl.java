package com.appfoodiary.foodiary.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.appfoodiary.foodiary.component.LevelPoint;
import com.appfoodiary.foodiary.entity.MemDto;
import com.appfoodiary.foodiary.repository.MemDao;

@Service
public class LevelPointServiceImpl implements LevelPointService{

	@Autowired
	private MemDao memDao;
	
	@Autowired
	private LevelPoint levelPoint;
	
	@Override
	public void ReviewPoint(int memNo) {
		
		MemDto memDto = memDao.selectOne(memNo);
		int originPoint = memDto.getMemPoint();
		
		int reviewPoint = levelPoint.reviewPoint();
		int updatePoint = originPoint + reviewPoint;
		memDto.setMemPoint(updatePoint);
		memDao.updatePoint(memDto);
	}
	
	@Override
	public void LikePoint(int memNo) {
		MemDto memDto = memDao.selectOne(memNo);
		int originPoint = memDto.getMemPoint();
		
		int likePoint = levelPoint.likePoint();
		int updatePoint = originPoint + likePoint;
		memDto.setMemPoint(updatePoint);
		memDao.updatePoint(memDto);
		
	}
}
