<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>비밀번호 찾기</title>

    <!-- 외부 리소스 -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
</head>
<body class="bg-page">

<div class="login-wrapper">
    <div class="card-white p-4 login-card">
        <div class="text-center mb-3">
            <div class="login-logo-wrap">
                <img class="login-logo" src="<c:url value='/img/logo.png'/>" alt="로고"/>
            </div>
            <div class="brand-title">비밀번호 찾기</div>
            <div class="brand-sub small text-gray-600">
                아이디, 이름, 이메일을 입력하고 새 비밀번호를 설정하세요.
            </div>
        </div>

        <!-- 비밀번호 찾기 폼 -->
        <form id="findPasswordForm">
            <input type="text" id="username" name="username" class="form-control mb-2" placeholder="아이디" required/>
            <input type="text" id="name" name="name" class="form-control mb-2" placeholder="이름" required/>
            <input type="email" id="email" name="email" class="form-control mb-2" placeholder="이메일" required/>
            <input type="password" id="newPassword" name="newPassword" class="form-control mb-3" placeholder="새 비밀번호 (8자 이상)" required/>
            <button type="submit" class="btn btn-navy w-100 rounded-pill">비밀번호 재설정</button>
        </form>

        <div class="text-center mt-3">
            <a href="<c:url value='/auth/login'/>" class="xsmall text-navy">로그인 페이지로 돌아가기</a>
        </div>
    </div>
</div>

<!-- 외부 JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script>
    $(function() {
        $("#findPasswordForm").on("submit", async function(e) {
            e.preventDefault();

            const username = $("#username").val().trim();
            const name = $("#name").val().trim();
            const email = $("#email").val().trim();
            const newPassword = $("#newPassword").val().trim();

            if (!username || !name || !email) {
                alert("아이디, 이름, 이메일을 모두 입력하세요.");
                return;
            }
            if (newPassword.length < 8) {
                alert("새 비밀번호는 최소 8자 이상이어야 합니다.");
                return;
            }

            try {
                const res = await fetch("${ctx}/api/auth/find-password", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ username, name, email, newPassword })
                });

                const text = await res.text();

                if (res.ok) {
                    alert(text || "비밀번호가 성공적으로 재설정되었습니다.");
                    window.location.href = "${ctx}/auth/login";
                } else {
                    alert(text || "입력하신 정보가 일치하지 않습니다.");
                }
            } catch (error) {
                console.error(error);
                alert("비밀번호 재설정 중 오류가 발생했습니다.");
            }
        });
    });
</script>

</body>
</html>
