package com.appfoodiary.foodiary.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.appfoodiary.foodiary.entity.AttachDto;

public interface AttachmentService {
	//업로드
	public int attachmentsUp(List<MultipartFile> attachments, MultipartFile file) 
														throws IllegalStateException, IOException;
	//다운로드(미리보기)
	public ResponseEntity<ByteArrayResource> attachmentsDownloadList(int attachNo) 
																										throws IOException;
	//삭제
	public void attachmentsDelete(List<AttachDto> attachments);

	//파일 1개 업로드
	public int attachUp(MultipartFile attach) throws IllegalStateException, IOException;
}
