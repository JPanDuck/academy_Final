DROP TABLE log_history CASCADE CONSTRAINTS;

-- 접속 기록 관리 / log_history
CREATE TABLE log_history (
                             id NUMBER PRIMARY KEY,
                             user_id NUMBER NOT NULL,
                             username VARCHAR2(50) NOT NULL,
                             login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                             logout_time TIMESTAMP,
                             ip_address VARCHAR2(50),
                             CONSTRAINT fk_log_user FOREIGN KEY (user_id) REFERENCES users(id)
);


-- 로그인 ID 자동생성 / id_sequences
CREATE TABLE id_sequence(
                            sequence_key VARCHAR2(255) PRIMARY KEY,
                            sequence_num NUMBER(5,0) NOT NULL
);

INSERT INTO id_sequence (sequence_key, sequence_num) VALUES ('PROFESSOR', 0);
INSERT INTO id_sequence (sequence_key, sequence_num) VALUES ('STAFF', 0);

SELECT * FROM id_sequence;


-- USER / 모든 사용자의 기본 정보
CREATE TABLE users (
                       id NUMBER PRIMARY KEY,
                       username VARCHAR(255) UNIQUE,			-- 로그인에 사용하는 ID(학번, 교수번호 등)
                       password_temp NUMBER(1) DEFAULT 1,		-- 임시 비밀번호 상태인지 확인 (1: 임시비번, 0: 임시비번 아님)
                       email VARCHAR2(255) UNIQUE,
                       password VARCHAR2(255) NOT NULL,
                       phone VARCHAR2(255),
                       name VARCHAR2(20) NOT NULL,
                       role VARCHAR2(20) DEFAULT 'USER' NOT NULL
);


-- 권한 / roles / 데이터 삽입 필요
CREATE TABLE roles (
                       id NUMBER(10) PRIMARY KEY,			-- roles 고유 ID
                       role_name VARCHAR2(100) NOT NULL    -- 'ROLE_ADMIN', 'ROLE_PROPESSOR','ROLE_STUDENT', 'ROLE_ADVISOR'
);


-- 학과 / dept
CREATE TABLE dept (
                      id NUMBER PRIMARY KEY,  				-- 학과 고유ID / 학과 코드
                      dept_name VARCHAR2(100) NOT NULL		-- 학과 이름
);

INSERT INTO dept (id, dept_name) VALUES (1, '컴퓨터공학과');
SELECT * FROM dept;


-- 학기 / semester
CREATE TABLE semester(
                         id NUMBER PRIMARY KEY	-- 학기 (1~8)
);


-- PROFESSOR / 교수 고유 정보
CREATE TABLE professor (
                           id NUMBER PRIMARY KEY,						-- 고유 ID
                           professor_num VARCHAR2(20) UNIQUE NOT NULL,	-- 교수번호
                           created_at DATE ,							-- 입사일
                           ended_at DATE,								-- 퇴사일
                           dept_id NUMBER NOT NULL,
                           user_id NUMBER UNIQUE NOT NULL,
                           CONSTRAINT fk_professor_dept FOREIGN KEY (dept_id) REFERENCES dept(id),
                           CONSTRAINT fk_professor_user FOREIGN KEY (user_id) REFERENCES users(id)
);


-- STUDENT / 학생 고유 정보
CREATE TABLE student (
                         id NUMBER PRIMARY KEY,					    -- DB 내에서 행을 식별하기 위한 고유키
                         student_num VARCHAR2(20) UNIQUE NOT NULL,	-- 학번(연도+학과+순서)
                         status VARCHAR2(20) DEFAULT 'ACTIVE',		-- 상태 (재학중, 휴학중, 졸업) / ACTIVE, LEAVE, GRADUATED
                         created_at DATE ,							-- 입학일
                         ended_at DATE,							    -- 졸업일
                         dept_id NUMBER NOT NULL,
                         user_id NUMBER UNIQUE NOT NULL,
                         CONSTRAINT fk_student_dept FOREIGN KEY (dept_id) REFERENCES dept(id),
                         CONSTRAINT fk_student_user FOREIGN KEY (user_id) REFERENCES users(id)
);


-- STAFF / 교직원
CREATE TABLE staff (
                       id NUMBER PRIMARY KEY,					-- DB 내에서 행을 식별하기 위한 고유키
                       staff_num VARCHAR2(20) UNIQUE NOT NULL,	-- 사번(연도+순서)
                       created_at DATE ,						-- 입사일
                       ended_at DATE,							-- 퇴사일
                       user_id NUMBER UNIQUE NOT NULL,
                       CONSTRAINT fk_staff_user FOREIGN KEY (user_id) REFERENCES users(id)
);


