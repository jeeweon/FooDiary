package com.appfoodiary.foodiary.service;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;

import com.appfoodiary.foodiary.entity.SelfCheckDto;

public interface EmailService {
	void sendSelfCheckMail(String email) throws MessagingException, FileNotFoundException, IOException;
	boolean checkSerial(SelfCheckDto selfCheckDto);
}
