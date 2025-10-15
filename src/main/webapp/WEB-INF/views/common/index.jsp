<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>학사정보관리시스템 - 대시보드</title>

    <!-- 폰트/부트스트랩 -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <link rel="icon" href="data:,">
</head>
<body class="bg-page">

<%-- 헤더 --%>
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="py-4">
    <div class="container-1200 d-flex gap-24">

        <%-- 사이드바 --%>
        <%@ include file="/WEB-INF/views/components/sidebar.jsp" %>

        <section class="flex-1 d-flex flex-column gap-24">

            <%-- 대시보드 카드 --%>
            <div class="row g-3">
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card-white p-20 card-filter-item">
                        <div class="text-gray-600 xsmall mb-1">재학생 수</div>
                        <div class="fs-24 fw-700">1,234명</div>
                        <div class="xsmall text-gray-500 mt-2">업데이트: 2025-10-01 12:00</div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card-white p-20 card-filter-item">
                        <div class="text-gray-600 xsmall mb-1">교수 수</div>
                        <div class="fs-24 fw-700">87명</div>
                        <div class="xsmall text-gray-500 mt-2">업데이트: 2025-10-01 12:00</div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card-white p-20 card-filter-item">
                        <div class="text-gray-600 xsmall mb-1">개설 강좌</div>
                        <div class="fs-24 fw-700">156개</div>
                        <div class="xsmall text-gray-500 mt-2">업데이트: 2025-10-01 12:00</div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card-white p-20 card-filter-item">
                        <div class="text-gray-600 xsmall mb-1">공지사항</div>
                        <div class="fs-24 fw-700">12건</div>
                        <div class="xsmall text-gray-500 mt-2">업데이트: 2025-10-01 12:00</div>
                    </div>
                </div>
            </div>

                <%-- 인원 분포 그래프 & 알림센터 --%>
                <div class="row g-3">
                    <!-- 인원 분포 그래프 -->
                    <div class="col-12 col-lg-6">
                        <div class="card-white p-20 h-100">
                            <h5 class="mb-3">학교 인원 분포</h5>
                            <canvas id="populationChart" height="200"></canvas>
                        </div>
                    </div>

                    <!-- 알림센터 -->
                    <div class="col-12 col-lg-6">
                        <div class="card-white p-20 h-100">
                            <h5 class="mb-3">알림센터</h5>
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    [공지] 2025년 2학기 수강신청 시작
                                    <span class="badge bg-primary rounded-pill">New</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    서버 점검 안내 (10/05 01:00~03:00)
                                    <span class="badge bg-warning rounded-pill">중요</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    학사 일정 업데이트 (10/02 반영)
                                    <span class="badge bg-success rounded-pill">Info</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    새 학과 공지사항 등록됨
                                    <span class="badge bg-secondary rounded-pill">공지</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>


        </section>
    </div>
</main>

<%-- 푸터 --%>
<%@ include file="/WEB-INF/views/components/footer.jsp" %>

<!-- 스크립트 -->
<script src="<c:url value='/vendor/jquery/jquery-3.7.1.min.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    // ✅ 인원 분포 차트 (하드코딩)
    const ctx = document.getElementById('populationChart');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['재학생', '교수', '직원'],
            datasets: [{
                data: [1234, 87, 45],
                backgroundColor: ['#0d6efd', '#198754', '#6c757d']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>
<script>    //로그아웃 로직
document.getElementById('logoutForm').addEventListener('submit', function (event){
    event.preventDefault();

    //JWT 토큰 삭제
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    localStorage.removeItem('jwtToken');    //로그 모니터링에 사용된 토큰

    //접속기록 남기기 위한 POST 요청
    fetch('/api/auth/logout', {
        method: 'POST'
    })
        .then(response => {
            //서버 응답 성공 시 (접속 기록 성공) -> 로그아웃 후 로그인 페이지로 이동
            window.location.href = '/auth/login';
        })
        .catch(error => {
            console.error('로그아웃 API 호출 오류: ', error);
            alert("로그아웃 처리중 오류 발생했으나, 로컬 인증 정보 삭제 완료");
            window.location.href = "/auth/login";
        })
});
</script>
</body>
</html>
