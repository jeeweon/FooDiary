package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.appfoodiary.foodiary.vo.CntInterestAreaVO;
import com.appfoodiary.foodiary.vo.InterestAreaVO;

import lombok.extern.slf4j.Slf4j;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@Slf4j
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
		int memNo = (Integer)session.getAttribute("loginNo");
		dto.setMemNo(memNo);
		CntInterestAreaVO cntVO = areaDao.selectCnt(memNo);
		int myAreaCnt = cntVO.getCount();
		if(myAreaCnt < 3) {			
			areaDao.addInterest(dto);
		} else {
			log.debug("관심지역 설정 개수 제한 초과(최대 3개)");
		}
	}
	
	@GetMapping("/area/interest")
	public List<InterestAreaVO> myAreas(HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		return areaDao.myAreas(memNo);
	}
	
	@DeleteMapping("/area/interest")
	public void delete(@RequestBody InterestAreaDto dto,
			HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo"); //회원가입 기능구현 완료 시 이 구문 사용
		dto.setMemNo(memNo);
		areaDao.deleteInterest(dto);
	}
}
