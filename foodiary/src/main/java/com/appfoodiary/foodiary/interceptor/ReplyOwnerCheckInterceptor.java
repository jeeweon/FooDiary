package com.appfoodiary.foodiary.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.appfoodiary.foodiary.constant.SessionConstant;
import com.appfoodiary.foodiary.entity.ReplyDto;
import com.appfoodiary.foodiary.entity.ReviewDto;
import com.appfoodiary.foodiary.repository.ReplyDao;
@Component
public class ReplyOwnerCheckInterceptor implements HandlerInterceptor{

	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		int memNo = (int) session.getAttribute(SessionConstant.NO);
		int replyNo = Integer.parseInt(request.getParameter("replyNo"));
		String referer = request.getHeader("Referer");
		ReplyDto replyDto = replyDao.find(replyNo);
		
		if(memNo==replyDto.getMemNo()) {
			if(referer !=null && referer.contains("/rest/reply"));	
			return true;
		}
		response.sendError(403);
		return false;
	}
	
	
}
