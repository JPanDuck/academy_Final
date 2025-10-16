<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>학사정보관리시스템 - 공지 수정</title>

    <!-- 공통 CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="<c:url value='/favicon.ico'/>"/>
</head>
<body class="bg-page page-notice">

<!-- header -->
<jsp:include page="/WEB-INF/views/components/header.jsp"/>

<main class="py-4">
    <div class="container-1200 d-flex gap-24">

        <!-- sidebar -->
        <jsp:include page="/WEB-INF/views/components/sidebar.jsp"/>

        <!-- 본문 -->
        <section class="flex-1">
            <div class="card-white p-20">
                <div class="fw-700 fs-5 mb-3">✏️ 공지 수정</div>

                <form id="editForm" action="<c:url value='/notices/edit'/>" method="post">
                    <input type="hidden" name="id" value="${notice.id}"/>

                    <!-- 제목 -->
                    <div class="mb-3">
                        <label for="title" class="form-label">제목</label>
                        <input type="text" class="form-control" id="title" name="title" value="${notice.title}" required/>
                    </div>

                    <!-- 내용 -->
                    <div class="mb-3">
                        <label for="content" class="form-label">내용</label>
                        <textarea class="form-control" id="content" name="content" rows="6" required>${notice.content}</textarea>
                    </div>

                    <!-- 날짜 -->
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="startDate" class="form-label">시작일</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" value="${notice.startDateStr}" required/>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="endDate" class="form-label">종료일</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" value="${notice.endDateStr}" required/>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="deadline" class="form-label">마감일</label>
                            <input type="date" class="form-control" id="deadline" name="deadline" value="${notice.deadlineStr}" required/>
                        </div>
                    </div>

                    <!-- 긴급 여부 -->
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="isUrgent" name="isUrgent" value="1"
                               <c:if test="${notice.isUrgent == 1}">checked</c:if>/>
                        <label class="form-check-label" for="isUrgent">긴급 여부</label>
                    </div>

                    <!-- 버튼 -->
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-warning">
                            <i class="bi bi-pencil-square"></i> 수정
                        </button>
                        <a href="<c:url value='/notices/detail/${notice.id}'/>" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i> 취소
                        </a>
                    </div>
                </form>
            </div>
        </section>
    </div>
</main>

<!-- footer -->
<jsp:include page="/WEB-INF/views/components/footer.jsp"/>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // add.jsp와 동일한 검증 로직 적용
    document.getElementById("editForm").addEventListener("submit", function(e) {
        const title = document.getElementById("title").value.trim();
        const content = document.getElementById("content").value.trim();
        const startDate = document.getElementById("startDate").value;
        const endDate = document.getElementById("endDate").value;
        const deadline = document.getElementById("deadline").value;

        if (!title || !content || !startDate || !endDate || !deadline) {
            e.preventDefault();
            alert("제목, 내용, 시작일, 종료일, 마감일을 모두 입력해주세요.");
            return false;
        }

        const sDate = new Date(startDate);
        const eDate = new Date(endDate);
        const dDate = new Date(deadline);

        if (sDate > eDate) {
            e.preventDefault();
            alert("종료일은 시작일보다 빠를 수 없습니다.");
            return false;
        }

        if (dDate < sDate || dDate > eDate) {
            e.preventDefault();
            alert("마감일은 시작일과 종료일 사이여야 합니다.");
            return false;
        }
    });
</script>

</body>
</html>
