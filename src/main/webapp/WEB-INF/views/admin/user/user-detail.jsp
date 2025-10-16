<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>사용자 관리 - 상세</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
</head>
<body class="bg-page">
<jsp:include page="/WEB-INF/views/components/header.jsp"/>
<main class="container-1200 d-flex gap-24 py-4">
    <jsp:include page="/WEB-INF/views/components/sidebar.jsp"/>
    <section class="flex-1 card-white p-4 shadow-sm">
        <div class="d-flex justify-content-between mb-3">
            <h4 class="fw-bold">사용자 상세</h4>
            <div class="d-flex gap-2">
                <a href="<c:url value='/auth/user-update'/>?id=${userId}" class="btn btn-primary">
                    <i class="bi bi-pencil"></i> 수정
                </a>
                <a href="<c:url value='/auth/reset-password'/>?id=${userId}" class="btn btn-warning">
                    <i class="bi bi-key"></i> 비밀번호 초기화
                </a>
                <a href="<c:url value='/auth/user-delete'/>?id=${userId}" class="btn btn-danger">
                    <i class="bi bi-trash"></i> 삭제
                </a>
            </div>
        </div>
        <table class="table table-bordered">
            <tbody>
            <tr><th>ID</th><td id="id"></td></tr>
            <tr><th>이름</th><td id="name"></td></tr>
            <tr><th>이메일</th><td id="email"></td></tr>
            <tr><th>권한</th><td id="role"></td></tr>
            <tr><th>전화번호</th><td id="phone"></td></tr>
            </tbody>
        </table>
    </section>
</main>
<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
<script src="<c:url value='/vendor/jquery/jquery-3.7.1.min.js'/>"></script>
<script>
    $(function(){
        const id = "${userId}";
        $.get("${pageContext.request.contextPath}/api/admin/user/" + id, function(user){
            $("#id").text(user.id);
            $("#name").text(user.name);
            $("#email").text(user.email);
            $("#role").text(user.role);
            $("#phone").text(user.phone);
        });
    });
</script>

</body>
</html>
