<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>학사정보관리시스템 - 일정 수정</title>

  <!-- ✅ 공통 CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
  <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
  <!-- ✅ 파비콘 -->
  <link rel="icon" type="image/x-icon" href="<c:url value='/favicon.ico'/>"/>
</head>
<body class="bg-page page-calendar">

<!-- ✅ header -->
<jsp:include page="/WEB-INF/views/components/header.jsp"/>

<main class="py-4">
  <div class="container-1200 d-flex gap-24">

    <!-- ✅ sidebar -->
    <jsp:include page="/WEB-INF/views/components/sidebar.jsp"/>

    <!-- ✅ 본문 -->
    <section class="flex-1">
      <div class="card-white p-20">
        <div class="fw-700 fs-5 mb-3">✏️ 일정 수정</div>

        <form id="editCalendarForm" action="<c:url value='/calendar/edit'/>" method="post">
          <input type="hidden" name="id" value="${calendar.id}"/>

          <!-- 제목 -->
          <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="${calendar.title}" required/>
          </div>

          <!-- 시작일 / 종료일 -->
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="startDate" class="form-label">시작일</label>
              <input type="date" class="form-control" id="startDate" name="startDate" value="${calendar.startDateStr}" required/>
            </div>
            <div class="col-md-6 mb-3">
              <label for="endDate" class="form-label">종료일</label>
              <input type="date" class="form-control" id="endDate" name="endDate" value="${calendar.endDateStr}" required/>
            </div>
          </div>

          <!-- 버튼 -->
          <div class="d-flex gap-2">
            <button type="submit" class="btn btn-warning">
              <i class="bi bi-pencil-square"></i> 수정
            </button>
            <a href="<c:url value='/calendar'/>" class="btn btn-secondary">
              <i class="bi bi-x-circle"></i> 취소
            </a>
          </div>
        </form>
      </div>
    </section>
  </div>
</main>

<!-- ✅ footer -->
<jsp:include page="/WEB-INF/views/components/footer.jsp"/>

<!-- ✅ JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById("editCalendarForm").addEventListener("submit", function(e) {
    const title = document.getElementById("title").value.trim();
    const startDate = document.getElementById("startDate").value;
    const endDate = document.getElementById("endDate").value;

    if (!title || !startDate || !endDate) {
      e.preventDefault();
      alert("제목, 시작일, 종료일을 모두 입력해주세요.");
      return false;
    }

    const sDate = new Date(startDate);
    const eDate = new Date(endDate);

    if (sDate > eDate) {
      e.preventDefault();
      alert("종료일은 시작일보다 빠를 수 없습니다.");
      return false;
    }
  });
</script>

</body>
</html>
