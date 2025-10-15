package com.ac.kr.academy.service.user;




public interface StudentService {
    /**
     * 강의 폐강 시 학생에게 학점을 반환하고 관련 학점을 업데이트합니다.
     * 이 메서드는 학생의 '총 신청 학점'을 감소시키는 등의 트랜잭션을 처리합니다.
     * * @param userId 학생과 연결된 User 테이블의 고유 ID (StudentMapper에서 findByUserId를 사용하기 위함)
     * @param credit 반환할 학점 수 (양수)
     */
    void returnCredit(Long userId, int credit);

}
