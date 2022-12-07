package com.appfoodiary.foodiary.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.service.AttachmentService;

@RestController	//화면반환x (@Controller+@ReponseBody)
@RequestMapping("/attach")
public class AttachController {

	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private ReviewDao reviewDao;
	
	//첨부파일 번호 -> 전체파일 -> 다운로드(미리보기)
	@GetMapping("/download/{attachNo}")
	public ResponseEntity<ByteArrayResource> download(
			@PathVariable int attachNo) throws IOException {
		return attachmentService.attachmentsDownloadList(attachNo);
	}
	
	//리뷰 번호 -> 대표파일 조회 -> 다운로드(미리보기)
	@GetMapping("/downloadReviewAttach/{reviewNo}")
	public ResponseEntity<ByteArrayResource> downloadReviewAttach(
			@PathVariable int reviewNo) throws IOException {
		//리뷰 대표파일 조회
		int attachNo = reviewDao.findReviewAttachView(reviewNo).getAttachNo();

		return attachmentService.attachmentsDownloadList(attachNo);
	}
}
