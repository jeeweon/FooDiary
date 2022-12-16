package com.appfoodiary.foodiary.restcontroller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.appfoodiary.foodiary.repository.ReviewDao;
import com.appfoodiary.foodiary.service.AttachmentService;

@CrossOrigin(origins = "http://127.0.0.1:5500/")
@RestController	//화면반환x (@Controller+@ReponseBody)
@RequestMapping("/attach")
public class AttachRestController {

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
	
	// 프로필 이미지 업로드
//	@PostMapping("/upload")
//	public String upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
//		//파일 첨부
//		int attachNo = attachmentService.attachUp(attach);
//		return ServletUriComponentsBuilder.fromCurrentContextPath()
//				.path("/attach/download/").path(String.valueOf(attachNo))
//				.toUriString();
//	}
	
	
	
}
