package com.appfoodiary.foodiary.websocket;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.appfoodiary.foodiary.entity.NotiDto;
import com.appfoodiary.foodiary.repository.NotiDao;
import com.appfoodiary.foodiary.vo.NotiVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NotiWebsocketServer extends TextWebSocketHandler{
	@Autowired
	private NotiDao notiDao;
	
	// 로그인 중인 개별유저
	//private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	// 클라이언트가 서버로 연결 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId,session);
	}
	
	// 연결 해제 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userSessionsMap.remove(currentUserName(session), session);
	}
	
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//변환 도구 생성
		ObjectMapper mapper = new ObjectMapper();

		NotiVO json = mapper.readValue(
				message.getPayload(), NotiVO.class);
		
		//바뀐 정보를 이용하여 신규 메세지 생성
		String payload = mapper.writeValueAsString(json);
		TextMessage jsonMessage = new TextMessage(payload);
		
		//알림 내역 DB 저장
		NotiDto dto = new NotiDto();
		dto.setCallerMemNo(json.getCallerMemNo());
		dto.setReceiverMemNo(json.getReceiverMemNo());
		dto.setNotiType(json.getNotiType());
		dto.setNotiContent(json.getNotiContent());
		dto.setNotiUrl(json.getNotiUrl());
		dto.setNotiCreateDate(json.getNotiCreateDate());
		notiDao.saveNoti(dto);
		
		//수신할 유저 세션 설정
		WebSocketSession receiverSession = userSessionsMap.get(json.getReceiverMemNick());
		
		//전송(알림 받을 유저 1명)
		receiverSession.sendMessage(jsonMessage);
	}
	
	private String currentUserName(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String loginUser = (String)httpSession.get("loginNick");
		
		if(loginUser == null) {
			String mid = session.getId();
			return mid;
		}
		String mid = loginUser;
		return mid;
		
	}
}
