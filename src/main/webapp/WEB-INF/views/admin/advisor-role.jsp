<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>학사정보관리시스템 - 지도교수 관리</title>

    <!-- 폰트/부트스트랩 -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <link rel="icon" href="data:,">
</head>
<body class="bg-page">t

<!-- 헤더 -->
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="py-4">
    <div class="container-1200 d-flex gap-24">

        <!-- 사이드바 -->
        <%@ include file="/WEB-INF/views/components/sidebar.jsp" %>

        <section class="flex-1 d-flex flex-column gap-24">

            <!-- 제목 -->
            <div class="d-flex align-items-center justify-content-between mb-3">
                <h4 class="fw-bold mb-0">지도교수 권한 관리</h4>
                <small class="text-gray-500">관리자 전용 페이지</small>
            </div>

            <!-- 권한 변경 폼 -->
            <div class="card-white p-4">
                <form id="advisorForm" class="row g-3 align-items-end">
                    <div class="col-md-5">
                        <label for="professorUserId" class="form-label fw-semibold">교수 선택</label>
                        <select class="form-select" id="professorUserId" name="professorUserId" required>
                            <option value="">교수를 선택하세요</option>
                            <c:forEach var="prof" items="${professorList}">
                                <option value="${prof.id}">${prof.name} (${prof.username})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-5">
                        <label for="deptId" class="form-label fw-semibold">학과 선택</label>
                        <select class="form-select" id="deptId" name="deptId" required>
                            <option value="">학과를 선택하세요</option>
                            <c:forEach var="dept" items="${deptList}">
                                <option value="${dept.id}">${dept.deptName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-2 d-flex gap-2">
                        <button type="button" id="assignBtn" class="btn btn-primary w-100">지정</button>
                        <button type="button" id="revertBtn" class="btn btn-outline-danger w-100">해제</button>
                    </div>
                </form>

                <!-- 결과 메시지 -->
                <div id="resultBox" class="alert d-none mt-3"></div>
            </div>

            <!-- 지도교수 현황 테이블 -->
            <div class="card-white p-4 mt-3">
                <h5 class="fw-bold mb-3">현재 학과별 지도교수 현황</h5>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>교수명</th>
                            <th>아이디</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>권한</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="prof" items="${professorList}">
                            <tr>
                                <td>${prof.name}</td>
                                <td>${prof.username}</td>
                                <td>${prof.email}</td>
                                <td>${prof.phone}</td>
                                <td>
                                    <span class="badge ${prof.role eq 'ROLE_ADVISOR' ? 'bg-success' : 'bg-secondary'}">
                                        ${prof.role eq 'ROLE_ADVISOR' ? '지도교수' : '교수'}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
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
    const resultBox = document.getElementById('resultBox');

    // 지도교수 지정
    document.getElementById('assignBtn').addEventListener('click', () => {
        const professorUserId = document.getElementById('professorUserId').value;
        const deptId = document.getElementById('deptId').value;

        if (!professorUserId || !deptId) {
            alert("교수와 학과를 모두 선택하세요.");
            return;
        }

        fetch('<c:url value="/auth/assign-advisor"/>', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ professorUserId, deptId })
        })
        .then(res => res.text())
        .then(msg => showResult(msg, 'success'))
        .catch(() => showResult("권한 지정 중 오류 발생", 'danger'));
    });

    // 지도교수 권한 해제
    document.getElementById('revertBtn').addEventListener('click', () => {
        const professorUserId = document.getElementById('professorUserId').value;
        if (!professorUserId) {
            alert("해제할 교수를 선택하세요.");
            return;
        }

        fetch('<c:url value="/auth/revert-advisor-role"/>', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ professorUserId })
        })
        .then(res => res.text())
        .then(msg => showResult(msg, 'warning'))
        .catch(() => showResult("권한 해제 중 오류 발생", 'danger'));
    });

    function showResult(message, type) {
        resultBox.className = `alert alert-${type} mt-3`;
        resultBox.textContent = message;
        resultBox.classList.remove('d-none');
        setTimeout(() => resultBox.classList.add('d-none'), 3000);
    }
</script>

</body>
</html>
