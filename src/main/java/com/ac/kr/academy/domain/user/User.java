package com.ac.kr.academy.domain.user;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;

@Getter
@Setter
@Data
public class User {
    private Long id;
    private String name;
    private String email;
    private String role;
    private String phone;
    private String password;
    private Long deptId;

    private String username;        //로그인에 사용하는 ID(학번, 교수번호 등)
    private boolean passwordTemp;   //임시 비밀번호 상태인지 확인 (1: 임시비번, 0: 임시비번 아님)
    private LocalDateTime createdAt;
}
