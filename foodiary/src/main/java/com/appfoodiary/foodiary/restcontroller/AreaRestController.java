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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@Tag(name = "area rest controller", description = "관심지역")
@RequestMapping("/rest/area")
public class AreaRestController {
	@Autowired
	private AreaDao areaDao;
	
	@GetMapping("")
	@Operation(summary = "전체 지역 목록")
	public List<AreaDto> list(){
		return areaDao.selectList();
	}
	
	
	@PostMapping("/interest")
	@Operation(summary = "관심지역 등록")
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
				log.debug("이미 추가된 관심지역"); //로그파일 확인용으로 남김
			}
		} else {
			log.debug("관심지역 설정 개수 제한 초과(최대 3개)"); //로그파일 확인용으로 남김
		}
	}
	
	@GetMapping("/interest")
	@Operation(summary = "관심지역 목록")
	public List<InterestAreaVO> myAreas(HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		return areaDao.myAreas(memNo);
	}
	
	@DeleteMapping("/interest/{areaNo}")
	@Operation(summary = "관심지역 삭제")
	public void delete(@PathVariable int areaNo,
			HttpSession session) {
		int memNo = (Integer)session.getAttribute("loginNo");
		areaDao.deleteInterest(InterestAreaDto.builder()
				.memNo(memNo)
				.areaNo(areaNo)
				.build());
	}
	
	@PostMapping("/nearby")
	@Operation(summary = "특정 지역의 인근지역 목록")
	public List<NearbyAreaVO> nearbyAreas(@RequestBody(required=false) List<InterestAreaVO> areas) {
		return areaDao.nearbyAreas(areas);
	}
}
