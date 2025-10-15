<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>알림센터</title>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
  <link rel="stylesheet" href="/css/style.css"/>
  <style>
    .notification-card{border:1px solid var(--gray-300);border-radius:var(--radius-lg);padding:16px;background:#fff;margin-bottom:12px}
    .notification-card.unread{background:#F8FBFF;border-left:4px solid var(--navy-600)}
    .notification-title{font-weight:700;font-size:14px;margin-bottom:4px}
    .notification-desc{font-size:13px;color:var(--gray-600);margin-bottom:8px}
    .notification-meta{font-size:12px;color:var(--gray-500);display:flex;gap:12px;align-items:center}
    .pill-urgent{background:#dc2626;color:#fff}
    .pill-normal{background:#2563eb;color:#fff}
  </style>
</head>
<body class="bg-page">
<div id="header"></div>
<main class="py-4">
  <div class="container-1200 d-flex gap-24">
    <div id="sidebar"></div>
    <section class="flex-1">
      <div class="d-flex justify-content-between align-items-center mb-16">
        <div class="fw-700 fs-5">알림 센터</div>
      </div>

      <!-- 검색바 (풀폭) -->
      <div class="card-white p-16 mb-16">
        <input id="notiSearch" type="text" class="form-control h-40" placeholder="알림 검색(제목/내용)"/>
      </div>

      <div id="notificationList">
        <!-- 알림 1 -->
        <div class="notification-card unread">
          <div class="notification-title">[공지] 2학기 수강신청 안내</div>
          <div class="notification-desc">2학기 수강신청이 시작되었습니다. 기간을 확인하세요.</div>
          <div class="notification-meta">
            <span>2025-09-01</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 2 -->
        <div class="notification-card">
          <div class="notification-title">[장학] 국가장학금 2차 신청</div>
          <div class="notification-desc">국가장학금 2차 신청 마감은 9월 15일까지입니다.</div>
          <div class="notification-meta">
            <span>2025-09-02</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 3 -->
        <div class="notification-card unread">
          <div class="notification-title">[학사] 수업평가 실시 안내</div>
          <div class="notification-desc">모든 학생은 이번 학기 수업평가에 참여해야 합니다.</div>
          <div class="notification-meta">
            <span>2025-09-03</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 4 -->
        <div class="notification-card">
          <div class="notification-title">[성적] 1학기 성적 정정 기간</div>
          <div class="notification-desc">성적 이의신청은 9월 5일까지 접수 가능합니다.</div>
          <div class="notification-meta">
            <span>2025-09-04</span><span class="pill-urgent pill">긴급</span>
          </div>
        </div>

        <!-- 알림 5 -->
        <div class="notification-card">
          <div class="notification-title">[도서관] 도서 반납 연체 안내</div>
          <div class="notification-desc">연체된 도서가 있으니 반납 바랍니다.</div>
          <div class="notification-meta">
            <span>2025-09-05</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 6 -->
        <div class="notification-card">
          <div class="notification-title">[안전] 화재 대피 훈련 안내</div>
          <div class="notification-desc">9월 10일 오전 10시에 화재 대피 훈련이 있습니다.</div>
          <div class="notification-meta">
            <span>2025-09-06</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 7 -->
        <div class="notification-card unread">
          <div class="notification-title">[졸업] 조기졸업 신청 마감</div>
          <div class="notification-desc">조기졸업 신청은 9월 19일까지 제출해야 합니다.</div>
          <div class="notification-meta">
            <span>2025-09-07</span><span class="pill-urgent pill">긴급</span>
          </div>
        </div>

        <!-- 알림 8 -->
        <div class="notification-card">
          <div class="notification-title">[행사] 동아리 박람회</div>
          <div class="notification-desc">학생회관 앞에서 동아리 박람회가 진행됩니다.</div>
          <div class="notification-meta">
            <span>2025-09-08</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 9 -->
        <div class="notification-card">
          <div class="notification-title">[IT] 서버 점검 공지</div>
          <div class="notification-desc">9월 12일 새벽 1시~3시까지 시스템 점검이 있습니다.</div>
          <div class="notification-meta">
            <span>2025-09-09</span><span class="pill-urgent pill">긴급</span>
          </div>
        </div>

        <!-- 알림 10 -->
        <div class="notification-card">
          <div class="notification-title">[학과] 컴퓨터공학과 세미나</div>
          <div class="notification-desc">인공지능 최신 트렌드 세미나가 개최됩니다.</div>
          <div class="notification-meta">
            <span>2025-09-10</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 11 -->
        <div class="notification-card">
          <div class="notification-title">[기숙사] 점검 안내</div>
          <div class="notification-desc">기숙사 전기 설비 점검이 9월 13일 예정입니다.</div>
          <div class="notification-meta">
            <span>2025-09-11</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 12 -->
        <div class="notification-card">
          <div class="notification-title">[장학] 성적 우수 장학금 발표</div>
          <div class="notification-desc">성적 우수 장학생 명단이 발표되었습니다.</div>
          <div class="notification-meta">
            <span>2025-09-12</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 13 -->
        <div class="notification-card">
          <div class="notification-title">[체육] 교내 축구대회</div>
          <div class="notification-desc">9월 20일 운동장에서 교내 축구대회가 열립니다.</div>
          <div class="notification-meta">
            <span>2025-09-13</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 14 -->
        <div class="notification-card unread">
          <div class="notification-title">[학사] 휴학 신청 안내</div>
          <div class="notification-desc">휴학 신청은 9월 30일까지 가능합니다.</div>
          <div class="notification-meta">
            <span>2025-09-14</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 15 -->
        <div class="notification-card">
          <div class="notification-title">[도서관] 열람실 개방 시간 연장</div>
          <div class="notification-desc">시험 기간 동안 열람실 운영 시간이 연장됩니다.</div>
          <div class="notification-meta">
            <span>2025-09-15</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 16 -->
        <div class="notification-card">
          <div class="notification-title">[이벤트] 교내 벼룩시장</div>
          <div class="notification-desc">학생들이 직접 참여하는 벼룩시장이 열립니다.</div>
          <div class="notification-meta">
            <span>2025-09-16</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 17 -->
        <div class="notification-card">
          <div class="notification-title">[학과] 졸업 작품 전시회</div>
          <div class="notification-desc">졸업 작품 전시회가 예술관에서 개최됩니다.</div>
          <div class="notification-meta">
            <span>2025-09-17</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 18 -->
        <div class="notification-card">
          <div class="notification-title">[성적] 2학기 중간고사 일정</div>
          <div class="notification-desc">중간고사는 10월 20일부터 시작됩니다.</div>
          <div class="notification-meta">
            <span>2025-09-18</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 19 -->
        <div class="notification-card">
          <div class="notification-title">[행정] 학생증 재발급 안내</div>
          <div class="notification-desc">학생증 분실 시 재발급 신청이 가능합니다.</div>
          <div class="notification-meta">
            <span>2025-09-19</span><span class="pill-normal pill">일반</span>
          </div>
        </div>

        <!-- 알림 20 -->
        <div class="notification-card unread">
          <div class="notification-title">[학사] 수강 정정 마감</div>
          <div class="notification-desc">수강 정정은 9월 25일부로 마감됩니다.</div>
          <div class="notification-meta">
            <span>2025-09-20</span><span class="pill-urgent pill">긴급</span>
          </div>
        </div>
      </div>

    </section>
  </div>
</main>
<div id="footer"></div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="script/common-ui.js"></script>
<script src="script/app.js"></script>
<!-- ✅ 공통 include: static/mapper/... -->
<script>
  $(function () {
    $("#header").load("/mapper/header.html");
    $("#sidebar").load("/mapper/sidebar.html");
    $("#footer").load("/mapper/footer.html");
  });
</script>
</body>
</html>
