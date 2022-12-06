package com.appfoodiary.foodiary.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.repository.AttachDao;

@Service
public class AttachmentServiceImpl implements AttachmentService{

	private final File dir = new File("D:\\upload\\kh10g");	 //파일경로
	
	@Autowired
	private AttachDao attachDao;
	
	@Override
	public int attachmentsUp(List<MultipartFile> attachments, MultipartFile file) 
														throws IllegalStateException, IOException {
		//DB 등록 (DB: attach테이블)
		int attachNo = attachDao.newAttachNo();
		attachDao.insert(
				AttachDto.builder()
					.attachNo(attachNo)
					.attachName(file.getOriginalFilename())
					.attachType(file.getContentType())
					.attachSize(file.getSize())
					.build());
		
		//target에 파일저장
		File target = new File(dir, String.valueOf(attachNo)); //파일이름 지정
		file.transferTo(target);	//저장!
		
		return attachNo;
	}

	@Override
	public void attachmentsDelete(List<AttachDto> attachments) {
		for(AttachDto attachDto : attachments) {
			//DB 삭제 (DB: attach테이블)
			attachDao.delete(attachDto.getAttachNo());
			
			//target에 저장된 실제파일 삭제
			String attachNo = String.valueOf(attachDto.getAttachNo());
			File target = new File(dir, attachNo);
			target.delete();
		}
	}

}
