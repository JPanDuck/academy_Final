package com.ac.kr.academy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {

    /**
     * 로그인 후 보여줄 메인 대시보드 페이지를 반환합니다.
     * /common/index URL 요청을 처리합니다.
     */
    @GetMapping("/index")
    public String mainDashboardPage() {
        // "common/index"는 ViewResolver에 의해
        // "/WEB-INF/views/common/index.jsp" 경로로 변환됩니다.
        return "common/index";
    }
}