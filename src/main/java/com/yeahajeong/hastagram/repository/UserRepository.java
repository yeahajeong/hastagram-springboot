package com.yeahajeong.hastagram.repository;

import com.yeahajeong.hastagram.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
    //아이디 중복 확인
    User findUserById(String id);

    //이메일 중복확인
    User findUserByEmail(String email);
}