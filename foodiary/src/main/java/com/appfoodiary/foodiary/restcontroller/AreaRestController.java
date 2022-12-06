package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.entity.AreaDto;
import com.appfoodiary.foodiary.entity.InterestAreaDto;
import com.appfoodiary.foodiary.repository.AreaDao;
import com.appfoodiary.foodiary.vo.InterestAreaVO;

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
	public void insert(@RequestBody InterestAreaDto dto, 
			HttpSession session) {
		//dto.setMemNo((Integer)session.getAttribute("loginNo")); //회원가입 기능구현 완료 시 이 구문 사용
		dto.setMemNo(2);
		areaDao.addInterest(dto);
	}
	
	@GetMapping("/area/interest")
	public List<InterestAreaVO> myAreas(HttpSession session) {
		//int memNo = ((Integer)session.getAttribute("loginNo")); //회원가입 기능구현 완료 시 이 구문 사용
		return areaDao.myAreas(2);
	}
	
	@DeleteMapping("/area/interest")
	public void delete(@RequestBody InterestAreaDto dto,
			HttpSession session) {
		//dto.setMemNo((Integer)session.getAttribute("loginNo")); //회원가입 기능구현 완료 시 이 구문 사용
		dto.setMemNo(2);
		areaDao.deleteInterest(dto);
	}
	
	
	 
}
