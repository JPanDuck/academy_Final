<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>시스템 관리 - 로그 모니터링</title>
</head>
<body>

<div>
    <button onclick="loadLogs()">새로고침</button>
    <pre id="logArea" style="background: black; color: white; padding: 10px; height: 400px;"></pre>
</div>

<script>
    async function loadLogs(){
        const jwtToken = localStorage.getItem('jwtToken');
        console.log("읽은 토큰:", jwtToken);

        //jwtToken 값이 null, undefined 또는 잘못된 문자열인지 확인
        if(!jwtToken){
            console.error("JWT 토큰이 로컬 스토리지에 없습니다. 로그인 상태를 확인하세요.");
            return;
        }

        try{
            const res = await fetch('/api/admin/logs/monitor', {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${jwtToken.trim()}`,
                    'Content-Type': 'application/json'
                }
            });
            if(!res.ok){
                throw new Error(`로그 API 호출 실패: ${res.status} ${res.statusText}`);
            }
            const logs = await res.json();
            const logArea = document.getElementById('logArea');
            logArea.innerText = logs.join("\n");
            logArea.scrollTop = logArea.scrollHeight;
        } catch (e){
            console.error("로그 로딩 실패: ", e);
            alert("로그 로딩에 실패했습니다. 관리자 권한을 확인해주세요.");
        }
    }
    //페이지 로드 시 바로 실행
    loadLogs();

    //5초마다 자동 새로고침
    // setInterval(loadLogs, 5000);
</script>

</body>
</html>
