<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의 목록</title>
</head>
<body>
<div>
    <h1>강의 목록</h1>
    <c:if test="${not empty message}">
        <div>
                ${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div>
                ${error}
        </div>
    </c:if>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
        <div>
            <%-- 1. 강의 개설 버튼: 교수 권한만 표시 --%>
            <sec:authorize access="hasRole('PROFESSOR')">
                <a href="/courses/add" class="btn btn-primary">강의 개설</a>
            </sec:authorize>

            <%-- 2. 폐강 후보 목록 버튼: 관리자 권한일 때만 표시 --%>
            <sec:authorize access="hasRole('ADMIN')">
                <c:choose>
                    <c:when test="${requestDTO.searchType == 'candidates'}">
                        <%-- 현재 폐강 후보 목록 페이지일 경우 일반 목록으로 돌아가는 버튼 표시 --%>
                        <a href="/courses" class="btn btn-secondary">전체 강의 목록</a>
                    </c:when>
                    <c:otherwise>
                        <%-- 일반 강의 목록 페이지일 경우 폐강 후보 목록 버튼 표시 --%>
                        <a href="/courses?searchType=candidates" class="btn btn-warning">정원 미달 강의 폐강 후보 목록</a>
                    </c:otherwise>
                </c:choose>
            </sec:authorize>
        </div>

        <%-- 3. 항목 수 선택 UI (Page Size Selector) --%>
        <div class="page-size-selector">
            <label for="pageSizeSelect">항목 수:</label>
            <select id="pageSizeSelect" onchange="changePageSize(this.value)">
                <option value="10" ${requestDTO.pageSize == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${requestDTO.pageSize == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${requestDTO.pageSize == 50 ? 'selected' : ''}>50개</option>
            </select>
        </div>
    </div>

    <%-- 4. 검색 폼 --%>
    <form action="/courses" method="get" class="search-form" id="searchForm">
        <input type="hidden" name="pageSize" value="${requestDTO.pageSize}">
        <input type="hidden" name="page" value="1">
        <input type="hidden" name="sort" value="${requestDTO.sort}">

        <select name="searchType">
            <option value="">전체</option>
            <option value="subject" ${requestDTO.searchType == 'subject' ? 'selected' : ''}>과목명</option>
            <option value="professor" ${requestDTO.searchType == 'professor' ? 'selected' : ''}>교수명</option>
            <option value="dept" ${requestDTO.searchType == 'dept' ? 'selected' : ''}>학과명</option>
        </select>
        <input type="text" name="searchKeyword" value="${requestDTO.searchKeyword}" placeholder="검색어를 입력하세요">
        <button type="submit">검색</button>
        <button type="button" onclick="location.href='/courses'">초기화</button>
    </form>


    <c:choose>
        <c:when test="${not empty pageResult.dtoList}">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th><a href="javascript:changeSort('subject')">과목명</a></th>
                    <th><a href="javascript:changeSort('professor')">교수명</a></th>
                    <th>수강인원</th>
                    <th>정원</th>
                    <th>요일</th>
                    <th>시간</th>
                    <th>장소</th>
                    <th>학점</th>
                    <th>상태</th>
                        <%-- 관리 권한이 있는 사용자에게만 컬럼 표시 --%>
                    <sec:authorize access="hasAnyRole('ADMIN', 'PROFESSOR')">
                        <th>관리</th>
                    </sec:authorize>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="course" items="${pageResult.dtoList}">
                    <tr>
                        <td>${course.id}</td>
                        <td>${course.subjectName}</td>
                        <td>${course.professorName}</td>
                        <td>${course.numOfStudent}</td>
                        <td>${course.capacity}</td>
                        <td>${course.dayOfWeek}</td>
                        <td>${course.time}</td>
                        <td>${course.place}</td>
                        <td>${course.credit}</td>
                        <td>
                            <span>${course.status}</span>
                        </td>

                            <%-- 관리 버튼들: 수정, 삭제, 폐강 버튼 권한 설정 --%>
                        <sec:authorize access="hasAnyRole('ADMIN', 'PROFESSOR')">
                            <td>
                                    <%-- 수정 (교수/관리자) --%>
                                <a href="/courses/edit/${course.id}">수정</a>

                                    <%-- 삭제 (교수/관리자) --%>
                                <form action="/courses/delete/${course.id}" method="post"
                                      onsubmit="return confirm('정말로 이 강의를 삭제하시겠습니까?');" style="display:inline;">
                                    <button type="submit">삭제</button>
                                </form>

                                <c:if test="${course.status eq '개설'}">
                                    <sec:authorize access="hasRole('ADMIN')">
                                        <form action="/courses/close/${course.id}" method="post"
                                              onsubmit="return confirm('정말로 이 강의를 폐강하시겠습니까?');" style="display:inline;">
                                            <button type="submit">폐강</button>
                                        </form>
                                    </sec:authorize>
                                </c:if>
                            </td>
                        </sec:authorize>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <%-- 5. 페이지네이션 블록 --%>
            <div class="pagination">
                <c:if test="${pageResult.prev}">
                    <a href="javascript:movePage(${pageResult.start - 1})">이전</a>
                </c:if>

                <c:forEach begin="${pageResult.start}" end="${pageResult.end}" var="num">
                    <c:choose>
                        <c:when test="${num == pageResult.page}">
                            <span class="current-page">${num}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:movePage(${num})">${num}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${pageResult.next}">
                    <a href="javascript:movePage(${pageResult.end + 1})">다음</a>
                </c:if>
                <p>총 ${pageResult.total}개 강의</p>
            </div>


        </c:when>
        <c:otherwise>
            <p>등록된 강의가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // URL 조작을 위한 공통 함수
    function updateUrlParams(params) {
        const url = new URL(window.location.href);

        // 기존 검색 파라미터 유지
        const searchKeyword = url.searchParams.get('searchKeyword');
        const searchType = url.searchParams.get('searchType');
        const pageSize = url.searchParams.get('pageSize');
        const sort = url.searchParams.get('sort');

        // 기본 파라미터를 먼저 설정
        url.searchParams.set('searchKeyword', params.searchKeyword !== undefined ? params.searchKeyword : (searchKeyword || ''));
        url.searchParams.set('searchType', params.searchType !== undefined ? params.searchType : (searchType || ''));
        url.searchParams.set('pageSize', params.pageSize !== undefined ? params.pageSize : (pageSize || 10)); // 기본 10
        url.searchParams.set('sort', params.sort !== undefined ? params.sort : (sort || ''));

        // 업데이트될 파라미터 적용
        if (params.page !== undefined) {
            url.searchParams.set('page', params.page);
        }

        // 빈 값 파라미터는 제거하여 URL을 깔끔하게 유지
        url.searchParams.forEach((value, key) => {
            if (value === '' || value === 'null') {
                url.searchParams.delete(key);
            }
        });

        window.location.href = url.toString();
    }

    // 항목 수 변경 (Page Size Selector)
    function changePageSize(size) {
        updateUrlParams({ pageSize: size, page: 1 });
    }

    // 페이지 이동 (Pagination)
    function movePage(pageNumber) {
        updateUrlParams({ page: pageNumber });
    }

    // 정렬 변경 (Table Header)
    function changeSort(sortField) {
        updateUrlParams({ sort: sortField, page: 1 });
    }
</script>