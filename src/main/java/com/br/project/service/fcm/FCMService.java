package com.br.project.service.fcm;

import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Service;

import com.br.project.dto.fcm.NotificationRequest;
import com.br.project.dto.notification.NotificationDto;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.WebpushConfig;
import com.google.firebase.messaging.WebpushNotification;

@Service
public class FCMService {
	
	 public void send(final NotificationRequest notificationRequest) throws InterruptedException, ExecutionException {
	        Message message = Message.builder()
	                .setToken(notificationRequest.getToken())
	                .setWebpushConfig(WebpushConfig.builder().putHeader("ttl", "300")
	                        .setNotification(new WebpushNotification(notificationRequest.getTitle(),
	                                notificationRequest.getMessage()))
	                        .build())
	                .build();
	        String response = FirebaseMessaging.getInstance().sendAsync(message).get();
	    }
}
