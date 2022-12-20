package com.appfoodiary.foodiary.websocket;

import java.sql.Date;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.appfoodiary.foodiary.vo.NotiVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

/**
 *	웹소켓의 문제점
 *	- 구버전 브라우저 미지원
 *	- 주소가 ws 혹은 wss로 시작 
 *
 *	해결할 수 있는 기술 
 *	- sockJS, socket.io 등
 *	- 구버전 브라우저는 풀링 혹은 롱풀링 방식으로 해결
 *	- 주소를 http 또는 https로 시작하도록 해줌
 *
 *	적용방식
 *	- 서버 등록시 SockJS를 사용하겠다고 선언
 *	- 클라이언트 코드를 sockJS로 구현
 */
@Slf4j
@Service
public class SockJSWebsocketServer extends TextWebSocketHandler{
	// 로그인 중인 개별유저
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();

	// 클라이언트가 서버로 연결 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.add(session);
	}
	
	// 연결 해제 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session);
	}
	
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map<String, Object> attributes = session.getAttributes();
		Integer callerMemNo = (Integer)attributes.get("loginNo");
		
		// 특정 유저에게 보내기
		log.debug("메세지 - {}", message.getPayload());
//		String msg = message.getPayload();
//		if(msg != null) {
//			String[] strs = msg.split(",");
//			log.debug(strs.toString());
//			if(strs != null && strs.length == 4) {
//				String type = strs[0];
//				String target = strs[1]; // m_id 저장
//				String content = strs[2];
//				String url = strs[3];
//				WebSocketSession targetSession = users.get(target);  // 메시지를 받을 세션 조회
//				
//				// 실시간 접속시
//				if(targetSession!=null) {
//					// ex: [&분의일] 신청이 들어왔습니다.
//					TextMessage tmpMsg = new TextMessage("<a target='_blank' href='"+ url +"'>[<b>" + type + "</b>] " + content + "</a>" );
//					targetSession.sendMessage(tmpMsg);
//				}
//			}
//		}
		
		
		//변환 도구 생성
		ObjectMapper mapper = new ObjectMapper();
		//Map json = mapper.readValue(message.getPayload(), Map.class);
		//log.debug("json = {}", json);
		
		NotiVO json = mapper.readValue(
				message.getPayload(), NotiVO.class);
		log.debug("json = {}", json);
		
		//바뀐 정보를 이용하여 신규 메세지 생성
		String payload = mapper.writeValueAsString(json);
		TextMessage jsonMessage = new TextMessage(payload);
		
		
		//모두에게 발송(broadcast)
		for(WebSocketSession user : users) {
			//user.sendMessage(json);
			user.sendMessage(jsonMessage);
		}
	}
	
}
