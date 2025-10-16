<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>학사정보관리시스템 - 로그 모니터링</title>

    <!-- 폰트/부트스트랩 -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <link rel="icon" href="data:,">

    <style>
        .container-1200 {
            max-width: 1600px !important;
            margin: 0 auto;
        }
        #logArea {
            background: #000;
            color: #00FF00;
            padding: 16px;
            height: 70vh;
            overflow-y: auto;
            border-radius: 8px;
            font-family: Consolas, monospace;
            white-space: pre-wrap;
            word-break: break-word;
            font-size: 13px;
            line-height: 1.4;
        }
    </style>
</head>
<body class="bg-page">

<!-- 헤더 -->
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="py-4">
    <div class="container-1200 d-flex gap-24">

        <!-- 사이드바 -->
        <%@ include file="/WEB-INF/views/components/sidebar.jsp" %>

        <!-- 로그 모니터링 -->
        <section class="flex-1">
            <div class="card-white p-20">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0 text-navy fw-700">시스템 로그 모니터링</h5>
                    <button class="btn btn-sm btn-navy" onclick="loadLogs()">
                        <i class="bi bi-arrow-repeat"></i> 새로고침
                    </button>
                </div>

                <pre id="logArea">Loading logs...</pre>
            </div>
        </section>

    </div>
</main>

<!-- 푸터 -->
<%@ include file="/WEB-INF/views/components/footer.jsp" %>

<!-- 스크립트 -->
<script src="<c:url value='/vendor/jquery/jquery-3.7.1.min.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    async function loadLogs() {
        const logArea = document.getElementById("logArea");
        let token = localStorage.getItem("accessToken");

        if (!token) {
            logArea.textContent = "⚠️ 로그인 토큰이 없습니다. 관리자 로그인 후 다시 시도하세요.";
            return;
        }

        // 혹시 "Bearer " 가 붙어있다면 제거
        token = token.replace(/^Bearer\s+/i, "").trim();

        try {
            const res = await fetch("/api/admin/logs/monitor", {
                method: "GET",
                headers: {
                    "Authorization": `Bearer ${token}`,
                    "Content-Type": "application/json"
                }
            });

            if (!res.ok) {
                const contentType = res.headers.get("content-type") || "";
                let message = "";

                if (contentType.includes("application/json")) {
                    const data = await res.json().catch(() => ({}));
                    message = data.message || JSON.stringify(data);
                } else {
                    message = await res.text(); // JSON 아니면 그대로 텍스트 읽기
                }

                logArea.textContent = `HTTP ${res.status} ${res.statusText}\n${message}`;
                return;
            }


            const data = await res.json();
            logArea.textContent = Array.isArray(data.logs)
                ? data.logs.join("\n")
                : data.message || "No logs found.";

            logArea.scrollTop = logArea.scrollHeight;

        } catch (err) {
            logArea.textContent = "Error loading logs: " + err;
        }
    }

    document.addEventListener("DOMContentLoaded", loadLogs);
</script>
</body>
</html>
