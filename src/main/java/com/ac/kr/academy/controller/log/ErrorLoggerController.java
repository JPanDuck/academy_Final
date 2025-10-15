package com.ac.kr.academy.controller.log;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/error")
public class ErrorLoggerController implements ErrorController {

    @RequestMapping
    public ResponseEntity<Map<String, Object>> handleError(HttpServletRequest request, HttpServletResponse response) {
        Object statusObj = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        int statusCode = (statusObj != null) ? Integer.parseInt(statusObj.toString()) : 500;
        String path = (String) request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);

        // ✅ 에러 로그 기록
        if (statusCode == HttpServletResponse.SC_NOT_FOUND) {
            log.warn("Client Error: Status 404 Not Found - {}", path);
        } else if (statusCode >= 500) {
            log.error("Server Error: Status {} - {}", statusCode, path);
        } else {
            log.info("Error: Status {} - {}", statusCode, path);
        }

        // ✅ JSON 형태로 에러 내용 반환
        Map<String, Object> body = new HashMap<>();
        body.put("status", statusCode);
        body.put("path", path);
        body.put("message", "요청 처리 중 오류가 발생했습니다.");

        return ResponseEntity.status(statusCode).body(body);
    }
}
