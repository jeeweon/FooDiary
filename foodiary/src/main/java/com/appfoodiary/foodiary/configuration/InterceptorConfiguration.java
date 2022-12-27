package com.appfoodiary.foodiary.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.appfoodiary.foodiary.interceptor.AdminInterceptor;
import com.appfoodiary.foodiary.interceptor.MemInterceptor;
import com.appfoodiary.foodiary.interceptor.ReplyOwnerCheckInterceptor;
import com.appfoodiary.foodiary.interceptor.ReviewOwnerCheckInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {

	@Autowired
	private MemInterceptor memInterceptor;
	
	@Autowired
	private ReviewOwnerCheckInterceptor reviewOwnerCheckInterceptor;
	
	@Autowired
	private ReplyOwnerCheckInterceptor replyOwnerCheckInterceptor;
	
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(memInterceptor)
				.addPathPatterns(
						"/mem/**",
						"/review/write",//리뷰 쓰기
//						"/rest/review/report/*",//리뷰 신고
//						"/rest/review/like",
						"/area/interest"//관심지역 설정
						)
				
				.excludePathPatterns(
						"/mem/join*",//회원 가입
						"/mem/login",//로그인
						"/mem/email_check",//비번찾기 - 이메일 계정 확인
						"/mem/email_send*",//비번찾기 - 이메일 전송
						"/mem/reset_pw"//비번찾기 - 비번 재설정
//						"/rest/reply/{replyNo}"//댓글 조회		
						);
		registry.addInterceptor(reviewOwnerCheckInterceptor)//리뷰 작성자만 삭제,수정
				.addPathPatterns(
						"/review/delete",
						"/review/edit"
						);
		registry.addInterceptor(replyOwnerCheckInterceptor)//댓글 작성자만 삭제
				.addPathPatterns(
						"/rest/reply/"
						);
		// 관리자 구분
		registry.addInterceptor(adminInterceptor)
								.addPathPatterns(
										"/admin/*"
										)
								.excludePathPatterns(
										"/admin/login"
										);
	}
}
