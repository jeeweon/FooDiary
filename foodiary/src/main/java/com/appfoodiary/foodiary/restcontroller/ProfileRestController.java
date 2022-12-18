package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.entity.FollowCertDto;
import com.appfoodiary.foodiary.repository.FollowDao;
import com.appfoodiary.foodiary.repository.MyprofileDao;
import com.appfoodiary.foodiary.vo.FollowMemVO;
import com.appfoodiary.foodiary.vo.MemRekVO;
import com.appfoodiary.foodiary.vo.ProfileMemVO;
import com.appfoodiary.foodiary.vo.ReviewListVO;

@CrossOrigin
@RestController
@RequestMapping("/rest")
public class ProfileRestController {

	@Autowired
	private MyprofileDao myprofileDao; 
	@Autowired
	private FollowDao followDao;
	
	@GetMapping("/profile/mem")
	public ProfileMemVO profilemem(
			HttpSession session) 
	{
		int memNo = (Integer)session.getAttribute("loginNo");
		return myprofileDao.profileMemVO(memNo);
	}
	@GetMapping("profile/reviewlist")
	public List<ReviewListVO> reviewList(
			HttpSession session
			){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.reivewListVO(memNo);
	}
	
	@GetMapping("profile/bookmarklist")
	public List<ReviewListVO> bookmarkList(
			HttpSession session
			){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.bookmarkListVO(memNo);
	}
	@GetMapping("profile/likelist")
	public List<ReviewListVO> likeList(
			HttpSession session
			){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.likeListVO(memNo);
	}
	@GetMapping("profile/memrek")
	public List<MemRekVO> memRekList(
			HttpSession session){
		int memNo=(Integer)session.getAttribute("loginNo");
		return myprofileDao.MemRekVO(memNo);
	}
	
	@GetMapping("/profile/yourprofile")
	public ProfileMemVO yourprofile(
			@RequestParam int memNo,
			HttpSession session) 
	{
		return myprofileDao.profileMemVO(memNo);
	}
	@GetMapping("profile/yourreviewlist")
	public List<ReviewListVO> yourreviewList(
			@RequestParam int memNo,
			HttpSession session
			){
		return myprofileDao.reivewListVO(memNo);
	}
	
	//팔로우 followCert
	@GetMapping("profile/followcert")
	public boolean followCert(
			HttpSession session,
			@RequestParam int memNo
			) {
		int activeMemNo=(Integer)session.getAttribute("loginNo");
		
			FollowCertDto dto=FollowCertDto.builder()
				.activeMemNo(activeMemNo)
				.passiveMemNo(memNo)
				.build();
			if(followDao.followCert(dto) != null) {
				return true;
			}else {
				return false;
			}
			 
	}
	//팔로우수 
	@PostMapping("profile/followcnt")
	public int followcnt(
			@RequestParam int passiveMemNo) {
		return followDao.follower(passiveMemNo);
	}
	
	//myprofile 팔로우 멤버
	@GetMapping("/profile/followmem")
	public List<FollowMemVO> followmem(
			HttpSession session){
		
		int memNo=(Integer)session.getAttribute("loginNo");
		return followDao.followMem(memNo);
	}
	//myprofile 팔로워 멤버
	@GetMapping("/profile/followermem")
	public List<FollowMemVO> followermem(
			HttpSession session){
		
		int memNo=(Integer)session.getAttribute("loginNo");
		return followDao.followerMem(memNo);
	}
	//yourprofile 팔로우 멤버
	@GetMapping("/profile/yourfollowmem")
	public List<FollowMemVO> yourfollowmem(
			HttpSession session,
			@RequestParam int memNo){
		return followDao.followMem(memNo);
	}
	//yourprofile 팔로워 멤버
	@GetMapping("/profile/yourfollowermem")
	public List<FollowMemVO> yourfollowermem(
			HttpSession session,
			@RequestParam int memNo){
		return followDao.followerMem(memNo);
	}
}
