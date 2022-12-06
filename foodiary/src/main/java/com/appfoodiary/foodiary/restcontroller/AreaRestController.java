package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.entity.AreaDto;
import com.appfoodiary.foodiary.entity.InterestAreaDto;
import com.appfoodiary.foodiary.repository.AreaDao;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest")
public class AreaRestController {
	@Autowired
	private AreaDao areaDao;
	
	@GetMapping("/area")
	public List<AreaDto> list(){
		return areaDao.selectList();
	}
	
	@PostMapping("/area/interest")
	public void insert(@RequestBody InterestAreaDto dto) {
		areaDao.addInterest(dto);
	} 
}
