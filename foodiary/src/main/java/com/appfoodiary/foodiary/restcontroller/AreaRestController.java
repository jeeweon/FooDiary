package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.entity.AreaDto;
import com.appfoodiary.foodiary.entity.InterestAreaDto;
import com.appfoodiary.foodiary.repository.AreaDao;
import com.appfoodiary.foodiary.vo.CntInterestAreaVO;
import com.appfoodiary.foodiary.vo.InterestAreaVO;
import com.appfoodiary.foodiary.vo.NearbyAreaVO;

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
			List<InterestAreaDto> list = areaDao.myAreasDto(memNo);
			if(!list.contains(dto)) {
				areaDao.addInterest(dto);	
			} else {
				log.debug("이미 추가된 관심지역");
			}
		} else {
			log.debug("관심지역 설정 개수 제한 초과(최대 3개)");
		}
	}
	
	@GetMapping("/area/interest")
	public List<InterestAreaVO> myAreas(HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		return areaDao.myAreas(memNo);
	}
	
	@DeleteMapping("/area/interest/{areaNo}")
	public void delete(@PathVariable int areaNo,
			HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		areaDao.deleteInterest(InterestAreaDto.builder()
				.memNo(memNo)
				.areaNo(areaNo)
				.build());
	}
	
	@PostMapping("/area/nearby")
	public List<NearbyAreaVO> nearbyAreas(@RequestBody(required=false) List<InterestAreaVO> areas) {
		return areaDao.nearbyAreas(areas);
	}
}
