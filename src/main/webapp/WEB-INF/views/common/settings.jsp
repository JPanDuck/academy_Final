<!DOCTYPE html><html lang="ko"><head>
<meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<title>수강 신청</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
<link rel="stylesheet" href="/css/style.css"/>
</head><body class="bg-page">
<div id="header"></div>
<main class="py-4"><div class="container-1200 d-flex gap-24"><div id="sidebar"></div>
<section class="flex-1">
  <div class="fw-700 fs-5 mb-12">설정</div>
  <div class="card-white p-20">설정</div>
</section></div></main>
<div id="footer"></div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="script/common-ui.js"></script><script src="script/app.js"></script>
<!-- ✅ 공통 include: static/mapper/... -->
<script>
  $(function () {
    $("#header").load("/mapper/header.html");
    $("#sidebar").load("/mapper/sidebar.html");
    $("#footer").load("/mapper/footer.html");
  });
</script>
</body></html>
