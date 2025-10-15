<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>접속 기록 관리</title>
</head>
<!--페이징 적용 시 항상 마지막 페이지가 보이도록 해야함
    페이징 적용 시 page 파라미터를 API에 보내고, tbody 갱신 시 현재 페이지 유지 또는 마지막 페이지 보여주도록 해야 함-->
<body>
<table>
    <thead>
        <tr>
            <th scope="col">로그 ID</th>
            <th scope="col">사용자 ID</th>
            <th scope="col">IP 주소</th>
            <th scope="col">로그인 시간</th>
            <th scope="col">로그아웃 시간</th>
        </tr>
    </thead>
    <tbody id="tbody">
        <tr>
            <td colspan="5">데이터 로딩중...</td>
        </tr>
    </tbody>
</table>

<script>
    function loadHistory(){
        const tableBody = document.getElementById('tbody');

        fetch('/api/admin/logs/history')
            .then(response => {
                if(!response.ok){
                    throw new Error('네트워크 응답이 올바르지 않습니다.');
                }
                return response.json();
            })
            .then(logs => {
                const tableBody = document.getElementById('tbody');
                if(logs.length > 0){
                    let rows = '';
                    logs.forEach(log => {
                        rows += `
                            <tr>
                                <td>${log.id}</td>
                                <td>${log.username}</td>
                                <td>${log.ipAddress}</td>
                                <td>${log.loginTimeStr}</td>
                                <td>${log.logoutTimeStr ? log.logoutTimeStr : '-'}</td>
                            </tr>
                        `;
                    });
                    tableBody.innerHTML = rows;
                }else {
                    tableBody.innerHTML = '<tr><td colspan="5">접속 기록이 없습니다.</td></tr>';
                }
            })
            .catch(error => {
                console.error('데이터를 가져오는 중 오류가 발생했습니다.', error);
                tableBody.innerHTML = '<tr><td colspan="5">데이터 로딩에 실패했습니다.</td></tr>';
            });
    }

    document.addEventListener('DOMContentLoaded', function (){
        loadHistory();      //페이지 로드 시 바로 실행
        setInterval(loadHistory, 5000); //5초마다 자동 새로고침
    });
</script>
</body>
</html>