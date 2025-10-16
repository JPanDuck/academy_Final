package com.ac.kr.academy.security;

import com.ac.kr.academy.domain.user.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

@Slf4j
public class CustomUserDetails implements UserDetails {

    private final User user;

    public CustomUserDetails(User user) {
        this.user = user;
    }

    public User getUser(){
        return user;
    }

    public Long getUserId() {
        // User 객체에서 고유 ID를 가져와 반환합니다.
        // (User 도메인 클래스에 getId() 메서드가 있다고 가정합니다.)
        return user.getId();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(new SimpleGrantedAuthority(user.getRole()));
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    public String getName() { return user.getName(); }

    // 계정 만료 여부 - 만료X
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // 계정 잠금 여부 - 잠금X
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 비밀번호 만료 여부 - 만료X
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 계정 활성화 여부 - 활성화
    @Override
    public boolean isEnabled() {
        return true;
    }
}
