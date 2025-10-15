<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>공지 상세</title>

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

  <!-- Bootstrap & Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>

  <!-- App CSS (정적리소스: src/main/resources/static/css/style.css) -->
  <link rel="stylesheet" href="<c:url value="//css/style.css/>"/>

  <style>
    .notice-view .title { font-size:20px; font-weight:700; }
    .notice-view .meta  { font-size:13px; color:var(--gray-500); margin-top:4px; }
    .notice-view .content { margin-top:20px; white-space:pre-line; }
  </style>
</head>
<body class="bg-page">

<!-- 공통 헤더/사이드바/푸터 include
     - 실제 경로에 맞춰 조정하세요 (예: /WEB-INF/views/partials/header.jsp 등)
     - 정적 HTML 조각이라면 .html도 include 가능 -->
<jsp:include page="//header.jsp"/>
<main class="py-4">
  <div class="container-1200 d-flex gap-24">
    <jsp:include page="/mapper/sidebar.jsp"/>

    <section class="flex-1 notice-view">
      <div class="card-white p-20">
        <c:choose>
          <c:when test="${not empty notice}">
            <div class="title">
              <c:out value="${notice.title}"/>
            </div>

            <div class="meta">
              분류: <c:out value="${notice.category}"/>
              · 작성자: <c:out value="${notice.author}"/>
              · 게시일:
              <fmt:formatDate value="${notice.publishAt}" pattern="yyyy-MM-dd" var="pubDate"/>
              <c:choose>
                <c:when test="${not empty pubDate}">
                  ${pubDate}
                </c:when>
                <c:otherwise>
                  <c:out value="${notice.publishAt}"/>
                </c:otherwise>
              </c:choose>
            </div>


            <div class="content">
              <c:out value="${empty notice.content ? '(내용 없음)' : notice.content}"/>
            </div>
          </c:when>

          <c:otherwise>
            <div class="title">존재하지 않는 공지입니다.</div>
          </c:otherwise>
        </c:choose>

        <div class="mt-4 text-end">
          <!-- 목록으로: 라우팅에 맞춰 수정 (예: /notice/list, /pages/notice.jsp 등) -->
          <a href="<c:url value='/static/templates/pages/common/notice.jsp'/>" class="btn btn-outline-navy rounded-pill">목록으로</a>
        </div>
      </div>
    </section>
  </div>
</main>
<jsp:include page="/mapper/footer.jsp"/>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- (선택) AJAX include 방식을 유지하고 싶다면 아래 주석을 해제하고,
     상단의 jsp:include 는 지우세요. 실제 경로에 맞게 수정 필요.
<script>
  $(function () {
    $('#header').load('/mapper/header.html');
    $('#sidebar').load('/mapper/sidebar.html');
    $('#footer').load('/mapper/footer.html');
  });
</script>
-->
</body>
</html>
