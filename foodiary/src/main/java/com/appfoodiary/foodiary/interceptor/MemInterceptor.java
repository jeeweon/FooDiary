package com.appfoodiary.foodiary.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.servlet.HandlerInterceptor;

import com.appfoodiary.foodiary.constant.SessionConstant;
@Component
public class MemInterceptor implements HandlerInterceptor{

@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
	
		HttpSession session = request.getSession();
		String memNick = (String)session.getAttribute(SessionConstant.NICK);
		if(memNick==null) {
			response.sendRedirect("/mem/login");
			return false;
		}
		else {
			return true;
		}
	}
}
