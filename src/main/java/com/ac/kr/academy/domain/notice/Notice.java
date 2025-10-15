package com.ac.kr.academy.domain.notice;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Data
public class Notice {
    private Long id;
    private String title;
    private String content;

    // 날짜 필드 변환 설정
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate; // 시작일자

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;   // 종료일자

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate createdAt; // 생성일

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate deadline;  // 미리알림(연/월/일)

    private int viewCount;       // 조회수
    private int isUrgent;        // 긴급공지 여부(1:긴급, 0:일반)
    private int isSent;          // 중복 알림 방지 (0: 미발송, 1: 발송)

    // jsp 에서는 LocalDate 사용 불가로 String 변환 게터 제공
    public String getCreatedAtStr() {
        return createdAt != null ? createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
    }

    public String getDeadlineStr() {
        return deadline != null ? deadline.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
    }

    public String getStartDateStr() {
        return startDate != null ? startDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
    }

    public String getEndDateStr() {
        return endDate != null ? endDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
    }
}
