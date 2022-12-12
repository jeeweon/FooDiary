package com.appfoodiary.foodiary.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.BookmarkDto;
import com.appfoodiary.foodiary.entity.FollowDto;
import com.appfoodiary.foodiary.entity.LikeDto;
import com.appfoodiary.foodiary.repository.BookmarkDao;
import com.appfoodiary.foodiary.repository.FollowDao;
import com.appfoodiary.foodiary.repository.LikeDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/review")
public class LikeRestController {
	
	@Autowired
	private LikeDao likeDao;
	@Autowired
	private BookmarkDao bookmarkDao;
	@Autowired
	private FollowDao followDao;
	
	
	//좋아요 비동기 통신처리 백인드 
	@PostMapping("/like")
	public int like(
			@RequestParam int reviewNo,
			Model model,
			HttpSession session
			) {
		//우선 값을 넣어놓고 확인하겠다.
		//목표
		//(1): 프론트로부터 데이터를 받는다.
		//(2): 받은 데이터 값을 dto에 담에서 cert에 넣는다. 
		//(3)cert값이 있으면 지우고 없으면 넣는다.
		
		session.removeAttribute(SessionConstant.NO);
		session.setAttribute(SessionConstant.NO, 14);
		int memNo=(int)session.getAttribute(SessionConstant.NO);
		LikeDto dto =LikeDto.builder()
					.reviewNo(reviewNo)
					.memNo(memNo)
					.build();
		
		if(likeDao.cert(dto)) {
			//값이 존재 데이터를 삭제
			likeDao.delete(dto);
			//리뷰갯수 하나 지운다.
			likeDao.minus(reviewNo);
			
		}else {
			//값이 없음 데이터를 삽입
			likeDao.insert(dto);
			//리뷰갯수증가
			likeDao.plus(reviewNo);
		}
		return likeDao.count2(reviewNo);
	}
	
	
	//북마크 비동기통신 처리 앤드
	@PostMapping("/bookmark")
	public boolean bookmark(
			@RequestParam int reviewNo,
			HttpSession session
			
			)
		{
		session.removeAttribute(SessionConstant.NO);
		session.setAttribute(SessionConstant.NO, 14);
		int memNo=(int)session.getAttribute(SessionConstant.NO);
		//dto에 값을 넣는다.
		BookmarkDto dto=BookmarkDto.builder()
					.reviewNo(reviewNo)
					.memNo(memNo)
					.build();
		if(bookmarkDao.cert(dto)) {
			//데이터 값이 있으면 지워라
			bookmarkDao.delete(dto);
			return false;
		}else {
			//데이터값이 없으면 추가해라
			bookmarkDao.insert(dto);
			return true;
		}
		
	}
	
	// follow 비동기 통신 
	@PostMapping("/follow")
	public boolean follow(
			@RequestParam int activeMemNo,
			@RequestParam int passiveMemNo
			) {
		//(1)들어온 데이터값을 있는지 없는지 확인
		//(2)없다면 추가 있다면 삭제
		//(3)true false 출력 
		FollowDto dto =FollowDto.builder()
								.activeMemNo(activeMemNo)
								.passiveMemNo(passiveMemNo)
								.build();
		//데이터가 있는지 없는지 판정 
		boolean cert=followDao.cert(dto);
		
		if(cert) {
			//데이터값이 있으니까 삭제한다.
			followDao.delete(dto);
			return false;
		}else {
			//데이터값이 없으니까 삽입한다.
			followDao.insert(dto);
			return true;
		}
	}
}
