package com.ac.kr.academy.controller.notification;

import com.ac.kr.academy.domain.notification.Notification;
import com.ac.kr.academy.security.CustomUserDetails;
import com.ac.kr.academy.service.notification.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class NotificationController {
    private final NotificationService notificationService;

    // 1) 특정 targetId 알림 목록
    @GetMapping("/notifications/{targetId}")
    public String notificationList(@PathVariable Long targetId, Model model){
        model.addAttribute("notifications", notificationService.getNotificationList(targetId));
        return "notification/notificationList";
        // => /WEB-INF/views/notification/notificationList.jsp
    }

    // 2) 로그인한 사용자 자신의 알림 목록
    @GetMapping("/notificationList")
    public String myNotificationList(Model model, @AuthenticationPrincipal CustomUserDetails user) {
        List<Notification> notifications = notificationService.getNotificationList(user.getUserId());
        model.addAttribute("notifications", notifications);
        return "notification/notificationList";
        // => /WEB-INF/views/notification/notificationList.jsp
    }
}
