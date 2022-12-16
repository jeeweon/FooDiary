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
	public void reviewPoint(int memNo) {
		
		MemDto memDto = memDao.selectOne(memNo);
		int originPoint = memDto.getMemPoint();
		
		int reviewPoint = levelPoint.reviewPoint();
		int updatePoint = originPoint + reviewPoint;
		memDto.setMemPoint(updatePoint);
		memDao.updatePoint(memDto);
	}
	
	@Override
	public void likePoint(int memNo) {
		MemDto memDto = memDao.selectOne(memNo);
		int originPoint = memDto.getMemPoint();
		
		int likePoint = levelPoint.likePoint();
		int updatePoint = originPoint + likePoint;
		memDto.setMemPoint(updatePoint);
		memDao.updatePoint(memDto);
	}
	
	@Override
	public void levelUp(int memNo) {
		MemDto memDto = memDao.selectOne(memNo);
		int memPoint = memDto.getMemPoint();
		
		if(memPoint>=1000) {
			memDto.setMemLevel("6");
		}
		else if(memPoint>=300) {
			memDto.setMemLevel("5");
		}
		else if(memPoint>=100) {
			memDto.setMemLevel("4");
		}
		else if(memPoint>=50) {
			memDto.setMemLevel("3");
		}
		else {
			memDto.setMemLevel("2");
		}
		memDao.levelUp(memDto);
	}
}
