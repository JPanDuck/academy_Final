// server.js (프로젝트 루트)
const path = require("path");
const express = require("express");
const app = express();

const STATIC_DIR = path.join(__dirname, "src", "main", "resources", "static");

// 정적 루트를 사이트 루트에 마운트 ( /css, /js, /mapper, /pages 모두 접근 )
app.use(express.static(STATIC_DIR, { index: false }));

// /, /index, /index.html 은 /static/pages/index.html 로 고정
app.get(["/", "/index", "/index.html"], (_req, res) => {
    res.sendFile(path.join(STATIC_DIR, "pages", "index.html"));
});

// 나머지는 정적 서빙에 맡김(예: /pages/notice.html, /mapper/header.html 등)
app.use((req, res) => res.status(404).send("Not found: " + req.originalUrl));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`✅ http://localhost:${PORT}`));
