package com.appfoodiary.foodiary.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.appfoodiary.foodiary.repository.SelfCheckDao;


@Service
public class SchedulerServiceImpl implements SchedulerService{

	@Autowired
	private SelfCheckDao selfCheckDao;
	
	@Scheduled(cron=" 0 0 * * * *")//정각마다
	@Override
	public void clearSelfCheck() {
		selfCheckDao.clear();
	}
	
	
}
