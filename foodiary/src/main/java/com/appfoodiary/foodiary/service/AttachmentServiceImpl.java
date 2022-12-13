package com.appfoodiary.foodiary.service;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.appfoodiary.foodiary.entity.AttachDto;
import com.appfoodiary.foodiary.repository.AttachDao;

@Service
public class AttachmentServiceImpl implements AttachmentService{
	//private final File dir = new File("D:\\upload\\kh10g");	//파일 경로
	private final File dir = new File(System.getProperty("user.home") + "/upload"); //OS 무관 파일 경로(배포 시, 삭제 예정)
	//private final File dir = new File("/Users/naeljung/fproject"); //파일 경로(나엘 / 배포 시, 삭제 예정)
	

	@Autowired
	private AttachDao attachDao;
	
	//업로드
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
	
	//1개 업로드
	@Override
	public int attachUp(MultipartFile attach) throws IllegalStateException, IOException {
		//DB 등록 (DB: attach테이블)
		int attachNo = attachDao.newAttachNo();
		attachDao.insert(
				AttachDto.builder()
					.attachNo(attachNo)
					.attachName(attach.getOriginalFilename())
					.attachType(attach.getContentType())
					.attachSize(attach.getSize())
					.build());
		
		//target에 파일저장
		File target = new File(dir, String.valueOf(attachNo)); //파일이름 지정
		attach.transferTo(target);	//저장!
		
		return attachNo;
	}

	//다운로드(미리보기)
	@Override
	public ResponseEntity<ByteArrayResource> attachmentsDownloadList(int attachNo) throws IOException {
		//파일탐색(DB)
		AttachDto attachDto = attachDao.selectOne(attachNo);
		if(attachDto == null) {
			return null;
		}
		
		//파일 가져오기
		File target = new File(dir, String.valueOf(attachNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//응답객체 만들어서 데이터 전송
		return ResponseEntity.ok()
//						.header("Content-Encoding", "UTF-8")
				.header(HttpHeaders.CONTENT_ENCODING, 
						StandardCharsets.UTF_8.name())
//						.header("Content-Length", String.valueOf(data.length))
				.contentLength(attachDto.getAttachSize())
//						.contentType(MediaType.APPLICATION_OCTET_STREAM)			//다운로드해라
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())	//열든지 다운로드하든지 맘대로
//						.header("Content-Disposition", "attachment;filename=" + String.valueOf(imageNo))
				.header(HttpHeaders.CONTENT_DISPOSITION, 
						ContentDisposition.attachment()
								.filename(
										attachDto.getAttachName(), 
										StandardCharsets.UTF_8)
								.build().toString())
				.body(resource);
	}
	
	//삭제
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
