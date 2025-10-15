<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>공지사항</title>

  <!-- Fonts & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>

  <!-- 공통 스타일 (네 프로젝트 경로 유지) -->
  <link rel="stylesheet" href="/static/css/style.css"/>

  <!-- jQuery, Bootstrap -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    #noticeTable th, #noticeTable td { font-size:13px }
    .title-cell .title { font-weight:700 }
    .title-cell .meta  { color:var(--gray-500); font-size:12px; margin-top:2px }
  </style>
</head>
<body class="bg-page">
<!-- 공통 레이아웃 include -->
<jsp:include page="/mapper/header.jsp" />

<main class="py-4">
  <div class="container-1200 d-flex gap-24">
    <jsp:include page="/mapper/sidebar.jsp" />

    <section class="flex-1">
      <div class="fw-700 fs-5 mb-12">공지사항</div>

      <!-- 검색/필터: 서버 GET 기반 -->
      <div class="card-white p-20 mb-16">
        <form id="filterForm" class="row g-3" method="get" action="${pageContext.request.contextPath}/notice/list">
          <div class="col-12 col-md-5">
            <input name="q" id="q" type="text" class="form-control" placeholder="제목 / 본문 검색"
                   value="${param.q}"/>
          </div>
          <div class="col-6 col-md-3">
            <select name="category" id="category" class="form-select">
              <option value="">분류(전체)</option>
              <option value="학사"  ${param.category=='학사'?'selected':''}>학사</option>
              <option value="장학"  ${param.category=='장학'?'selected':''}>장학</option>
              <option value="행사"  ${param.category=='행사'?'selected':''}>행사</option>
            </select>
          </div>
          <div class="col-6 col-md-2">
            <input name="from" id="from" type="date" class="form-control" value="${param.from}"/>
          </div>
          <div class="col-6 col-md-2">
            <button class="btn btn-navy rounded-pill w-100">검색</button>
          </div>
        </form>
      </div>

      <!-- 목록 -->
      <div class="card-white p-20">
        <div class="d-flex justify-content-between align-items-center mb-12">
          <div class="fw-700">공지 목록</div>
          <div class="xsmall text-gray-500"><span id="resultCount"><c:out value="${totalCount != null ? totalCount : fn:length(notices)}"/></span>건</div>
        </div>

        <div class="table-wrap">
          <table class="table align-middle" id="noticeTable">
            <thead>
            <tr>
              <th style="width:90px">번호</th>
              <th>제목</th>
              <th style="width:120px">분류</th>
              <th style="width:140px">작성자</th>
              <th style="width:120px">게시일</th>
            </tr>
            </thead>
            <tbody id="noticeTbody">
            <c:if test="${empty notices}">
              <tr><td colspan="5" class="text-center text-gray-500 xsmall">표시할 공지가 없습니다.</td></tr>
            </c:if>

            <!-- today 문자열(yyyy-MM-dd) 생성 -->
            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" var="todayStr"/>

            <c:forEach var="n" items="${notices}" varStatus="st">
              <!--
                표시 조건(클라이언트 버전과 동일한 가시성 규칙):
                1) status == 'PUBLISHED'
                2) status == 'SCHEDULED' 이고 publishAt <= today
                * publishAt은 'yyyy-MM-dd' 문자열 또는 java.util.Date라고 가정
              -->
              <c:set var="status" value="${n.status}"/>
              <c:choose>
                <c:when test="${n.publishAt instanceof java.util.Date}">
                  <fmt:formatDate value="${n.publishAt}" pattern="yyyy-MM-dd" var="publishStr"/>
                </c:when>
                <c:otherwise>
                  <c:set var="publishStr" value="${n.publishAt}"/>
                </c:otherwise>
              </c:choose>

              <c:if test="${status == 'PUBLISHED' || (status == 'SCHEDULED' && publishStr <= todayStr)}">
                <tr>
                  <td>
                    <c:out value="${(totalCount != null ? totalCount : fn:length(notices)) - ( (page-1) * size + st.index )}"/>
                  </td>
                  <td class="title-cell">
                    <a href="${pageContext.request.contextPath}/notice/view?id=${n.id}" class="title">
                      <c:out value="${n.title}"/>
                    </a>
                    <div class="meta">게시일 <c:out value="${publishStr}"/></div>
                  </td>
                  <td><c:out value="${empty n.category ? '-' : n.category}"/></td>
                  <td><c:out value="${empty n.author ? '-' : n.author}"/></td>
                  <td><c:out value="${empty publishStr ? '-' : publishStr}"/></td>
                </tr>
              </c:if>
            </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- 빈 상태 문구 (서버측에서도 보이도록 보조 표기) -->
        <div id="emptyState" class="xsmall text-gray-500 mt-2" style="<c:out value='${empty notices ? "" : "display:none;"}'/>">
        표시할 공지가 없습니다.
      </div>

      <!-- 페이징 (서버 렌더링) : page, totalPages, size는 모델에서 제공 -->
      <c:if test="${totalPages > 1}">
        <nav class="mt-3">
          <ul id="pagination" class="pagination justify-content-center mb-0">
            <!-- 처음 -->
            <li class="page-item ${page == 1 ? 'disabled' : ''}">
              <a class="page-link" href="?q=${param.q}&category=${param.category}&from=${param.from}&page=1&size=${size}">&laquo;&laquo;</a>
            </li>

            <!-- 앞쪽 숫자/점3 -->
            <c:set var="start" value="${page - 2 < 1 ? 1 : page - 2}"/>
            <c:set var="end"   value="${page + 2 > totalPages ? totalPages : page + 2}"/>

            <c:if test="${start > 1}">
              <li class="page-item"><a class="page-link" href="?q=${param.q}&category=${param.category}&from=${param.from}&page=1&size=${size}">1</a></li>
              <c:if test="${start > 2}">
                <li class="page-item disabled"><span class="page-link">...</span></li>
              </c:if>
            </c:if>

            <c:forEach var="i" begin="${start}" end="${end}">
              <li class="page-item ${i == page ? 'active' : ''}">
                <a class="page-link" href="?q=${param.q}&category=${param.category}&from=${param.from}&page=${i}&size=${size}">${i}</a>
              </li>
            </c:forEach>

            <c:if test="${end < totalPages}">
              <c:if test="${end < totalPages - 1}">
                <li class="page-item disabled"><span class="page-link">...</span></li>
              </c:if>
              <li class="page-item">
                <a class="page-link" href="?q=${param.q}&category=${param.category}&from=${param.from}&page=${totalPages}&size=${size}">${totalPages}</a>
              </li>
            </c:if>

            <!-- 마지막 -->
            <li class="page-item ${page == totalPages ? 'disabled' : ''}">
              <a class="page-link" href="?q=${param.q}&category=${param.category}&from=${param.from}&page=${totalPages}&size=${size}">&raquo;&raquo;</a>
            </li>
          </ul>
        </nav>
      </c:if>
  </div>
  </section>
  </div>
</main>

<jsp:include page="/mapper/footer.jsp" />

<!-- 클라이언트 즉시검색(선택): 입력 후 엔터 시 폼 제출, 버튼은 기존처럼 동작 -->
<script>
  $(function(){
    $('#filterForm').on('submit', function(){ /* 서버 GET 제출 */ });
    // 사용성이 필요하면 여기서 keyup debounce 로컬 필터 추가 가능
  });
</script>
</body>
</html>
