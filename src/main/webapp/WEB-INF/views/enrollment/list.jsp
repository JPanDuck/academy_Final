<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>수강 신청</title>
</head>
<body>
<h1>강의 목록</h1>

<c:if test="${not empty message}">
<p>${message}</p>
</c:if>
<c:if test="${not empty error}">
<p>${error}</p>
</c:if>
<table border="1">
    <thead>
    <tr>
        <th>강의 이름</th>
        <th>담당 교수</th>
        <th>학점</th>
        <th>수강신청</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="course" items="${courseList}">
        <tr>
            <td>${course.subjectName} </td>
            <td>${course.professorName}</td>
            <td>${course.credit}</td>
            <td>
                <c:choose>
                    <c:when test="${enrolledCourseIds.contains(course.id)}">
                        <button>취소</button>
                    </c:when>
                    <c:otherwise>
                        <form action="/enrollments/${course.id}" method="post" style="display:inline;">
                            <button type="submit">신청</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div style="margin-bottom: 20px;">
    <a href="/enrollments/my-courses">
        <button>내가 신청한 강의 목록</button>
    </a>
</div>
</body>
</html>
