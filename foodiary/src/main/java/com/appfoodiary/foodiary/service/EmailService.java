package com.appfoodiary.foodiary.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;

import com.appfoodiary.foodiary.entity.SelfCheckDto;
import com.appfoodiary.foodiary.vo.MemEmailVO;

public interface EmailService {
	//본인인증 메일
	void sendSelfCheckMail(String email) throws MessagingException, FileNotFoundException, IOException;
	
	//인증번호 확인
	boolean checkSerial(SelfCheckDto selfCheckDto);
	
	//문의 메일
//	void inquiryMail(String email,String text) throws MessagingException, FileNotFoundException, IOException;

	void inquiryMail(String memEmail, String text) throws MessagingException, FileNotFoundException, IOException; 
	
	void noticeMail(String memEmail,String memNick, String subject, String content) throws MessagingException, FileNotFoundException, IOException;
//	void noticeMail(String memEmail, String subject, String content) throws MessagingException, FileNotFoundException, IOException;


}
