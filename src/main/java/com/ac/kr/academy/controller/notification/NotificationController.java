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
    @GetMapping("/notificationList")
    public String myNotificationList(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (userDetails == null) {
            return "redirect:/auth/login";
        }
        Long targetId = userDetails.getUser().getId();
        model.addAttribute("notifications", notificationService.getNotificationList(targetId));
        return "notification/notificationList";
    }

    // => /WEB-INF/views/notification/notificationList.jsp
    }

