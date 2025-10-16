<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>비밀번호 초기화 - 관리자</title>

    <!-- 외부 CDN -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>

    <!-- 정적 리소스 -->
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <link rel="icon" href="<c:url value='/favicon.ico'/>"/>
</head>

<body class="bg-page">
<jsp:include page="/WEB-INF/views/components/header.jsp"/>

<main class="container-1200 d-flex gap-24 py-4">
    <jsp:include page="/WEB-INF/views/components/sidebar.jsp"/>

    <section class="flex-1 card-white p-4 shadow-sm">
        <!-- 제목 영역 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="fw-bold mb-0">비밀번호 초기화</h4>
            <a href="<c:url value='/auth/user-list'/>" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-arrow-left"></i> 목록으로
            </a>
        </div>

        <!-- 안내문 -->
        <div class="alert alert-warning small mb-4">
            ⚠️ 이 기능은 <strong>관리자 전용</strong>이며, 선택한 사용자의 비밀번호를 새로 설정합니다.
        </div>

        <!-- 초기화 폼 -->
        <form id="resetForm" class="w-50">
            <div class="mb-3">
                <label class="form-label fw-semibold">사용자 아이디</label>
                <input type="text" id="targetUsername" name="targetUsername" class="form-control" placeholder="아이디 입력" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">새 비밀번호</label>
                <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="새 비밀번호 입력" required>
            </div>

            <div class="d-flex justify-content-end gap-2 mt-4">
                <button type="button" class="btn btn-outline-secondary rounded-pill" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-danger rounded-pill px-4">비밀번호 초기화</button>
            </div>
        </form>
    </section>
</main>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>

<!-- 외부 JS -->
<script src="<c:url value='/vendor/jquery/jquery-3.7.1.min.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JS 로직 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script>
    // ✅ 비밀번호 초기화 요청 처리
    document.getElementById("resetForm").addEventListener("submit", async (e) => {
        e.preventDefault();

        const username = document.getElementById("targetUsername").value.trim();
        const newPassword = document.getElementById("newPassword").value.trim();
        const token = localStorage.getItem("accessToken");

        if (!username || !newPassword) {
            alert("모든 항목을 입력해주세요.");
            return;
        }

        try {
            // 1️⃣ 비밀번호 초기화 API 호출
            const res = await fetch("${ctx}/api/admin/reset-password", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${token}`
                },
                body: JSON.stringify({ username, newPassword })
            });

            if (!res.ok) {
                const msg = await res.text();
                alert("비밀번호 초기화 실패: " + msg);
                return;
            }

            alert("비밀번호가 성공적으로 초기화되었습니다.");

            // 2️⃣ username으로 id 조회 후 상세페이지로 이동
            const res2 = await fetch("${ctx}/api/admin/user/by-username?username=" + encodeURIComponent(username), {
                headers: { "Authorization": `Bearer ${token}` }
            });

            if (res2.ok) {
                const data = await res2.json();
                // 🔹 조회된 id로 상세 페이지 이동
                location.href = "${ctx}/auth/user-detail?id=" + data.id;
            } else {
                // 🔹 실패 시 목록으로 이동
                alert("사용자 정보를 찾을 수 없습니다. 목록으로 이동합니다.");
                location.href = "${ctx}/auth/user-list";
            }

        } catch (error) {
            console.error(error);
            alert("서버 오류가 발생했습니다.");
        }
    });
</script>
</body>
</html>
