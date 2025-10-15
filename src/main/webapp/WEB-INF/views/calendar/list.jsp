<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>학사정보관리시스템 - 학사일정</title>

    <!-- ✅ 공통 CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <!-- ✅ 파비콘 -->
    <link rel="icon" type="image/x-icon" href="<c:url value='/favicon.ico'/>"/>

    <style>
        .page-calendar { --container: 1200px; }
        .cal-wrap { display:grid; grid-template-columns:1fr; gap:16px; min-width:0; }
        .container-1200, .card-white, .fc { min-width:0; overflow:visible; }
        .month-list .item{display:flex;gap:12px;padding:10px 12px;border-bottom:1px solid var(--gray-200)}
        .month-list .date{width:200px;color:var(--gray-700);font-weight:700;white-space:nowrap;}
        .fc .fc-toolbar-title{text-align:center;flex:1;}
        .fc .fc-daygrid-event{white-space:normal;height:fit-content;font-weight:500;padding:2px 4px;font-size:13px;margin:1px;}
        .fc-daygrid-day.has-dot::after{content:"";display:block;width:6px;height:6px;margin:2px auto 0;border-radius:50%;background-color:#0d6efd;}
    </style>
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
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="fw-700 fs-5">학사일정</div>
                    <a href="<c:url value='/calendar/add'/>" class="btn btn-sm btn-primary">
                        <i class="bi bi-plus-circle"></i> 새 일정 추가
                    </a>
                </div>

                <!-- 📅 FullCalendar -->
                <div class="cal-wrap mb-4">
                    <div id="calendar"></div>
                    <div>
                        <div class="fw-700 mb-2" id="monthTitle">이달의 학사일정</div>
                        <div id="monthList" class="month-list card-white p-0"></div>
                    </div>
                </div>

                <!-- 📌 일정 목록 테이블 -->
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>시작일</th>
                        <th>종료일</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="cal" items="${calendars}">
                        <tr>
                            <td>${cal.id}</td>
                            <td>${cal.title}</td>
                            <td><fmt:formatDate value="${cal.startDate}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty cal.endDate}">
                                        <fmt:formatDate value="${cal.endDate}" pattern="yyyy-MM-dd"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatDate value="${cal.startDate}" pattern="yyyy-MM-dd"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="<c:url value='/calendar/edit/${cal.id}'/>" class="btn btn-sm btn-warning">수정</a>
                                <form action="<c:url value='/calendar/delete/${cal.id}'/>" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </section>
    </div>
</main>

<!-- ✅ footer -->
<jsp:include page="/WEB-INF/views/components/footer.jsp"/>

<!-- ✅ jQuery (경로 수정됨) -->
<script src="<c:url value='/vendor/jquery/jquery-3.7.1.min.js'/>"></script>

<!-- ✅ FullCalendar JS -->
<script src="<c:url value='/vendor/fullcalendar/core/index.global.min.js'/>"></script>
<script src="<c:url value='/vendor/fullcalendar/daygrid/index.global.min.js'/>"></script>
<script src="<c:url value='/vendor/fullcalendar/bootstrap5/index.global.min.js'/>"></script>
<script src="<c:url value='/vendor/fullcalendar/core/locales/ko.global.min.js'/>"></script>


<!-- ✅ DB 일정 내려주기 -->
<script>
    window.ALL_EVENTS = [
        <c:forEach var="cal" items="${calendars}" varStatus="status">
        {
            title: "${cal.title}",
            start: "${cal.startDate}",
            end: "${cal.endDate}"
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
</script>

<!-- ✅ 분리된 캘린더 JS -->
<script src="<c:url value='/js/calendar.js'/>"></script>

</body>
</html>
