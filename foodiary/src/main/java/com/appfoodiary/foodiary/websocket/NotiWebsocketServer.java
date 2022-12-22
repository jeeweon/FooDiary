package com.appfoodiary.foodiary.websocket;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.appfoodiary.foodiary.vo.MemSearchVO;
import com.appfoodiary.foodiary.vo.NotiVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NotiWebsocketServer extends TextWebSocketHandler{
	// 로그인 중인 개별유저
	//private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	// 클라이언트가 서버로 연결 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.debug("Socket 연결");
		log.debug(currentUserName(session));//현재 접속한 사람
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId,session);
	}
	
	// 연결 해제 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userSessionsMap.remove(currentUserName(session), session);
		log.debug("종료");
	}
	
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug("메세지 - {}", message.getPayload());
	
		//변환 도구 생성
		ObjectMapper mapper = new ObjectMapper();

		NotiVO json = mapper.readValue(
				message.getPayload(), NotiVO.class);
		log.debug("json = {}", json);
		
		//바뀐 정보를 이용하여 신규 메세지 생성
		String payload = mapper.writeValueAsString(json);
		TextMessage jsonMessage = new TextMessage(payload);
		
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
