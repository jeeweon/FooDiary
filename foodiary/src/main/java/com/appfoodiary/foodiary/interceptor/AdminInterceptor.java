package com.appfoodiary.foodiary.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.appfoodiary.foodiary.constant.SessionConstant;

@Component
public class AdminInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
			
			HttpSession session = request.getSession();
			String loginId = (String) session.getAttribute(SessionConstant.ID);
			// 미리 부여된 adminID와 현재 로그인된 세션의 아이디가 같은지 판정
			boolean admin = loginId.equals("admin1");
			if(admin) {
				return true;
			} 
			response.sendError(403); // 관리자가 아닐시 403error 출력
			return false;
	}
}