-- 지도교수 / advisor
CREATE TABLE advisor (
                         id NUMBER PRIMARY KEY,
                         professor_id NUMBER NOT NULL,
                         student_id NUMBER UNIQUE NOT NULL,
                         CONSTRAINT fk_advisor_professor FOREIGN KEY (professor_id) REFERENCES professor(id),
                         CONSTRAINT fk_advisor_student FOREIGN KEY (student_id) REFERENCES student(id)
);


-- 과목 / subject
CREATE TABLE subject (
                         id NUMBER PRIMARY KEY, 				-- 학과 고유ID
                         name VARCHAR2(100) NOT NULL,		-- 과목명
                         credit NUMBER(2) NOT NULL,			-- 이수학점
                         professor_id NUMBER NOT NULL,		-- 교수 고유번호(담당교수)
                         CONSTRAINT FK_subject_professor FOREIGN KEY (professor_id) REFERENCES professor(id),
                         dept_id NUMBER NOT NULL,
                         CONSTRAINT FK_subject_dept FOREIGN KEY (dept_id) REFERENCES dept(id)
);


-- 강의 / course
CREATE TABLE course (
                        id NUMBER PRIMARY KEY,
                        place VARCHAR(100) NOT NULL,  		    --강의실
                        day_of_week VARCHAR2(3) NOT NULL,       -- MON, TUE, WED …
                        start_period NUMBER(2) NOT NULL,    	-- 1(교시 시작)
                        end_period NUMBER(2) NOT NULL,       	-- 3(교시 끝)
                        capacity NUMBER(4) NOT NULL,      		-- 수강 정원
                        semester_id NUMBER,
                        CONSTRAINT FK_course_semester FOREIGN KEY (semester_id) REFERENCES semester(id),
                        subject_id NUMBER,
                        CONSTRAINT FK_course_subject FOREIGN KEY (subject_id) REFERENCES subject(id)
);


-- 수강신청 / enrollment
CREATE TABLE enrollment(
                           id NUMBER PRIMARY KEY,
                           course_id NUMBER NOT NULL,
                           student_id NUMBER NOT NULL,
                           CONSTRAINT FK_enrollment_course FOREIGN KEY (course_id) REFERENCES course(id),
                           CONSTRAINT FK_enrollment_student FOREIGN KEY (student_id) REFERENCES student(id),
                           CONSTRAINT UQ_enrollment_course_student UNIQUE (course_id, student_id)	-- 중복 수강신청 방지
);


-- 성적 / grade
CREATE TABLE grade(
                      id NUMBER PRIMARY KEY,
                      alphabet VARCHAR2(20) NOT NULL,		-- 점수 (A+,A,~F)
                      GPA NUMBER(2,1) NOT NULL,		    -- 평균 학점 (3.5)
                      score NUMBER(2,1) NOT NULL,		    -- 취득 학점 (3.5)
                      total_int NUMBER(3) NOT NULL,		-- 총점(자연수)(예: 90, 80)
                      student_id NUMBER,
                      CONSTRAINT FK_grade_student FOREIGN KEY (student_id) REFERENCES student(id),
                      enrollment_id NUMBER,
                      CONSTRAINT FK_grade_enrollment FOREIGN KEY (enrollment_id) REFERENCES enrollment(id)
);


-- 공지 / notice
CREATE TABLE notice (
                        id NUMBER PRIMARY KEY,				    -- 고유 ID
                        title VARCHAR2(100) NOT NULL,			-- 제목
                        content CLOB NOT NULL,				    -- 내용
                        start_date DATE NOT NULL,				-- 시작 일자
                        end_date DATE NOT NULL,				    -- 종료 일자
                        created_at DATE DEFAULT SYSDATE,		-- 생성일
                        deadline DATE,						    -- 미리알림(연/월/일 선택)
                        view_count NUMBER DEFAULT 0,			-- 조회수
                        is_urgent NUMBER(1) DEFAULT 0 NOT NULL, -- 긴급공지 여부 (1: 긴급, 0: 일반)
                        is_sent NUMBER(1) DEFAULT 0 NOT NULL	-- 중복 알림 방지 (0: 미발송, 1: 발송)
);


