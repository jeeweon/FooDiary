package com.appfoodiary.foodiary.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.repository.ReviewDao;
@Component
public class ReviewOwnerCheckInterceptor implements HandlerInterceptor{

	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		String referer = request.getHeader("Referer");
		ReviewDto reviewDto = reviewDao.find(reviewNo);
		
		if(memNo==reviewDto.getMemNo()) {
			if(referer !=null && referer.contains("/review/detail"));	
			return true;
		}
		response.sendError(403);
		return false;
	}
	
	
}
