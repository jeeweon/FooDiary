package com.appfoodiary.foodiary.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.appfoodiary.foodiary.websocket.NotiWebsocketServer;

@Configuration
@EnableWebSocket//웹소켓 활성화
public class WebSocketServerConfiguration implements WebSocketConfigurer{
	
	@Autowired
	private NotiWebsocketServer notiWebsocketServer;
	
	@Override
	public void registerWebSocketHandlers(
							WebSocketHandlerRegistry registry) {
		registry.addHandler(notiWebsocketServer, "/ws/sockjs")
						.addInterceptors(new HttpSessionHandshakeInterceptor())
						.withSockJS();
	}
}