-- 재발급용 토큰 테이블 / refresh_tokens
CREATE TABLE refresh_tokens (
                                id NUMBER PRIMARY KEY,              	-- 고유 ID
                                user_id NUMBER NOT NULL,			-- 리프레시 토큰 소유자의 id
                                token VARCHAR2(2000) NOT NULL,      	-- 실제 리프레시 토큰 문자열
                                expiry_date DATE NOT NULL,       	    	--만료일자 (자동삭제위함)
                                CONSTRAINT fk_refresh_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


-- approved: 심사승인(졸업확정) , postponed: 졸업유예
-- completed: 수료 , rejected: 졸업 심사 반려(재학)
-- 졸업 (졸업 요건 확인 및 심사 상태) / graduations
CREATE TABLE graduation (
                            id NUMBER PRIMARY KEY,
                            requirements_status VARCHAR2(20) NOT NULL,		-- 졸업 요건 자동 체크 결과 (met: 요건 충족 / not_met: 요건 미충족)
                            status VARCHAR2(20) DEFAULT 'pending_review' NOT NULL,	-- 졸업 심사에 따른 상태값
                            created_at DATE DEFAULT SYSDATE,
                            advisor_id NUMBER NOT NULL,
                            student_id NUMBER NOT NULL,
                            CONSTRAINT fk_gradu_advisor FOREIGN KEY (advisor_id) REFERENCES advisor(id),
                            CONSTRAINT fk_gradu_student FOREIGN KEY (student_id) REFERENCES student(id),
                            CONSTRAINT chk_status CHECK (status IN ('approved', 'postponed', 'completed', 'rejected')),
                            CONSTRAINT chk_req_status CHECK (requirements_status IN ('met', 'not_met'))
);


-- 캘린더 / calendar
CREATE TABLE calendar (
                          id NUMBER PRIMARY KEY,
                          title VARCHAR2(255) NOT NULL,	-- 제목
                          start_date DATE NOT NULL,		-- 시작 일자
                          end_date DATE NOT NULL,		    -- 종료 일자
                          created_at DATE DEFAULT SYSDATE,
                          user_id NUMBER NOT NULL,		-- 작성자 (관리자)
                          CONSTRAINT fk_calendar_user FOREIGN KEY (user_id) REFERENCES users(id)
);


-- 알림 /notification
CREATE TABLE notification (
                              noti_id NUMBER PRIMARY KEY,
                              noti_type VARCHAR2(50) NOT NULL, 	-- '성적이의신청', '비밀번호초기화' 등
                              target_id NUMBER, 				    -- 관련된 엔티티의 ID (예: 비밀번호 초기화가 필요한 학생의 ID)
                              created_at DATE DEFAULT SYSDATE,	-- 생성일
                              title VARCHAR2(200) NOT NULL,		-- 알림 제목
                              is_resolved NUMBER(1) DEFAULT 0, 	-- 0: 미확인, 1: 확인
                              related_id NUMBER,				    -- 모든 알림에 대한 범용적인 관련ID
                              grade_id NUMBER,
                              CONSTRAINT fk_noti_grade FOREIGN KEY (grade_id) REFERENCES grade(id),
                              notice_id NUMBER,
                              CONSTRAINT fk_noti_notice FOREIGN KEY (notice_id) REFERENCES notice(id),
                              CONSTRAINT fk_noti_user FOREIGN KEY (target_id) REFERENCES users(id)
);


-- ===== CREATE SEQUENCES =====
CREATE SEQUENCE log_history_seq START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE student_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE professor_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE advisor_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE staff_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE role_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE refresh_tokens_seq START WITH 1 INCREMENT BY 1;
--CREATE SEQUENCE dept_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE subject_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE course_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE enrollment_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE grade_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE graduation_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE notification_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE notice_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE calendar_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE semester_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 8 CYCLE NOCACHE;


--관리자 계정(테스트용)
INSERT INTO users(id, username, password, password_temp, name, email, role, phone)
VALUES (
           user_seq.NEXTVAL,
           'admin',                --로그인ID
           '$2a$10$TjEx.NZBVvxzKwyZ20UBfOlUgPIWNLsl.ja5xVqkuqtTSy3TrTA5G', --암호화된 비밀번호
           0,
           '관리자',                --이름
           'admin@ac.kr',          --이메일
           'ROLE_ADMIN',           --권한
           '010-0000-0000'         --전화번호
       );

COMMIT;

SELECT * FROM users;
SELECT * FROM student;
SELECT * FROM notice;

--DELETE FROM users;
--DROP TABLE users CASCADE CONSTRAINTS;

--DROP SEQUENCE notification_seq;

SELECT table_name FROM user_tables;
SELECT sequence_name FROM user_sequences;