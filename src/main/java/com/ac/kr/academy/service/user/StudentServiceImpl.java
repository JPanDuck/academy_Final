package com.ac.kr.academy.service.user;


import com.ac.kr.academy.mapper.user.student.StudentMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class StudentServiceImpl implements StudentService {

    private final StudentMapper studentMapper;

    @Override
    @Transactional
    public void returnCredit(Long studentId, int credit) {
        // 학생의 '현재 신청 학점'을 폐강된 학점만큼 감소
        // credit은 양수이므로, 감소시키기 위해 -credit으로 전달합니다.
        studentMapper.updateStudentEnrolledCredits(studentId, -credit);
    }
}