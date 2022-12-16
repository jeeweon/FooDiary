package com.appfoodiary.foodiary.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemSearchVO {
	private int memNo;
	private String memEmail;
	private String memPw;
	private String memNick;
	private String memIntro;
	private Date memBirth;
	private String memLevel;
	private int memPoint;
	private Date memJoinDate;
	private Date memLoginDate;
	private int attachNo; //프로필 이미지 첨부파일 번호
	private String keyword; //검색어
	private int memReviewCnt; //작성한 리뷰 개수
	private boolean followCheck; //회원 팔로우 여부
}
