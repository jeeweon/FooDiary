package com.appfoodiary.foodiary.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.appfoodiary.foodiary.entity.AttachDto;

public interface AttachmentService {
	public int attachmentsUp(List<MultipartFile> attachments, MultipartFile file) 
														throws IllegalStateException, IOException;
	public void attachmentsDelete(List<AttachDto> attachments);
}
