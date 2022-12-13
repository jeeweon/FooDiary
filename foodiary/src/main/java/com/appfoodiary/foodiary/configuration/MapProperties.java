package com.appfoodiary.foodiary.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "custom.map")
public class MapProperties {
	private String appkey;
}
