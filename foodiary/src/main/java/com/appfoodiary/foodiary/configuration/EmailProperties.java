package com.appfoodiary.foodiary.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@ConfigurationProperties(prefix="custom.email")
@Component
@Data
public class EmailProperties {

	private String host, username, password;
	private int port;
}
