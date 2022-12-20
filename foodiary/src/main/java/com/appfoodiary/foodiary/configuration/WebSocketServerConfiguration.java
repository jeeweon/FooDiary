package com.appfoodiary.foodiary.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.appfoodiary.foodiary.websocket.SockJSWebsocketServer;

@Configuration
@EnableWebSocket//웹소켓 활성화
public class WebSocketServerConfiguration implements WebSocketConfigurer{
	
	@Autowired
	private SockJSWebsocketServer sockJSWebsocketServer;
	
	@Override
	public void registerWebSocketHandlers(
							WebSocketHandlerRegistry registry) {
		//등록 시 주의사항
		//- 절대로 다른 페이지와 주소가 겹치면 안된다
		//- HTTP가 사용중이면 웹소켓 서버는 정상 작동하지 않는다
		//HttpSessionHandshakeInterceptor는 HttpSession을 WebSocketSession으로 넘겨준다
		registry.addHandler(sockJSWebsocketServer, "/ws/sockjs")
						.addInterceptors(new HttpSessionHandshakeInterceptor())
						.withSockJS();
	}
}
